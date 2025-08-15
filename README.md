# Skrip Ganti Nama File Massal (Batch Rename)

Skrip shell ini dirancang untuk mengganti nama banyak file secara otomatis berdasarkan daftar nama baru yang disediakan dalam sebuah file teks. Skrip ini dibuat agar kompatibel dan tangguh, serta mampu menangani berbagai masalah umum seperti urutan file yang salah dan format teks yang berbeda.

## Fitur Utama

- **Ganti Nama Massal**: Mengubah nama ratusan file sekaligus sesuai urutan.
- **Daftar Nama Eksternal**: Menggunakan file `.txt` sebagai sumber untuk nama-nama file baru.
- **Pengurutan Numerik Cerdas**: Mengurutkan file asli berdasarkan angka di namanya secara benar (misalnya, `file-2.pdf` akan diproses setelah `file-1.pdf`, dan sebelum `file-10.pdf`).
- **Penanganan Format Teks**: Secara otomatis membersihkan nama baru dari karakter *carriage return* (`\r`) yang sering muncul dari file teks yang dibuat di Windows.
- **Kompatibilitas Tinggi**: Ditulis dalam `sh` (POSIX shell) untuk memastikan dapat berjalan di hampir semua lingkungan macOS dan Linux tanpa masalah.
- **Aman untuk Nama dengan Spasi**: Dapat memproses nama file yang mengandung spasi dengan benar.

## Persiapan

Sebelum menjalankan skrip, pastikan struktur folder Anda terlihat seperti ini:

```
folder_kerja/
├── ganti_nama.sh                 <-- Skrip ini
├── daftar_nama_baru.txt          <-- File berisi daftar nama baru
│
├── sertifikat-1.pdf              <-- File asli yang akan diubah namanya
├── sertifikat-2.pdf              <-- File asli ...
├── sertifikat-3.pdf              <-- ... dan seterusnya
└── ...
```

**Penting:**
1.  **File `daftar_nama_baru.txt`**:
    -   Setiap baris **harus** berisi satu nama file baru.
    -   Nama file baru **wajib menyertakan ekstensi** (contoh: `Nama Lengkap Peserta.pdf`).
    -   Jumlah baris di file ini harus sama persis dengan jumlah file yang ingin diubah namanya.

2.  **File Skrip**:
    -   Letakkan file `ganti_nama.sh` di dalam folder yang sama dengan file-file yang akan diproses.

## Cara Penggunaan

1.  **Buka Terminal**.
2.  **Navigasi ke Folder**: Pindah ke direktori kerja Anda menggunakan perintah `cd`.
    ```bash
    cd /path/ke/folder_kerja
    ```
3.  **Jadikan Skrip Bisa Dieksekusi**: Berikan izin eksekusi pada file skrip. **Langkah ini hanya perlu dilakukan satu kali.**
    ```bash
    chmod +x ganti_nama.sh
    ```
4.  **Jalankan Skrip**: Eksekusi skrip untuk memulai proses penggantian nama.
    ```bash
    ./ganti_nama.sh
    ```
    Skrip akan menampilkan proses penggantian nama file satu per satu.

## Kustomisasi

Anda dapat dengan mudah menyesuaikan skrip ini untuk kebutuhan lain.

### Mengubah Pola File Asli

Untuk mengganti nama file selain `sertifikat-*.pdf` (misalnya, `foto-*.jpg`), buka file `ganti_nama.sh` dan edit baris ini:

```sh
# Ubah 'sertifikat-*.pdf' sesuai dengan pola file Anda
printf '%s\n' sertifikat-*.pdf | sort -t- -k2n > "$OLD_FILES_TMP"
```

### Mengubah Nama File Daftar

Jika file daftar nama baru Anda bukan `list_peserta_seminar_public_speaking_magang.txt`, edit baris ini di dalam skrip:

```sh
# Ubah nama file .txt di bawah ini
tr -d '\r' < list_peserta_seminar_public_speaking_magang.txt > "$NEW_FILES_TMP"
```

---

**CATATAN PENTING**: Selalu buat cadangan (backup) dari file-file Anda sebelum menjalankan skrip yang melakukan perubahan massal seperti ini.