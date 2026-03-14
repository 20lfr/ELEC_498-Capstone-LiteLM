#!/usr/bin/env python3
"""Generate testbench stream_in.bin from the model embedding table."""

from __future__ import annotations

import argparse
from pathlib import Path
from typing import Sequence


MODEL_HIDDEN_SIZE = 3072
MODEL_VOCAB_SIZE = 32064
DEFAULT_EMBED_PATH = Path("/home/luka/Scripting/model/embed_tokens.bin")
DEFAULT_OUT_PATH = Path(__file__).resolve().parent / "stream_in.bin"
DEFAULT_TOKEN_IDS = (10, 11, 12, 13)


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Build HLS testbench stream_in.bin from embedding rows."
    )
    parser.add_argument(
        "--embed-path",
        type=Path,
        default=DEFAULT_EMBED_PATH,
        help="Path to embed_tokens.bin",
    )
    parser.add_argument(
        "--out-path",
        type=Path,
        default=DEFAULT_OUT_PATH,
        help="Output path for stream_in.bin",
    )
    parser.add_argument(
        "token_ids",
        type=int,
        nargs="*",
        default=list(DEFAULT_TOKEN_IDS),
        help="Token IDs to pack into stream_in.bin",
    )
    return parser.parse_args()


def validate_embedding_file(embed_path: Path) -> None:
    if not embed_path.is_file():
        raise FileNotFoundError(f"embedding file not found: {embed_path}")
    expected_size = MODEL_HIDDEN_SIZE * MODEL_VOCAB_SIZE
    actual_size = embed_path.stat().st_size
    if actual_size != expected_size:
        raise ValueError(
            f"unexpected embedding size: got {actual_size}, expected {expected_size}"
        )


def validate_token_ids(token_ids: Sequence[int]) -> None:
    if not token_ids:
        raise ValueError("at least one token id is required")
    for token_id in token_ids:
        if token_id < 0 or token_id >= MODEL_VOCAB_SIZE:
            raise ValueError(
                f"token id {token_id} out of range [0, {MODEL_VOCAB_SIZE})"
            )


def build_stream(embed_path: Path, token_ids: Sequence[int]) -> bytes:
    row_bytes = MODEL_HIDDEN_SIZE
    chunks = []
    with embed_path.open("rb") as f:
        for token_id in token_ids:
            f.seek(token_id * row_bytes)
            row = f.read(row_bytes)
            if len(row) != row_bytes:
                raise IOError(
                    f"failed to read embedding row for token {token_id} "
                    f"(got {len(row)} bytes)"
                )
            chunks.append(row)
    return b"".join(chunks)


def main() -> int:
    args = parse_args()
    validate_embedding_file(args.embed_path)
    validate_token_ids(args.token_ids)
    stream = build_stream(args.embed_path, args.token_ids)
    args.out_path.write_bytes(stream)
    print(args.out_path)
    print(f"token_ids={list(args.token_ids)}")
    print(f"bytes={len(stream)}")
    print(f"token_bytes={MODEL_HIDDEN_SIZE}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
