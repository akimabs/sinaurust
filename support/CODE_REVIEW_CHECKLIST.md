# Code Review Checklist

## Correctness

- [ ] Invalid command tidak crash.
- [ ] Pull topic kosong membalas EMPTY.
- [ ] ACK message hilang dari in-flight.
- [ ] NACK membuat retry atau DLQ.
- [ ] Timeout membuat retry.
- [ ] WAL recovery jalan.

## Rust quality

- [ ] Tidak ada unwrap pada input network.
- [ ] Error memakai Result.
- [ ] Clone dilakukan sadar.
- [ ] Function tidak terlalu panjang.
- [ ] Borrowing scope jelas.

## Async quality

- [ ] Tidak menahan lock saat I/O lambat.
- [ ] Task error dilog.
- [ ] Shared state pakai Arc<Mutex<_>> dengan alasan jelas.

## Documentation

- [ ] README punya quickstart.
- [ ] README punya protocol examples.
- [ ] README punya diagram.
- [ ] README punya delivery semantics.
- [ ] README punya benchmark.
- [ ] README punya limitations.

## v3 SDK checklist

- [ ] `rqueue-client` tidak import `rqueue-core`.
- [ ] `rqueue-client` hanya bergantung pada `rqueue-protocol` dan transport TCP.
- [ ] `rqueue-cli` memakai `rqueue-client`.
- [ ] `rqueue-bench` memakai `rqueue-client`.
- [ ] Example apps memakai `rqueue-client`.
- [ ] Tidak ada duplikasi encode/decode protocol di CLI.
- [ ] `Message::ack(self)` consume ownership message.
- [ ] `Message::nack(self)` consume ownership message.
- [ ] Error SDK memakai custom error type, bukan `String`.
- [ ] Ada test untuk protocol parse/encode/decode.
