import argparse, json, os, sys, time
import re

try:
    import numpy as np
except ImportError:
    np = None

NL=12; NH=12; DM=768; DH=64; DF=3072; VS=50257; CTX=1024

def align64(v): return (v+63)&~63

def compute_layout():
    L={}; off=0
    def r(n,s):
        nonlocal off; L[n]=off; off=align64(off+s)
    r('wq',NL*DM*DM);r('wk',NL*DM*DM);r('wv',NL*DM*DM);r('wo',NL*DM*DM)
    r('w1',NL*DF*DM);r('w2',NL*DM*DF);r('wlogit',VS*DM)
    r('wq_bias',NL*DM*4);r('wk_bias',NL*DM*4)
    r('wv_bias',NL*DM*4);r('wo_bias',NL*DM*4)
    r('w1_bias',NL*DF*4);r('w2_bias',NL*DM*4)
    r('ln1_w',NL*DM*4);r('ln1_b',NL*DM*4)
    r('ln2_w',NL*DM*4);r('ln2_b',NL*DM*4)
    r('fln_w',DM*4);r('fln_b',DM*4)
    r('ln1_eps',NL*4);r('ln2_eps',NL*4);r('fln_eps',4)
    r('pos_embed',CTX*DM)
    L['w_size']=off
    return L

def load_i8(data,off,rows,cols):
    return np.frombuffer(data[off:off+rows*cols],dtype=np.int8).reshape(rows,cols).copy()

def load_q16(data,off,n):
    return np.frombuffer(data[off:off+n*4],dtype=np.int32).copy().astype(np.float64)/(2**16)

def layernorm(x, gamma, beta, eps=1e-5):
    mean=np.mean(x); var=np.var(x)
    return gamma * (x - mean) / np.sqrt(var + eps) + beta

def gelu(x):
    return 0.5*x*(1.0+np.tanh(np.sqrt(2.0/np.pi)*(x+0.044715*x**3)))

def int8_matmul_perchannel(x_int8, w_int8, x_scale, w_scales, bias):
    """int8 x int8 -> int32, dequant with per-channel weight scales, add bias.
    w_scales: [out_dim] float array, one scale per output row."""
    acc = np.dot(w_int8.astype(np.int32), x_int8.astype(np.int32))  # [out_dim]
    result = acc.astype(np.float64) * x_scale * w_scales.astype(np.float64)
    result += bias
    return result

def sanitize_cpp_expr(expr: str) -> str:
    expr = expr.split("//", 1)[0].strip()
    expr = expr.replace("sizeof(int32_t)", "4")
    expr = expr.replace("sizeof(uint32_t)", "4")
    expr = re.sub(r"static_cast<[^>]+>\(", "(", expr)
    expr = re.sub(r"\b(0x[0-9A-Fa-f]+|\d+)([uUlL]+)\b", r"\1", expr)
    expr = expr.replace("/", "//")
    return expr

def parse_shared_params_cpp(shared_params_path: str) -> dict[str, int]:
    values: dict[str, int] = {}
    env = {
        "align64_u32": lambda v: (v + 63) & ~63,
        "align64_u64": lambda v: (v + 63) & ~63,
        "max2_constexpr": max,
        "min2_constexpr": min,
    }
    constexpr_re = re.compile(
        r"^\s*constexpr\s+[^=;]+\s+([A-Za-z_]\w*)\s*=\s*(.+?);(?:\s*//.*)?$"
    )
    with open(shared_params_path, "r", encoding="utf-8") as f:
        for line in f:
            match = constexpr_re.match(line)
            if not match:
                continue
            name, expr = match.groups()
            expr = sanitize_cpp_expr(expr)
            try:
                values[name] = int(eval(expr, {"__builtins__": {}}, env | values))
            except Exception:
                continue
    return values

def compute_layout_int8(NL, DM, DF, VS, CTX):
    L={}; off=0
    def r(n,s):
        nonlocal off; L[n]=off; off=align64(off+s)
    r('wq',NL*DM*DM);r('wk',NL*DM*DM);r('wv',NL*DM*DM);r('wo',NL*DM*DM)
    r('w1',NL*DF*DM);r('w2',NL*DM*DF);r('wlogit',VS*DM)
    r('wq_bias',NL*DM*4);r('wk_bias',NL*DM*4)
    r('wv_bias',NL*DM*4);r('wo_bias',NL*DM*4)
    r('w1_bias',NL*DF*4);r('w2_bias',NL*DM*4)
    r('ln0_w',NL*DM*4);r('ln0_b',NL*DM*4)
    r('ln1_w',NL*DM*4);r('ln1_b',NL*DM*4)
    r('fln_w',DM*4);r('fln_b',DM*4)
    r('ln0_eps',NL*4);r('ln1_eps',NL*4);r('fln_eps',4)
    r('pos_embed',CTX*DM)
    L['weights_size']=off
    return L

def dump_layout_from_shared_params(shared_params_path: str) -> int:
    vals = parse_shared_params_cpp(shared_params_path)
    NLc = vals["NUM_LAYERS"]
    DMc = vals["D_MODEL"]
    DFc = vals["D_FFN"]
    VSc = vals["D_VOCAB"]
    CTXc = vals["CONTEXT_LENGTH"]

    L = compute_layout_int8(NLc, DMc, DFc, VSc, CTXc)
    mapping = {
        "WQ_OFF": L["wq"],
        "WK_OFF": L["wk"],
        "WV_OFF": L["wv"],
        "WO_OFF": L["wo"],
        "W1_OFF": L["w1"],
        "W2_OFF": L["w2"],
        "WLOGIT_OFF": L["wlogit"],
        "WQ_BIAS_OFF": L["wq_bias"],
        "WK_BIAS_OFF": L["wk_bias"],
        "WV_BIAS_OFF": L["wv_bias"],
        "WO_BIAS_OFF": L["wo_bias"],
        "W1_BIAS_OFF": L["w1_bias"],
        "W2_BIAS_OFF": L["w2_bias"],
        "LN0_GAMMA_OFF": L["ln0_w"],
        "LN0_BETA_OFF": L["ln0_b"],
        "LN1_GAMMA_OFF": L["ln1_w"],
        "LN1_BETA_OFF": L["ln1_b"],
        "FINAL_NORM_GAMMA_OFF": L["fln_w"],
        "FINAL_NORM_BETA_OFF": L["fln_b"],
        "LN0_EPS_OFF": L["ln0_eps"],
        "LN1_EPS_OFF": L["ln1_eps"],
        "FINAL_NORM_EPS_OFF": L["fln_eps"],
        "POS_EMBED_OFF": L["pos_embed"],
        "WEIGHTS_SIZE": L["weights_size"],
    }

    mismatches = []
    for k, expected in mapping.items():
        actual = vals.get(k, None)
        if actual is None or actual != expected:
            mismatches.append((k, actual, expected))

    print(f"[layout] shared_params={shared_params_path}")
    print(f"[layout] NL={NLc} DM={DMc} DF={DFc} VS={VSc} CTX={CTXc}")
    for name in ["wq","wk","wv","wo","w1","w2","wlogit","wq_bias","wk_bias","wv_bias","wo_bias","w1_bias","w2_bias",
                 "ln0_w","ln0_b","ln1_w","ln1_b","fln_w","fln_b","ln0_eps","ln1_eps","fln_eps","pos_embed"]:
        print(f"  {name:10s} off=0x{L[name]:08X}")
    print(f"  {'weights_size':10s} =0x{L['weights_size']:08X}")

    if mismatches:
        print("\nERROR: layout mismatches vs shared_params.hpp:")
        for k, actual, expected in mismatches:
            if actual is None:
                print(f"  {k}: missing (expected 0x{expected:08X})")
            else:
                print(f"  {k}: shared=0x{actual:08X} expected=0x{expected:08X}")
        return 1
    print("\nOK: layout matches shared_params.hpp constants.")
    return 0

class GPT2Int8:
    def __init__(self, model_dir):
        if np is None:
            raise RuntimeError("numpy is required for GPT2Int8 (pip install numpy)")
        L = compute_layout()
        self.L = L

        with open(os.path.join(model_dir, "quant_scales.json")) as f:
            self.scales = json.load(f)

        ddr_path = os.path.join(model_dir, "gpt2_weights_int8.bin")
        print(f"Loading {ddr_path}...")
        with open(ddr_path, "rb") as f:
            self.ddr = f.read()
        print(f"  {len(self.ddr):,} bytes")

        embed_path = os.path.join(model_dir, "embed_tokens.bin")
        with open(embed_path, "rb") as f:
            raw = f.read()
        self.embed_tokens = np.frombuffer(raw, dtype=np.int8).reshape(VS, DM).copy()
        self.embed_scale = self.scales["embed_tokens"]

        self.pos_embed = load_i8(self.ddr, L['pos_embed'], CTX, DM)
        self.pos_scale = self.scales["pos_embed"]

        print("Pre-loading layers...")
        lsq=DM*DM; ls1=DF*DM; ls2=DM*DF
        blsq=DM*4; bls1=DF*4; bls2=DM*4; gls=DM*4

        self.layers = []
        for ly in range(NL):
            ld = {}
            ld['wq'] = load_i8(self.ddr, L['wq']+ly*lsq, DM, DM)
            ld['wk'] = load_i8(self.ddr, L['wk']+ly*lsq, DM, DM)
            ld['wv'] = load_i8(self.ddr, L['wv']+ly*lsq, DM, DM)
            ld['wo'] = load_i8(self.ddr, L['wo']+ly*lsq, DM, DM)
            ld['w1'] = load_i8(self.ddr, L['w1']+ly*ls1, DF, DM)
            ld['w2'] = load_i8(self.ddr, L['w2']+ly*ls2, DM, DF)

            ld['sq'] = np.array(self.scales[f"layer{ly}.wq"], dtype=np.float64)
            ld['sk'] = np.array(self.scales[f"layer{ly}.wk"], dtype=np.float64)
            ld['sv'] = np.array(self.scales[f"layer{ly}.wv"], dtype=np.float64)
            ld['so'] = np.array(self.scales[f"layer{ly}.wo"], dtype=np.float64)
            ld['s1'] = np.array(self.scales[f"layer{ly}.w1"], dtype=np.float64)
            ld['s2'] = np.array(self.scales[f"layer{ly}.w2"], dtype=np.float64)
 
            ld['bq'] = load_q16(self.ddr, L['wq_bias']+ly*blsq, DM)
            ld['bk'] = load_q16(self.ddr, L['wk_bias']+ly*blsq, DM)
            ld['bv'] = load_q16(self.ddr, L['wv_bias']+ly*blsq, DM)
            ld['bo'] = load_q16(self.ddr, L['wo_bias']+ly*blsq, DM)
            ld['b1'] = load_q16(self.ddr, L['w1_bias']+ly*bls1, DF)
            ld['b2'] = load_q16(self.ddr, L['w2_bias']+ly*bls2, DM)
  
            ld['ln1_w'] = load_q16(self.ddr, L['ln1_w']+ly*gls, DM)
            ld['ln1_b'] = load_q16(self.ddr, L['ln1_b']+ly*gls, DM)
            ld['ln2_w'] = load_q16(self.ddr, L['ln2_w']+ly*gls, DM)
            ld['ln2_b'] = load_q16(self.ddr, L['ln2_b']+ly*gls, DM)
            self.layers.append(ld)

        self.fln_w = load_q16(self.ddr, L['fln_w'], DM)
        self.fln_b = load_q16(self.ddr, L['fln_b'], DM)
        self.wlogit = load_i8(self.ddr, L['wlogit'], VS, DM)
        self.wlogit_s = np.array(self.scales["lm_head"], dtype=np.float64)
        print("Model loaded.\n")

    def embed(self, token_id, position):
        tok = self.embed_tokens[token_id].astype(np.float64) * self.embed_scale
        pos = self.pos_embed[position].astype(np.float64) * self.pos_scale
        return tok + pos

    def quantize_act(self, x):
        amax = max(np.max(np.abs(x)), 1e-10)
        s = float(amax / 127.0)
        q = np.clip(np.round(x / s), -127, 127).astype(np.int8)
        return q, s

    def forward_layer(self, x, ly, kv_cache, pos):
        ld = self.layers[ly]


        h = layernorm(x, ld['ln1_w'], ld['ln1_b'])
        h_i8, h_s = self.quantize_act(h)

        q = int8_matmul_perchannel(h_i8, ld['wq'], h_s, ld['sq'], ld['bq'])
        k = int8_matmul_perchannel(h_i8, ld['wk'], h_s, ld['sk'], ld['bk'])
        v = int8_matmul_perchannel(h_i8, ld['wv'], h_s, ld['sv'], ld['bv'])

        kv_cache[ly]['k'][pos] = k
        kv_cache[ly]['v'][pos] = v

        q_heads = q.reshape(NH, DH)
        attn_out = np.zeros(DM)
        for head in range(NH):
            q_h = q_heads[head]
            scores = np.zeros(pos + 1)
            for t in range(pos + 1):
                k_t = kv_cache[ly]['k'][t].reshape(NH, DH)[head]
                scores[t] = np.dot(q_h, k_t) / np.sqrt(DH)
            scores -= np.max(scores)
            w = np.exp(scores); w /= np.sum(w) + 1e-10
            v_out = np.zeros(DH)
            for t in range(pos + 1):
                v_t = kv_cache[ly]['v'][t].reshape(NH, DH)[head]
                v_out += w[t] * v_t
            attn_out[head*DH:(head+1)*DH] = v_out

        ao_i8, ao_s = self.quantize_act(attn_out)
        o_out = int8_matmul_perchannel(ao_i8, ld['wo'], ao_s, ld['so'], ld['bo'])
        x = x + o_out
        h2 = layernorm(x, ld['ln2_w'], ld['ln2_b'])
        h2_i8, h2_s = self.quantize_act(h2)

        fc1 = int8_matmul_perchannel(h2_i8, ld['w1'], h2_s, ld['s1'], ld['b1'])
        fc1_act = gelu(fc1)
        fc1a_i8, fc1a_s = self.quantize_act(fc1_act)
        fc2 = int8_matmul_perchannel(fc1a_i8, ld['w2'], fc1a_s, ld['s2'], ld['b2'])
        x = x + fc2
        return x

    def forward(self, token_id, position, kv_cache):
        x = self.embed(token_id, position)
        for ly in range(NL):
            x = self.forward_layer(x, ly, kv_cache, position)
        x = layernorm(x, self.fln_w, self.fln_b)
        x_i8, x_s = self.quantize_act(x)
        acc = np.dot(self.wlogit.astype(np.int32), x_i8.astype(np.int32))
        logits = acc.astype(np.float64) * x_s * self.wlogit_s
        return logits

    def generate(self, token_ids, max_new_tokens=20):
        kv_cache = [{'k': np.zeros((CTX, DM)), 'v': np.zeros((CTX, DM))} for _ in range(NL)]
        generated = list(token_ids)

        print(f"Prefill ({len(token_ids)} tokens)...", end="", flush=True)
        for i, tid in enumerate(token_ids[:-1]):
            _ = self.forward(tid, i, kv_cache)
        print(" done.")

        pos = len(token_ids) - 1
        next_token = token_ids[-1]

        print(f"Generating (max {max_new_tokens} tokens)...")
        for i in range(max_new_tokens):
            t0 = time.time()
            logits = self.forward(next_token, pos, kv_cache)
            dt = time.time() - t0
            next_token = int(np.argmax(logits))
            generated.append(next_token)
            top5 = np.argsort(logits)[-5:][::-1]
            t5s = ", ".join(f"{idx}({logits[idx]:.1f})" for idx in top5)
            print(f"  [{i:3d}] token={next_token:6d} ({dt:.2f}s) top5=[{t5s}]")
            pos += 1
            if pos >= CTX or next_token == 50256: break
        return generated

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--model-dir", default="model/")
    ap.add_argument("--prompt", default="The answer to life is")
    ap.add_argument("--max-tokens", type=int, default=20)
    ap.add_argument("--dump-layout", action="store_true",
                    help="Print compact DDR layout derived from shared_params.hpp and exit")
    ap.add_argument("--shared-params", default=os.path.join(os.path.dirname(__file__), "..", "shared_params.hpp"),
                    help="Path to shared_params.hpp for --dump-layout")
    a = ap.parse_args()

    if a.dump_layout:
        sys.exit(dump_layout_from_shared_params(a.shared_params))

    try:
        from transformers import AutoTokenizer
        tokenizer = AutoTokenizer.from_pretrained(a.model_dir)
    except:
        try:
            from transformers import AutoTokenizer
            tokenizer = AutoTokenizer.from_pretrained("openai-community/gpt2")
        except:
            print("ERROR: pip install transformers"); sys.exit(1)

    ids = tokenizer.encode(a.prompt)
    print(f'Prompt: "{a.prompt}"')
    print(f"Tokens: {ids} ({len(ids)} tokens)\n")

    model = GPT2Int8(a.model_dir)
    print("=" * 60)
    gen = model.generate(ids, max_new_tokens=a.max_tokens)
    print("=" * 60)

    new_text = tokenizer.decode(gen[len(ids):])
    print(f'\nPrompt:    "{a.prompt}"')
    print(f'Generated: "{new_text}"')
    print(f'Full:      "{tokenizer.decode(gen)}"')

if __name__ == "__main__":
    main()
