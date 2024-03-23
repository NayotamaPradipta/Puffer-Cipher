# Tugas 3 Kriptografi
## Puffer Cipher Block Implementation
Repository ini berisi web app kriptografi menggunakan framework Ruby on Rails yang dapat melakukan enkripsi dan dekripsi pesan ataupun file biner menggunakan algoritma Puffer Cipher. Puffer Cipher dibuat dengan inspirasi dari Blowfish cipher. Enkripsi dan dekripsi dapat dilakukan menggunakan mode ECB, CBC, OFB, CFB, dan Counter. 


## Group Members
| NIM | Name |
| - | -|
| 13520089 | Nayotama Pradipta |
| 13520108 | Muhammad Rakha Athaya |

## Instalasi Aplikasi
Untuk menjalankan aplikasi ini, pastikan ruby dan rails telah di install. Program dapat dijalankan dengan perintah ```rails server``` pada root folder, dan aplikasi dapat dijalankan mellaui alamat ```https://localhost:3000```

## Enkripsi/Dekripsi
Website dapat menerima input dalam bentuk input dari user ataupun file biner. Input user untuk dekripsi hanya support dalam format Base64. Hasil enkripsi dan dekripsi dapat di download menghasilkan file biner.