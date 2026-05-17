# Glossary

## Rust

- `rustc`: compiler Rust.
- `cargo`: build tool dan package manager.
- `rustup`: toolchain installer/updater.
- crate: package/library Rust.
- ownership: aturan kepemilikan value.
- borrow: meminjam data tanpa mengambil ownership.
- `Result<T,E>`: sukses atau error.
- `Option<T>`: ada atau tidak ada.
- enum: type dengan beberapa kemungkinan bentuk.
- trait: kontrak behavior.

## RQueue

- producer: pengirim message.
- consumer: pemroses message.
- topic: nama channel message.
- payload: isi message.
- ACK: consumer sukses memproses message.
- NACK: consumer gagal memproses message.
- ready queue: message siap dikirim.
- in-flight: message sudah dikirim tapi belum ACK.
- visibility timeout: batas waktu in-flight sebelum retry.
- retry: kirim ulang message.
- DLQ: dead-letter queue untuk message yang gagal terus.
- WAL: write-ahead log untuk recovery.
- at-least-once: message dikirim minimal sekali, bisa lebih dari sekali.
- idempotent: operasi aman diulang.

## v3 SDK glossary

### SDK

Library yang dipakai aplikasi lain untuk berinteraksi dengan RQueue tanpa menulis raw TCP command sendiri.

### Publisher SDK

Bagian SDK yang menyediakan API seperti:

```rust
client.publish("payments.created", payload).await?;
```

### Consumer SDK

Bagian SDK yang menyediakan API seperti:

```rust
let mut consumer = client.subscribe("payments.created", "fraud-worker").await?;
let message = consumer.next().await?;
message.ack().await?;
```

### Product surface

Bagian sistem yang benar-benar dipakai user/developer. Untuk message broker, product surface utama adalah SDK dan protocol, bukan Admin API.
