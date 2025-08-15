#!/bin/sh

# Pindah ke direktori tempat skrip ini berada.
cd "$(dirname "$0")"

# Membuat dua file sementara yang aman untuk menampung daftar nama.
OLD_FILES_TMP=$(mktemp)
NEW_FILES_TMP=$(mktemp)

# Perintah ini memastikan file sementara akan selalu dihapus saat skrip selesai.
trap 'rm -f "$OLD_FILES_TMP" "$NEW_FILES_TMP"' EXIT

# Menulis daftar file LAMA (*.pdf) yang sudah diurutkan
# dengan benar secara numerik ke dalam file sementara pertama.
printf '%s\n' *.pdf | sort -t- -k2n > "$OLD_FILES_TMP"

# Membersihkan dan menulis daftar nama BARU dari file .txt
# ke dalam file sementara kedua.
tr -d '\r' < nama_list_peserta.txt > "$NEW_FILES_TMP"

# Memeriksa apakah ada file sertifikat yang ditemukan.
if ! [ -s "$OLD_FILES_TMP" ]; then
    echo "Error: Tidak ada file yang cocok dengan pola 'sertifikat-*.pdf'."
    exit 1
fi

echo "Memulai proses penggantian nama..."

# Menggunakan 'paste' untuk menggabungkan kedua file sementara berdampingan,
# lalu membaca setiap baris pasangan nama untuk melakukan 'mv'.
paste "$OLD_FILES_TMP" "$NEW_FILES_TMP" | while IFS="$(printf '\t')" read -r old_name new_name; do
    # Hanya proses jika kedua nama (lama dan baru) tidak kosong.
    if [ -n "$old_name" ] && [ -n "$new_name" ]; then
        mv -v "$old_name" "$new_name"
    fi
done

echo "Proses selesai."