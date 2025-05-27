#!/bin/bash

# OpenVPN Auto Install Script - URL Parameter Version
# Script ini hanya bisa dijalankan melalui URL dengan parameter
# Usage: bash <(curl -s https://raw.githubusercontent.com/username/repo/main/script.sh) openvpn username

# Warna untuk output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Validasi parameter
validate_parameters() {
    if [[ $# -ne 2 ]]; then
        echo -e "${RED}╔══════════════════════════════════════════════════════════╗${NC}"
        echo -e "${RED}║                        ERROR!                            ║${NC}"
        echo -e "${RED}║              Script memerlukan 2 parameter!              ║${NC}"
        echo -e "${RED}╚══════════════════════════════════════════════════════════╝${NC}"
        echo
        echo -e "${YELLOW}📋 Cara penggunaan yang benar:${NC}"
        echo -e "${CYAN}bash <(curl -s https://raw.githubusercontent.com/username/repo/main/script.sh) ${GREEN}openvpn${NC} ${BLUE}namauser${NC}"
        echo
        echo -e "${YELLOW}Contoh:${NC}"
        echo -e "${CYAN}bash <(curl -s https://raw.githubusercontent.com/idnodefiqul/install-openvpn/main/installv2.sh) ${GREEN}openvpn${NC} ${BLUE}hanji${NC}"
        echo
        echo -e "${RED}❌ Akses ditolak!${NC}"
        exit 1
    fi

    # Validasi parameter pertama harus "openvpn"
    if [[ "$1" != "openvpn" ]]; then
        echo -e "${RED}╔══════════════════════════════════════════════════════════╗${NC}"
        echo -e "${RED}║                   PARAMETER SALAH!                       ║${NC}"
        echo -e "${RED}║              Parameter pertama harus 'openvpn'           ║${NC}"
        echo -e "${RED}╚══════════════════════════════════════════════════════════╝${NC}"
        echo
        echo -e "${YELLOW}📋 Format yang benar:${NC}"
        echo -e "${CYAN}bash <(curl -s URL) ${GREEN}openvpn${NC} ${BLUE}namauser${NC}"
        echo
        echo -e "${RED}❌ Akses ditolak!${NC}"
        exit 1
    fi

    # Validasi nama user (minimal 3 karakter, hanya huruf dan angka)
    USER_NAME="$2"
    if [[ ! "$USER_NAME" =~ ^[a-zA-Z0-9]{3,}$ ]]; then
        echo -e "${RED}╔══════════════════════════════════════════════════════════╗${NC}"
        echo -e "${RED}║                   USERNAME INVALID!                      ║${NC}"
        echo -e "${RED}║      Username harus minimal 3 karakter (huruf/angka)     ║${NC}"
        echo -e "${RED}╚══════════════════════════════════════════════════════════╝${NC}"
        echo
        echo -e "${YELLOW}📋 Aturan username:${NC}"
        echo -e "   • Minimal 3 karakter"
        echo -e "   • Hanya huruf dan angka"
        echo -e "   • Tidak boleh ada spasi atau karakter khusus"
        echo
        echo -e "${YELLOW}Contoh username yang valid:${NC}"
        echo -e "   • ${GREEN}hanji${NC}"
        echo -e "   • ${GREEN}user123${NC}"
        echo -e "   • ${GREEN}admin2024${NC}"
        echo
        echo -e "${RED}❌ Akses ditolak!${NC}"
        exit 1
    fi
}

# Cek apakah script dijalankan melalui curl/wget
check_execution_method() {
    # Cek apakah script dijalankan dari stdin (melalui curl/wget)
    if [[ -t 0 ]]; then
        # Script dijalankan secara normal (bukan dari pipe)
        echo -e "${RED}╔══════════════════════════════════════════════════════════╗${NC}"
        echo -e "${RED}║                    AKSES DITOLAK!                        ║${NC}"
        echo -e "${RED}║           Script hanya bisa dijalankan via URL!          ║${NC}"
        echo -e "${RED}╚══════════════════════════════════════════════════════════╝${NC}"
        echo
        echo -e "${YELLOW}🚫 Script ini tidak dapat dijalankan secara langsung!${NC}"
        echo
        echo -e "${CYAN}📋 Cara penggunaan yang benar:${NC}"
        echo -e "${GREEN}bash <(curl -s https://raw.githubusercontent.com/idnodefiqul/install-openvpn/main/installv2.sh) openvpn namauser${NC}"
        echo
        echo -e "${YELLOW}Contoh:${NC}"
        echo -e "${GREEN}bash <(curl -s https://raw.githubusercontent.com/idnodefiqul/install-openvpn/main/installv2.sh) openvpn hanji${NC}"
        echo
        exit 1
    fi
}

# Banner dengan info user
show_banner() {
    clear
    echo -e "${CYAN}╔══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║                 ${YELLOW}OpenVPN Auto Installer${CYAN}                   ║${NC}"
    echo -e "${CYAN}║              ${GREEN}Instalasi Otomatis & Konfigurasi${CYAN}              ║${NC}"
    echo -e "${CYAN}║                   ${PURPLE}Versi 2.0 - 2024${CYAN}                      ║${NC}"
    echo -e "${CYAN}║                                                          ║${NC}"
    echo -e "${CYAN}║               ${BLUE}👤 User: ${YELLOW}$USER_NAME${CYAN}                        ║${NC}"
    echo -e "${CYAN}╚══════════════════════════════════════════════════════════╝${NC}"
    echo
}

# Fungsi untuk menampilkan loading
show_loading() {
    local pid=$1
    local delay=0.1
    local spinstr='|/-\'
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
}

# Fungsi untuk log
log() {
    echo -e "${GREEN}[$(date +'%Y-%m-%d %H:%M:%S')] $1${NC}"
}

error() {
    echo -e "${RED}[ERROR] $1${NC}"
}

warning() {
    echo -e "${YELLOW}[WARNING] $1${NC}"
}

# Cek apakah script dijalankan sebagai root
check_root() {
    if [[ $EUID -ne 0 ]]; then
        error "Script ini harus dijalankan sebagai root!"
        echo "Gunakan: sudo bash <(curl -s URL) openvpn $USER_NAME"
        exit 1
    fi
}

# Deteksi OS
detect_os() {
    if [[ -e /etc/debian_version ]]; then
        OS="debian"
        source /etc/os-release
        if [[ $ID == "debian" || $ID == "raspbian" ]]; then
            if [[ $VERSION_ID -lt 9 ]]; then
                error "Debian versi tidak didukung"
                exit 1
            fi
        elif [[ $ID == "ubuntu" ]]; then
            UBUNTU_VERSION=$(echo $VERSION_ID | sed 's/\.//')
            if [[ $UBUNTU_VERSION -lt 1804 ]]; then
                error "Ubuntu versi tidak didukung (minimal Ubuntu 18.04)"
                exit 1
            fi
        fi
    elif [[ -e /etc/centos-release ]]; then
        OS="centos"
    elif [[ -e /etc/fedora-release ]]; then
        OS="fedora"
    else
        error "OS tidak didukung"
        exit 1
    fi
}

# Update system
update_system() {
    log "Mengupdate sistem..."
    if [[ $OS == "debian" ]]; then
        apt-get update >&2 &
        show_loading $!
        apt-get upgrade -y >&2 &
        show_loading $!
    elif [[ $OS == "centos" ]]; then
        yum update -y >&2 &
        show_loading $!
    fi
    log "Update sistem selesai"
}

# Install dependencies
install_dependencies() {
    log "Menginstall dependencies..."
    if [[ $OS == "debian" ]]; then
        apt-get install -y openvpn easy-rsa iptables-persistent wget curl unzip >&2 &
        show_loading $!
    elif [[ $OS == "centos" ]]; then
        yum install -y epel-release >&2 &
        show_loading $!
        yum install -y openvpn easy-rsa wget curl unzip >&2 &
        show_loading $!
    fi
    log "Dependencies berhasil diinstall"
}

# Setup Easy-RSA
setup_easyrsa() {
    log "Mengkonfigurasi Easy-RSA..."
    
    make-cadir /etc/openvpn/easy-rsa
    cd /etc/openvpn/easy-rsa/
    
    cat > vars << EOF
set_var EASYRSA_REQ_COUNTRY    "ID"
set_var EASYRSA_REQ_PROVINCE   "Jakarta"
set_var EASYRSA_REQ_CITY       "Jakarta"
set_var EASYRSA_REQ_ORG        "OpenVPN-Server-$USER_NAME"
set_var EASYRSA_REQ_EMAIL      "$USER_NAME@openvpn.local"
set_var EASYRSA_REQ_OU         "IT Department"
set_var EASYRSA_KEY_SIZE       2048
set_var EASYRSA_ALGO           rsa
set_var EASYRSA_CA_EXPIRE      3650
set_var EASYRSA_CERT_EXPIRE    3650
EOF

    log "Inisialisasi PKI..."
    ./easyrsa init-pki >&2
    
    log "Membuat Certificate Authority..."
    echo "OpenVPN-CA-$USER_NAME" | ./easyrsa build-ca nopass >&2
    
    log "Membuat server certificate..."
    echo "yes" | ./easyrsa build-server-full server nopass >&2
    
    log "Membuat Diffie-Hellman parameters..."
    ./easyrsa gen-dh >&2 &
    show_loading $!
    
    openvpn --genkey --secret pki/ta.key
    
    cp pki/ca.crt /etc/openvpn/server/
    cp pki/issued/server.crt /etc/openvpn/server/
    cp pki/private/server.key /etc/openvpn/server/
    cp pki/dh.pem /etc/openvpn/server/
    cp pki/ta.key /etc/openvpn/server/
    
    log "Easy-RSA setup selesai"
}

# Get server IP
get_server_ip() {
    SERVER_IP=$(curl -s ipv4.icanhazip.com)
    if [[ -z $SERVER_IP ]]; then
        SERVER_IP=$(wget -qO- ipv4.icanhazip.com)
    fi
    if [[ -z $SERVER_IP ]]; then
        SERVER_IP=$(hostname -I | awk '{print $1}')
    fi
}

# Configure OpenVPN server
configure_server() {
    log "Mengkonfigurasi OpenVPN server..."
    
    mkdir -p /etc/openvpn/server
    
    cat > /etc/openvpn/server/server.conf << EOF
# OpenVPN Server Configuration - User: $USER_NAME
port 1194
proto udp
dev tun

ca ca.crt
cert server.crt
key server.key
dh dh.pem

topology subnet
server 10.8.0.0 255.255.255.0

ifconfig-pool-persist /var/log/openvpn/ipp.txt

push "redirect-gateway def1 bypass-dhcp"
push "dhcp-option DNS 8.8.8.8"
push "dhcp-option DNS 8.8.4.4"
push "dhcp-option DNS 1.1.1.1"

client-to-client
keepalive 10 120

tls-auth ta.key 0
cipher AES-256-GCM
auth SHA256

compress lz4-v2
push "compress lz4-v2"

persist-key
persist-tun

status /var/log/openvpn/openvpn-status.log
log /var/log/openvpn/openvpn.log
verb 3
explicit-exit-notify 1

sndbuf 0
rcvbuf 0
push "sndbuf 393216"
push "rcvbuf 393216"

push "block-outside-dns"
EOF

    mkdir -p /var/log/openvpn
    chown -R openvpn:openvpn /var/log/openvpn
    
    log "Konfigurasi server selesai"
}

# Setup iptables
setup_iptables() {
    log "Mengkonfigurasi iptables..."
    
    DEFAULT_IF=$(ip route | grep '^default' | grep -o 'dev [^ ]*' | head -n1 | cut -d' ' -f2)
    
    echo 'net.ipv4.ip_forward=1' >> /etc/sysctl.conf
    sysctl -p
    
    iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o $DEFAULT_IF -j MASQUERADE
    iptables -A INPUT -i tun+ -j ACCEPT
    iptables -A FORWARD -i $DEFAULT_IF -o tun+ -j ACCEPT
    iptables -A FORWARD -i tun+ -o $DEFAULT_IF -j ACCEPT
    iptables -A INPUT -i $DEFAULT_IF -p udp --dport 1194 -j ACCEPT
    
    if [[ $OS == "debian" ]]; then
        iptables-save > /etc/iptables/rules.v4
    elif [[ $OS == "centos" ]]; then
        service iptables save
    fi
    
    log "iptables berhasil dikonfigurasi"
}

# Create client configuration
create_client_config() {
    local CLIENT_NAME="$USER_NAME"
    log "Membuat konfigurasi client: $CLIENT_NAME"
    
    cd /etc/openvpn/easy-rsa/
    
    echo "yes" | ./easyrsa build-client-full $CLIENT_NAME nopass >&2
    
    mkdir -p /etc/openvpn/clients
    
    cat > /etc/openvpn/clients/$CLIENT_NAME.ovpn << EOF
client
dev tun
proto udp
remote $SERVER_IP 1194
resolv-retry infinite
nobind
persist-key
persist-tun
remote-cert-tls server
cipher AES-256-GCM
auth SHA256
compress lz4-v2
verb 3

<ca>
$(cat pki/ca.crt)
</ca>

<cert>
$(sed -ne '/BEGIN CERTIFICATE/,$ p' pki/issued/$CLIENT_NAME.crt)
</cert>

<key>
$(cat pki/private/$CLIENT_NAME.key)
</key>

<tls-auth>
$(cat pki/ta.key)
</tls-auth>
key-direction 1
EOF

    log "Konfigurasi client $CLIENT_NAME berhasil dibuat"
}

# Start services
start_services() {
    log "Memulai layanan OpenVPN..."
    
    systemctl enable openvpn-server@server
    systemctl start openvpn-server@server
    
    sleep 3
    
    if systemctl is-active --quiet openvpn-server@server; then
        log "OpenVPN server berhasil dijalankan"
    else
        error "Gagal menjalankan OpenVPN server"
        journalctl -xeu openvpn-server@server --no-pager -n 20
        exit 1
    fi
}

# Setup web server
setup_web_server() {
    log "Mengsetup web server untuk download config..."
    
    if [[ $OS == "debian" ]]; then
        apt-get install -y nginx >&2 &
        show_loading $!
    elif [[ $OS == "centos" ]]; then
        yum install -y nginx >&2 &
        show_loading $!
    fi
    
    mkdir -p /var/www/openvpn
    cp /etc/openvpn/clients/*.ovpn /var/www/openvpn/
    
    cat > /var/www/openvpn/index.html << EOF
<!DOCTYPE html>
<html>
<head>
    <title>OpenVPN Config - $USER_NAME</title>
    <style>
        body { 
            font-family: Arial, sans-serif; 
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            margin: 0; padding: 20px; color: white;
        }
        .container { 
            max-width: 800px; margin: 0 auto; 
            background: rgba(255,255,255,0.1);
            padding: 30px; border-radius: 15px;
            backdrop-filter: blur(10px);
        }
        h1 { text-align: center; margin-bottom: 30px; }
        .user-info {
            background: rgba(0,255,0,0.2);
            padding: 15px; border-radius: 10px;
            margin-bottom: 20px; text-align: center;
        }
        .config-list { 
            background: rgba(255,255,255,0.1);
            padding: 20px; border-radius: 10px;
        }
        a { 
            color: #fff; text-decoration: none; 
            display: block; padding: 10px;
            background: rgba(255,255,255,0.2);
            margin: 10px 0; border-radius: 5px;
            transition: all 0.3s;
        }
        a:hover { 
            background: rgba(255,255,255,0.3);
            transform: translateY(-2px);
        }
        .footer {
            text-align: center; margin-top: 30px;
            opacity: 0.7;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🔐 OpenVPN Configuration</h1>
        <div class="user-info">
            <h2>👤 User: $USER_NAME</h2>
            <p>✅ Konfigurasi berhasil dibuat khusus untuk Anda</p>
        </div>
        <div class="config-list">
            <h3>📱 Download Configuration:</h3>
            <a href="$USER_NAME.ovpn">📄 Download $USER_NAME.ovpn</a>
        </div>
        <div class="footer">
            <p>🚀 Server IP: $SERVER_IP | Port: 1194</p>
            <p>✅ OpenVPN Server Successfully Configured</p>
        </div>
    </div>
</body>
</html>
EOF

    cat > /etc/nginx/sites-available/openvpn << EOF
server {
    listen 8080;
    server_name _;
    
    root /var/www/openvpn;
    index index.html;
    
    location / {
        try_files \$uri \$uri/ =404;
    }
    
    location ~ \.ovpn$ {
        add_header Content-Type application/x-openvpn-profile;
        add_header Content-Disposition "attachment";
    }
}
EOF

    if [[ -d /etc/nginx/sites-enabled ]]; then
        ln -sf /etc/nginx/sites-available/openvpn /etc/nginx/sites-enabled/
        rm -f /etc/nginx/sites-enabled/default
    fi
    
    iptables -A INPUT -p tcp --dport 8080 -j ACCEPT
    if [[ $OS == "debian" ]]; then
        iptables-save > /etc/iptables/rules.v4
    fi
    
    systemctl enable nginx
    systemctl restart nginx
    
    log "Web server berhasil dikonfigurasi"
}

# Create management script with user info
create_management_script() {
    log "Membuat script manajemen..."
    
    cat > /usr/local/bin/openvpn-manager-$USER_NAME << EOF
#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

USER_NAME="$USER_NAME"

show_menu() {
    clear
    echo -e "\${BLUE}╔══════════════════════════════════╗\${NC}"
    echo -e "\${BLUE}║      \${YELLOW}OpenVPN Manager\${BLUE}           ║\${NC}"
    echo -e "\${BLUE}║        \${GREEN}User: \$USER_NAME\${BLUE}             ║\${NC}"
    echo -e "\${BLUE}╚══════════════════════════════════╝\${NC}"
    echo
    echo -e "\${GREEN}1.\${NC} Tambah Client Baru"
    echo -e "\${GREEN}2.\${NC} Lihat Client Aktif"
    echo -e "\${GREEN}3.\${NC} Restart OpenVPN"
    echo -e "\${GREEN}4.\${NC} Lihat Log"
    echo -e "\${GREEN}5.\${NC} Exit"
    echo
}

add_client() {
    echo -e "\${YELLOW}Masukkan nama client baru:\${NC}"
    read -p "> " CLIENT_NAME
    
    if [[ -z \$CLIENT_NAME ]]; then
        echo -e "\${RED}Nama client tidak boleh kosong!\${NC}"
        return
    fi
    
    cd /etc/openvpn/easy-rsa/
    echo "yes" | ./easyrsa build-client-full \$CLIENT_NAME nopass
    
    SERVER_IP=\$(curl -s ipv4.icanhazip.com)
    
    cat > /etc/openvpn/clients/\$CLIENT_NAME.ovpn << EOL
client
dev tun
proto udp
remote \$SERVER_IP 1194
resolv-retry infinite
nobind
persist-key
persist-tun
remote-cert-tls server
cipher AES-256-GCM
auth SHA256
compress lz4-v2
verb 3

<ca>
\$(cat pki/ca.crt)
</ca>

<cert>
\$(sed -ne '/BEGIN CERTIFICATE/,$ p' pki/issued/\$CLIENT_NAME.crt)
</cert>

<key>
\$(cat pki/private/\$CLIENT_NAME.key)
</key>

<tls-auth>
\$(cat pki/ta.key)
</tls-auth>
key-direction 1
EOL

    cp /etc/openvpn/clients/\$CLIENT_NAME.ovpn /var/www/openvpn/
    systemctl reload nginx
    
    echo -e "\${GREEN}Client \$CLIENT_NAME berhasil ditambahkan!\${NC}"
    echo -e "\${BLUE}Download di: http://\$SERVER_IP:8080/\$CLIENT_NAME.ovpn\${NC}"
}

while true; do
    show_menu
    read -p "Pilih opsi: " choice
    case \$choice in
        1) add_client ;;
        2) systemctl status openvpn-server@server ;;
        3) systemctl restart openvpn-server@server && echo -e "\${GREEN}OpenVPN restarted\${NC}" ;;
        4) tail -f /var/log/openvpn/openvpn.log ;;
        5) exit 0 ;;
        *) echo -e "\${RED}Pilihan tidak valid!\${NC}" ;;
    esac
    read -p "Tekan Enter untuk melanjutkan..."
done
EOF

    chmod +x /usr/local/bin/openvpn-manager-$USER_NAME
    log "Script manajemen berhasil dibuat"
}

# Main installation process
main() {
    # Validasi parameter dan metode eksekusi
    validate_parameters "$@"
    check_execution_method
    
    show_banner
    
    echo -e "${YELLOW}🚀 Memulai instalasi OpenVPN Server untuk user: ${GREEN}$USER_NAME${NC}"
    echo
    
    check_root
    detect_os
    get_server_ip
    
    echo -e "${BLUE}📋 Informasi Server:${NC}"
    echo -e "   OS: $ID $VERSION_ID"
    echo -e "   IP: $SERVER_IP"
    echo -e "   User: ${GREEN}$USER_NAME${NC}"
    echo
    
    read -p "Lanjutkan instalasi? (y/n): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
    
    echo
    update_system
    install_dependencies
    setup_easyrsa
    configure_server
    setup_iptables
    create_client_config
    start_services
    setup_web_server
    create_management_script
    
    echo
    echo -e "${GREEN}╔══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║                    🎉 INSTALASI SELESAI! 🎉               ║${NC}"
    echo -e "${GREEN}╚══════════════════════════════════════════════════════════╝${NC}"
    echo
    echo -e "${CYAN}👤 User: ${YELLOW}$USER_NAME${NC}"
    echo -e "${CYAN}📱 Download Konfigurasi:${NC}"
    echo -e "   🌐 Web: ${YELLOW}http://$SERVER_IP:8080${NC}"
    echo -e "   📄 Direct: ${YELLOW}http://$SERVER_IP:8080/$USER_NAME.ovpn${NC}"
    echo
    echo -e "${CYAN}🔧 Manajemen Server:${NC}"
    echo -e "   Jalankan: ${YELLOW}openvpn-manager-$USER_NAME${NC}"
    echo
    echo -e "${CYAN}📊 Status Server:${NC}"
    echo -e "   IP Server: ${GREEN}$SERVER_IP${NC}"
    echo -e "   Port: ${GREEN}1194/UDP${NC}"
    echo -e "   Protocol: ${GREEN}OpenVPN${NC}"
    echo
    echo -e "${GREEN}✅ Server siap digunakan untuk user $USER_NAME!${NC}"
}

# Jalankan instalasi dengan parameter
main "$@"
