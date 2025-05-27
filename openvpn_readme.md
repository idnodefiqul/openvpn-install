# 🔐 OpenVPN Auto Installer v2.0

<div align="center">

![OpenVPN](https://img.shields.io/badge/OpenVPN-EA7E20?style=for-the-badge&logo=openvpn&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)
![Bash](https://img.shields.io/badge/Bash-4EAA25?style=for-the-badge&logo=gnu-bash&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-blue?style=for-the-badge)

**🚀 Instalasi OpenVPN Server Otomatis dengan Satu Perintah**

*Instalasi cepat, aman, dan mudah untuk server OpenVPN dengan konfigurasi optimal*

</div>

---

## 📋 Daftar Isi

- [✨ Fitur Unggulan](#-fitur-unggulan)
- [🔧 Persyaratan Sistem](#-persyaratan-sistem)
- [🚀 Instalasi Cepat](#-instalasi-cepat)
- [📱 Cara Penggunaan](#-cara-penggunaan)
- [🔒 Fitur Keamanan](#-fitur-keamanan)
- [🌐 Akses Konfigurasi](#-akses-konfigurasi)
- [⚙️ Manajemen Server](#️-manajemen-server)
- [🛠️ Troubleshooting](#️-troubleshooting)
- [📞 Dukungan](#-dukungan)

---

## ✨ Fitur Unggulan

<table>
<tr>
<td>

### 🎯 **Instalasi Otomatis**
- ✅ Setup lengkap dalam 5 menit
- ✅ Konfigurasi optimal out-of-the-box
- ✅ Support Ubuntu/Debian/CentOS
- ✅ Auto-detect sistem dan network

</td>
<td>

### 🔐 **Keamanan Tinggi**
- ✅ Enkripsi AES-256-GCM
- ✅ Perfect Forward Secrecy
- ✅ TLS Authentication
- ✅ DNS Leak Protection

</td>
</tr>
<tr>
<td>

### 🌐 **Web Interface**
- ✅ Download config via browser
- ✅ Dashboard monitoring
- ✅ Responsive design
- ✅ Real-time status

</td>
<td>

### ⚡ **Performa Optimal**
- ✅ Kompresi LZ4
- ✅ Buffer optimization
- ✅ Multi-threading support
- ✅ Low latency configuration

</td>
</tr>
</table>

---

## 🔧 Persyaratan Sistem

### 💻 **Sistem Operasi yang Didukung**

| OS | Versi Minimum | Status |
|:---:|:---:|:---:|
| ![Ubuntu](https://img.shields.io/badge/Ubuntu-E95420?style=flat&logo=ubuntu&logoColor=white) | 18.04 LTS | ✅ Tested |
| ![Debian](https://img.shields.io/badge/Debian-A81D33?style=flat&logo=debian&logoColor=white) | 9 (Stretch) | ✅ Tested |
| ![CentOS](https://img.shields.io/badge/CentOS-262577?style=flat&logo=centos&logoColor=white) | 7 | ✅ Tested |

### 🔧 **Spesifikasi Server**

```
🖥️  CPU: 1 vCore (2 vCore recommended)
💾  RAM: 512MB (1GB recommended)  
💿  Storage: 1GB free space
🌐  Network: Public IP dengan akses root
🔓  Ports: 1194/UDP, 8080/TCP
```

---

## 🚀 Instalasi Cepat

### 🎯 **One-Line Installation**

```bash
bash <(curl -s https://raw.githubusercontent.com/idnodefiqul/install-openvpn/main/installv2.sh) openvpn NAMA_USER
```

### 📝 **Contoh Penggunaan**

```bash
# Untuk user bernama "hanji"
bash <(curl -s https://raw.githubusercontent.com/idnodefiqul/install-openvpn/main/installv2.sh) openvpn hanji

# Untuk user bernama "admin2024"  
bash <(curl -s https://raw.githubusercontent.com/idnodefiqul/install-openvpn/main/installv2.sh) openvpn admin2024

# Untuk user bernama "user123"
bash <(curl -s https://raw.githubusercontent.com/idnodefiqul/install-openvpn/main/installv2.sh) openvpn user123
```

### ⚡ **Quick Start (Copy & Paste)**

<details>
<summary>🖱️ Klik untuk melihat perintah siap pakai</summary>

```bash
# Ganti 'USERNAME' dengan nama user Anda
sudo bash <(curl -s https://raw.githubusercontent.com/idnodefiqul/install-openvpn/main/installv2.sh) openvpn USERNAME
```

**⚠️ Jangan lupa mengganti `USERNAME` dengan nama user yang diinginkan!**

</details>

---

## 📱 Cara Penggunaan

### 1️⃣ **Jalankan Instalasi**

```bash
# Format: bash <(curl -s URL) openvpn NAMA_USER
sudo bash <(curl -s https://raw.githubusercontent.com/idnodefiqul/install-openvpn/main/installv2.sh) openvpn hanji
```

### 2️⃣ **Proses Instalasi**

```
🔄 Mengupdate sistem...
📦 Menginstall dependencies...
🔐 Mengkonfigurasi Easy-RSA...
⚙️  Mengkonfigurasi OpenVPN server...
🔥 Mengkonfigurasi iptables...
🌐 Mengsetup web server...
✅ Instalasi selesai!
```

### 3️⃣ **Download Konfigurasi**

Setelah instalasi selesai, Anda akan mendapat informasi:

```
📱 Download Konfigurasi Client:
   🌐 Web: http://IP_SERVER:8080
   📄 Direct: http://IP_SERVER:8080/NAMA_USER.ovpn
```

---

## 🔒 Fitur Keamanan

### 🛡️ **Validasi Ketat**

| Validasi | Deskripsi | Status |
|:---:|:---:|:---:|
| **Parameter Wajib** | Harus ada 2 parameter: `openvpn` + `username` | ✅ |
| **Keyword Check** | Parameter pertama harus tepat `"openvpn"` | ✅ |
| **Username Rules** | Min 3 karakter, hanya huruf & angka | ✅ |
| **Execution Method** | Hanya bisa via URL, tidak bisa file lokal | ✅ |

### ❌ **Yang Akan Ditolak**

```bash
# ❌ Tanpa parameter
bash <(curl -s URL)

# ❌ Parameter salah
bash <(curl -s URL) vpn hanji

# ❌ Username terlalu pendek
bash <(curl -s URL) openvpn ha

# ❌ Username dengan karakter khusus
bash <(curl -s URL) openvpn ha@ji

# ❌ Eksekusi langsung dari file
./script.sh openvpn hanji
```

### ✅ **Yang Akan Diterima**

```bash
# ✅ Format yang benar
bash <(curl -s URL) openvpn hanji
bash <(curl -s URL) openvpn admin2024
bash <(curl -s URL) openvpn user123
bash <(curl -s URL) openvpn myserver
```

---

## 🌐 Akses Konfigurasi

### 🖥️ **Web Dashboard**

Akses web interface di: `http://IP_SERVER:8080`

<div align="center">

```
╔══════════════════════════════════════════╗
║          🔐 OpenVPN Configuration         ║
║                                          ║
║          👤 User: NAMA_USER              ║
║      ✅ Konfigurasi berhasil dibuat      ║
║                                          ║
║     📱 Download Configuration:           ║
║   📄 Download NAMA_USER.ovpn            ║
║                                          ║
║    🚀 Server IP: XXX.XXX.XXX.XXX        ║
║           Port: 1194                     ║
╚══════════════════════════════════════════╝
```

</div>

### 📱 **Import ke Client**

#### **Android**
1. Download **OpenVPN Connect** dari Play Store
2. Download file `.ovpn` dari web dashboard
3. Import file ke aplikasi
4. Tap **Connect**

#### **iOS**
1. Download **OpenVPN Connect** dari App Store
2. Download file `.ovpn` melalui Safari
3. Pilih "Open in OpenVPN"
4. Tap **Connect**

#### **Windows**
1. Download **OpenVPN GUI** dari official website
2. Copy file `.ovpn` ke folder `config`
3. Right-click system tray icon → **Connect**

#### **Linux**
```bash
# Install OpenVPN client
sudo apt install openvpn

# Connect menggunakan config file
sudo openvpn --config username.ovpn
```

---

## ⚙️ Manajemen Server

### 🔧 **OpenVPN Manager**

Setelah instalasi, gunakan script manajemen:

```bash
# Jalankan manager (sesuaikan dengan username Anda)
openvpn-manager-NAMA_USER
```

### 📋 **Menu Manager**

```
╔══════════════════════════════════╗
║      OpenVPN Manager             ║
║        User: NAMA_USER           ║
╚══════════════════════════════════╝

1. Tambah Client Baru
2. Lihat Client Aktif  
3. Restart OpenVPN
4. Lihat Log
5. Exit
```

### 🔄 **Perintah Manual**

```bash
# Cek status service
sudo systemctl status openvpn-server@server

# Restart service
sudo systemctl restart openvpn-server@server

# Lihat log real-time
sudo tail -f /var/log/openvpn/openvpn.log

# Lihat client yang terkoneksi
sudo cat /var/log/openvpn/openvpn-status.log
```

---

## 🛠️ Troubleshooting

### ❗ **Masalah Umum & Solusi**

<details>
<summary>🔴 <strong>Service OpenVPN tidak bisa start</strong></summary>

```bash
# Cek error log
sudo journalctl -xeu openvpn-server@server

# Cek konfigurasi
sudo openvpn --config /etc/openvpn/server/server.conf --verb 4

# Restart dengan debug
sudo systemctl stop openvpn-server@server
sudo openvpn --config /etc/openvpn/server/server.conf
```

</details>

<details>
<summary>🟡 <strong>Client tidak bisa connect</strong></summary>

```bash
# Cek firewall
sudo ufw status
sudo iptables -L

# Pastikan port terbuka
sudo netstat -tulpn | grep 1194

# Cek routing
ip route show
```

</details>

<details>
<summary>🟠 <strong>Tidak bisa akses internet setelah connect</strong></summary>

```bash
# Cek IP forwarding
cat /proc/sys/net/ipv4/ip_forward

# Enable IP forwarding
echo 'net.ipv4.ip_forward=1' | sudo tee -a /etc/sysctl.conf
sudo sysctl -p

# Cek NAT rules
sudo iptables -t nat -L
```

</details>

<details>
<summary>🔵 <strong>Web dashboard tidak bisa diakses</strong></summary>

```bash
# Cek nginx status
sudo systemctl status nginx

# Cek port 8080
sudo netstat -tulpn | grep 8080

# Restart nginx
sudo systemctl restart nginx

# Cek firewall untuk port 8080
sudo ufw allow 8080
```

</details>

### 🔍 **Log Files Penting**

| Log File | Deskripsi |
|:---:|:---:|
| `/var/log/openvpn/openvpn.log` | Main OpenVPN log |
| `/var/log/openvpn/openvpn-status.log` | Client connection status |
| `/var/log/nginx/access.log` | Web dashboard access |
| `/var/log/nginx/error.log` | Web dashboard errors |

---

## 🔧 Konfigurasi Lanjutan

### ⚡ **Optimasi Performa**

<details>
<summary>📈 <strong>Tuning untuk High Traffic</strong></summary>

Edit `/etc/openvpn/server/server.conf`:

```bash
# Increase buffer sizes
sndbuf 393216
rcvbuf 393216
push "sndbuf 393216"
push "rcvbuf 393216"

# Enable multi-threading
management localhost 7505
multihome
```

</details>

### 🔒 **Enhanced Security**

<details>
<summary>🛡️ <strong>Additional Security Measures</strong></summary>

```bash
# Change default port
port 443

# Use TCP instead of UDP for better stability
proto tcp

# Add additional authentication
auth-user-pass-verify /etc/openvpn/checkpsw.sh via-env
script-security 3
```

</details>

### 🌍 **Multiple Locations**

<details>
<summary>🗺️ <strong>Setup Multi-Location</strong></summary>

```bash
# Clone configuration for different locations
cp /etc/openvpn/server/server.conf /etc/openvpn/server/server-us.conf
cp /etc/openvpn/server/server.conf /etc/openvpn/server/server-sg.conf

# Modify ports and certificates accordingly
# server-us.conf -> port 1195
# server-sg.conf -> port 1196
```

</details>

---

## 📊 Monitoring & Analytics

### 📈 **Real-time Monitoring**

```bash
# Install monitoring tools
sudo apt install htop iftop nethogs

# Monitor bandwidth usage
sudo iftop -i tun0

# Monitor per-process network usage
sudo nethogs tun0

# OpenVPN built-in status
echo "status" | nc localhost 7505
```

### 📱 **Client Statistics**

```bash
# Show connected clients
sudo cat /var/log/openvpn/openvpn-status.log | grep "CLIENT_LIST"

# Show traffic statistics
sudo cat /var/log/openvpn/openvpn-status.log | grep "ROUTING_TABLE"
```

---

## 🔄 Backup & Restore

### 💾 **Backup Konfigurasi**

```bash
#!/bin/bash
# Backup script
BACKUP_DIR="/root/openvpn-backup-$(date +%Y%m%d)"
mkdir -p $BACKUP_DIR

# Backup files
cp -r /etc/openvpn/ $BACKUP_DIR/
cp -r /var/www/openvpn/ $BACKUP_DIR/
cp -r /usr/local/bin/openvpn-manager-* $BACKUP_DIR/

# Create archive
tar -czf openvpn-backup-$(date +%Y%m%d).tar.gz $BACKUP_DIR/
```

### 🔄 **Restore Konfigurasi**

```bash
#!/bin/bash
# Restore script
BACKUP_FILE="openvpn-backup-YYYYMMDD.tar.gz"

# Extract backup
tar -xzf $BACKUP_FILE

# Restore files
sudo cp -r openvpn-backup-*/etc/openvpn/* /etc/openvpn/
sudo cp -r openvpn-backup-*/var/www/openvpn/* /var/www/openvpn/
sudo cp openvpn-backup-*/usr/local/bin/openvpn-manager-* /usr/local/bin/

# Restart services
sudo systemctl restart openvpn-server@server
sudo systemctl restart nginx
```

---

## 🚀 Advanced Features

### 🔐 **Two-Factor Authentication**

<details>
<summary>🔑 <strong>Setup Google Authenticator</strong></summary>

```bash
# Install Google Authenticator
sudo apt install libpam-google-authenticator

# Setup for OpenVPN
sudo nano /etc/pam.d/openvpn
# Add: auth required pam_google_authenticator.so

# Update OpenVPN config
echo "plugin /usr/lib/openvpn/openvpn-plugin-auth-pam.so openvpn" >> /etc/openvpn/server/server.conf
```

</details>

### 📱 **Mobile Device Management**

<details>
<summary>📲 <strong>Auto-generate Mobile Configs</strong></summary>

```bash
# Create mobile-optimized config
cat > mobile-template.ovpn << EOF
client
dev tun
proto udp
remote-random
resolv-retry infinite
nobind
persist-key
persist-tun
remote-cert-tls server
cipher AES-256-GCM
auth SHA256
compress lz4-v2
verb 3

# Mobile optimizations
keepalive 10 60
reneg-sec 0
fast-io
EOF
```

</details>

---

## 📞 Dukungan

### 🆘 **Butuh Bantuan?**

<div align="center">

[![GitHub Issues](https://img.shields.io/badge/GitHub-Issues-red?style=for-the-badge&logo=github)](https://github.com/idnodefiqul/install-openvpn/issues)
[![Telegram](https://img.shields.io/badge/Telegram-Support-blue?style=for-the-badge&logo=telegram)](https://t.me/openvpnsupport)
[![Discord](https://img.shields.io/badge/Discord-Community-purple?style=for-the-badge&logo=discord)](https://discord.gg/openvpn)

</div>

### 📝 **Melaporkan Bug**

Jika menemukan bug, silakan buat issue dengan format:

```markdown
**Deskripsi Bug:**
[Jelaskan bug yang ditemukan]

**Langkah Reproduksi:**
1. [Langkah pertama]
2. [Langkah kedua]
3. [dst...]

**Hasil yang Diharapkan:**
[Apa yang seharusnya terjadi]

**Hasil Aktual:**
[Apa yang benar-benar terjadi]

**Environment:**
- OS: [Ubuntu 20.04]
- OpenVPN Version: [2.4.x]
- Script Version: [v2.0]
```

### 💡 **Request Fitur Baru**

Punya ide fitur baru? Buat feature request di GitHub Issues!

---

## 📄 Lisensi

```
MIT License

Copyright (c) 2024 OpenVPN Auto Installer

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

---

## 🌟 Kontribusi

Kami menyambut kontribusi dari komunitas! 

### 🔧 **Cara Berkontribusi:**

1. Fork repository ini
2. Buat branch fitur (`git checkout -b fitur-amazing`)
3. Commit perubahan (`git commit -am 'Tambah fitur amazing'`)
4. Push ke branch (`git push origin fitur-amazing`)
5. Buat Pull Request

### 👥 **Contributors**

<div align="center">

<a href="https://github.com/idnodefiqul/install-openvpn/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=idnodefiqul/install-openvpn" />
</a>

*Made with ❤️ by the OpenVPN Auto Installer team*

</div>

---

## 📊 Statistik Proyek

<div align="center">

![GitHub stars](https://img.shields.io/github/stars/idnodefiqul/install-openvpn?style=social)
![GitHub forks](https://img.shields.io/github/forks/idnodefiqul/install-openvpn?style=social)
![GitHub watchers](https://img.shields.io/github/watchers/idnodefiqul/install-openvpn?style=social)

![GitHub last commit](https://img.shields.io/github/last-commit/idnodefiqul/install-openvpn)
![GitHub issues](https://img.shields.io/github/issues/idnodefiqul/install-openvpn)
![GitHub pull requests](https://img.shields.io/github/issues-pr/idnodefiqul/install-openvpn)

</div>

---

<div align="center">

**⭐ Jika project ini membantu Anda, jangan lupa berikan star di GitHub! ⭐**

```
 ██████╗ ██████╗ ███████╗███╗   ██╗██╗   ██╗██████╗ ███╗   ██╗
██╔═══██╗██╔══██╗██╔════╝████╗  ██║██║   ██║██╔══██╗████╗  ██║
██║   ██║██████╔╝█████╗  ██╔██╗ ██║██║   ██║██████╔╝██╔██╗ ██║
██║   ██║██╔═══╝ ██╔══╝  ██║╚██╗██║╚██╗ ██╔╝██╔═══╝ ██║╚██╗██║
╚██████╔╝██║     ███████╗██║ ╚████║ ╚████╔╝ ██║     ██║ ╚████║
 ╚═════╝ ╚═╝     ╚══════╝╚═╝  ╚═══╝  ╚═══╝  ╚═╝     ╚═╝  ╚═══╝
```

**🚀 Happy VPN-ing! 🚀**

</div>