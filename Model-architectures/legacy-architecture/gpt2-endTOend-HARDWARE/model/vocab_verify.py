import json

with open("tokenizer.json", encoding="utf-8") as f:
    t = json.load(f)
vocab = t["model"]["vocab"]
print(f"tokenizer.json vocab: {len(vocab)}")

ids_in_txt = set()
with open("vocab.txt", encoding="utf-8") as f:
    for line in f:
        if line.startswith("#") or "\t" not in line:
            continue
        parts = line.rstrip("\n").rsplit("\t", 1)
        if len(parts) == 2:
            try:
                ids_in_txt.add(int(parts[1]))
            except ValueError:
                pass

print(f"vocab.txt IDs: {len(ids_in_txt)}")
missing = set(range(50257)) - ids_in_txt
print(f"Missing IDs ({len(missing)}): {sorted(missing)}")
for mid in sorted(missing):
    for k, v in vocab.items():
        if v == mid:
            print(f"  ID {mid}: {repr(k)}")