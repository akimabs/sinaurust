# Start Here

Selamat datang di **RQueue From Zero**.

Course ini mengajarkan Rust dari nol dengan cara membangun message broker dari awal.

Tujuannya bukan sekadar bisa menulis Rust, tapi bisa memahami bagaimana sebuah komponen backend systems dibuat:

```text
TCP server
custom protocol
message queue
ACK/NACK
retry
DLQ
WAL
SDK
benchmark
```

## Cara belajar yang disarankan

Ikuti urutan ini:

```text
01_SETUP_RUST.md
02_RUST_BASIC.md
03_OWNERSHIP_BORROWING.md
04_STRUCT_ENUM_RESULT.md
05_CARGO_MODULE_TEST.md
06_CLI_CLAP_SERDE.md
07_ASYNC_TOKIO.md
08_TCP_PROTOCOL.md
09_PROJECT_SCAFFOLD.md
10_PROTOCOL_PARSER.md
11_IN_MEMORY_BROKER.md
12_TCP_SERVER_AND_CLI.md
13_ACK_RETRY_DLQ.md
14_WAL_RECOVERY.md
15_CLIENT_SDK.md
16_EXAMPLE_APPS.md
17_BENCHMARK.md
18_ADMIN_API_OPTIONAL.md
```

## Kenapa modul akhirnya SDK?

Karena message broker dipakai oleh aplikasi lain.

Aplikasi tidak seharusnya selalu mengirim raw TCP command secara manual. Aplikasi butuh SDK yang nyaman:

```rust
client.publish("payments.created", payload).await?;
```

Consumer juga harus nyaman:

```rust
let mut consumer = client.subscribe("payments.created", "fraud-worker").await?;
let message = consumer.next().await?;
message.ack().await?;
```

Karena itu, final utama course ini adalah:

```text
rqueue-client SDK
example apps
benchmark tool
```

Admin API tetap ada, tapi posisinya optional untuk observability dan debugging.

## Cara mulai

Install Rust dulu:

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

Cek:

```bash
rustc --version
cargo --version
```

Lalu lanjut ke:

```text
01_SETUP_RUST.md
```

## Kalau ingin langsung membuat folder project

Jalankan:

```bash
chmod +x support/scaffold-rqueue.sh
./support/scaffold-rqueue.sh rqueue
cd rqueue
```

## Aturan belajar

Jangan buru-buru.

Setiap modul punya:

- konsep
- visualisasi Mermaid
- contoh command
- contoh kode
- latihan
- checklist

Lanjut ke modul berikutnya hanya kalau checklist modul sebelumnya sudah cukup paham.
