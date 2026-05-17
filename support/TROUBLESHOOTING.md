# Troubleshooting

## cargo command not found

```bash
source "$HOME/.cargo/env"
```

Tutup terminal lalu buka lagi.

---

## use of moved value

Penyebab: ownership pindah.

```rust
let a = String::from("hello");
let b = a;
println!("{}", a); // error
```

Fix borrow:

```rust
let a = String::from("hello");
let b = &a;
println!("{} {}", a, b);
```

Fix clone:

```rust
let a = String::from("hello");
let b = a.clone();
println!("{} {}", a, b);
```

---

## cannot borrow as mutable more than once

Penyebab: dua mutable borrow bersamaan.

Fix: pisah scope.

```rust
{
    let state = map.get_mut("a").unwrap();
    state.ready.push_back(message);
}

{
    let state = map.get_mut("a").unwrap();
    state.in_flight.remove(&id);
}
```

---

## address already in use

Port 7379 masih dipakai.

```bash
lsof -i :7379
kill -9 <PID>
```

---

## nc tidak ada

Linux:

```bash
sudo apt install -y netcat-openbsd
```

---

## jq tidak ada

macOS:

```bash
brew install jq
```

Linux:

```bash
sudo apt install -y jq
```

---

## JSON quote error di shell

Pakai single quote:

```bash
cargo run --bin rqueue -- pub payments.created '{"id":"trx_001"}'
```
