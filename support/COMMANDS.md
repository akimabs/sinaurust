# Commands Cheatsheet

## Setup

```bash
rustc --version
cargo --version
rustup update
rustup component add rustfmt
rustup component add clippy
rustup component add rust-src
```

## Cargo

```bash
cargo new rqueue
cargo check
cargo build
cargo build --release
cargo run
cargo test
cargo fmt
cargo clippy
cargo clippy -- -D warnings
cargo doc --open
```

## RQueue

```bash
cargo run --bin rqueued
cargo run --bin rqueue -- ping
cargo run --bin rqueue -- stats
cargo run --bin rqueue -- pub payments.created '{"id":"trx_001","amount":150000}'
cargo run --bin rqueue -- pull payments.created fraud-worker
cargo run --bin rqueue -- ack payments.created fraud-worker 1
cargo run --bin rqueue -- nack payments.created fraud-worker 1
cargo run --bin rqueue-bench -- pub payments.created --messages 10000 --concurrency 50
```

## Manual TCP

```bash
nc 127.0.0.1 7379
```

Commands inside `nc`:

```txt
PING
STATS
PUB payments.created {"id":"trx_001"}
PULL payments.created fraud-worker
ACK payments.created fraud-worker 1
```

## Admin API

```bash
curl 127.0.0.1:7380/health
curl -s 127.0.0.1:7380/stats | jq
```

## v3 SDK commands

Setelah workspace dipecah, command pentingnya:

```bash
cargo test -p rqueue-protocol
cargo test -p rqueue-client
cargo run -p rqueue-server
cargo run -p rqueue-cli -- pub payments.created '{"id":"trx_001"}'
cargo run -p publisher-basic
cargo run -p consumer-basic
cargo run -p rqueue-bench -- pub --topic payments.created --messages 100000 --concurrency 100
```

Catatan:

```text
rqueue-cli
rqueue-bench
examples/*
```

harus memakai `rqueue-client`, bukan encode raw TCP sendiri.
