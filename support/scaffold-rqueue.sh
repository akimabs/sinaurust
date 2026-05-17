#!/usr/bin/env bash
set -euo pipefail

PROJECT_DIR="${1:-rqueue}"

mkdir -p "$PROJECT_DIR"
cd "$PROJECT_DIR"

cat > Cargo.toml <<'TOML'
[workspace]
resolver = "2"
members = [
    "crates/rqueue-core",
    "crates/rqueue-protocol",
    "crates/rqueue-server",
    "crates/rqueue-client",
    "crates/rqueue-cli",
    "crates/rqueue-bench",
]
TOML

mkdir -p crates examples docs

cargo new crates/rqueue-core --lib
cargo new crates/rqueue-protocol --lib
cargo new crates/rqueue-server --bin
cargo new crates/rqueue-client --lib
cargo new crates/rqueue-cli --bin
cargo new crates/rqueue-bench --bin

mkdir -p examples/publisher-basic/src
mkdir -p examples/consumer-basic/src
mkdir -p examples/consumer-group/src
mkdir -p examples/retry-dlq-demo/src
mkdir -p examples/payment-simulation/src

cat > README.md <<'MD'
# RQueue

A learning project: build a Rust message broker from zero.

Final shape:

- rqueue-server
- rqueue-client
- rqueue-cli
- rqueue-bench
- examples
- docs
MD

echo "[OK] scaffold created at $PROJECT_DIR"
