# How to Use This Package

Paket ini berisi course lengkap untuk belajar Rust dari nol dengan membangun RQueue.

## Cara mulai

Baca:

```text
START_HERE.md
```

Lalu ikuti modul sesuai urutan di:

```text
00_COURSE_MAP.md
```

## Cara membuka HTML viewer

Buka file:

```text
index.html
```

Atau jalankan:

```bash
python3 -m http.server 8000
```

Lalu buka:

```text
http://localhost:8000
```

## Cara membuat project

Jalankan:

```bash
chmod +x support/scaffold-rqueue.sh
./support/scaffold-rqueue.sh rqueue
cd rqueue
```

## Urutan akhir project

```text
15_CLIENT_SDK.md
16_EXAMPLE_APPS.md
17_BENCHMARK.md
18_ADMIN_API_OPTIONAL.md
```

SDK adalah final utama karena aplikasi lain akan memakai broker lewat SDK.
