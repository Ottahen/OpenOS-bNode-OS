# OpenOS/bNode - Security & Android Features Guide

**Version**: 1.0.0 (Enhanced)  
**Designed by**: ℒ (OTTAHEN)  
**Release Date**: June 2026

---

## 🆕 New Features Added

This enhanced version of OpenOS/bNode includes powerful security and Android compatibility features:

### ✅ **ClamAV Antivirus** - Real-time malware protection
### ✅ **UFW Firewall** - Advanced network security
### ✅ **OpenVPN** - Pre-installed VPN client
### ✅ **Waydroid** - Run Android APKs natively on Linux

---

## 🛡️ Security Features

### 1. ClamAV Antivirus

**What it does**: Real-time malware scanning and detection

**Features**:
- Automatic virus definition updates
- Real-time file scanning
- Scheduled scans
- Quarantine infected files
- Multiple scanning engines

**Pre-installed**: ✅ Yes  
**Status**: Enabled by default  
**Service**: `clamav-daemon`

#### Using ClamAV

**Scan a file**:
```bash
clamscan /path/to/file
```

**Scan a directory**:
```bash
clamscan -r /home/user/Downloads
```

**Real-time monitoring**:
```bash
# Already running as daemon
systemctl status clamav-daemon
```

**Update virus definitions**:
```bash
sudo freshclam
```

**View scan logs**:
```bash
tail -f /var/log/clamav/clamav.log
```

**Configure ClamAV**:
```bash
sudo nano /etc/clamav/clamd.conf
sudo systemctl restart clamav-daemon
```

---

### 2. UFW Firewall

**What it does**: Advanced firewall with intelligent packet filtering

**Features**:
- Default deny incoming, allow outgoing
- Rate limiting for SSH
- Application profiles
- IPv4 and IPv6 support
- Logging and monitoring
- Easy rule management

**Pre-installed**: ✅ Yes  
**Status**: Enabled by default  
**Service**: `ufw`

#### Using UFW

**Check firewall status**:
```bash
sudo ufw status
sudo ufw status verbose
```

**Allow ports**:
```bash
# Allow SSH
sudo ufw allow 22/tcp

# Allow HTTP
sudo ufw allow 80/tcp

# Allow HTTPS
sudo ufw allow 443/tcp

# Allow specific IP
sudo ufw allow from 192.168.1.100 to any port 22
```

**Deny ports**:
```bash
sudo ufw deny 23/tcp
```

**Delete rules**:
```bash
sudo ufw delete allow 23/tcp
```

**Rate limiting** (prevent brute force):
```bash
sudo ufw limit 22/tcp
```

**View rules**:
```bash
sudo ufw show added
sudo ufw show raw
```

**Logging**:
```bash
# Enable logging
sudo ufw logging on

# View logs
sudo tail -f /var/log/ufw.log
```

**Reset firewall**:
```bash
sudo ufw reset
```

#### Pre-configured Rules

OpenOS/bNode comes with these pre-configured rules:

| Port | Protocol | Purpose |
|------|----------|---------|
| 22 | TCP/UDP | SSH (rate limited) |
| 53 | TCP/UDP | DNS |
| 80 | TCP | HTTP |
| 443 | TCP | HTTPS |
| 1194 | TCP/UDP | OpenVPN |

---

### 3. OpenVPN

**What it does**: Secure VPN client for encrypted connections

**Features**:
- OpenVPN 2.5+ support
- Multiple protocols (UDP, TCP)
- AES-256 encryption
- SHA256 authentication
- Kill switch support
- DNS leak protection
- Systemd integration

**Pre-installed**: ✅ Yes  
**Status**: Ready to configure  
**Service**: `openvpn@client`

#### Using OpenVPN

**Connect to VPN**:
```bash
# Copy your .ovpn config file to /etc/openvpn/client/
sudo cp my-vpn.ovpn /etc/openvpn/client/

# Start OpenVPN
sudo systemctl start openvpn@client

# Enable on boot
sudo systemctl enable openvpn@client

# Check status
sudo systemctl status openvpn@client
```

**View connection**:
```bash
# Check IP address (should be different)
curl https://api.ipify.org

# View VPN interface
ip addr show tun0
```

**Disconnect from VPN**:
```bash
sudo systemctl stop openvpn@client
```

**View logs**:
```bash
sudo journalctl -u openvpn@client -f
```

**Configure multiple VPN connections**:
```bash
# Copy config files
sudo cp vpn1.ovpn /etc/openvpn/client/
sudo cp vpn2.ovpn /etc/openvpn/client/

# Start specific VPN
sudo systemctl start openvpn@vpn1

# Or use generic client
sudo systemctl start openvpn@client
```

**Sample OpenVPN Configuration**:
```
client
dev tun
proto udp
remote vpn.example.com 1194
resolv-retry infinite
noexec
nobind
persist-key
persist-tun
ca ca.crt
cert client.crt
key client.key
cipher AES-256-GCM
auth SHA256
key-direction 1
remote-random
```

**Generate OpenVPN Keys** (if needed):
```bash
# Install easy-rsa
sudo apt-get install easy-rsa

# Create PKI
make-cadir ~/openvpn-ca
cd ~/openvpn-ca
./easyrsa init-pki

# Generate keys
./easyrsa build-ca
./easyrsa gen-req client nopass
./easyrsa sign-req client client
```

---

## 🤖 Android APK Support (Waydroid)

**What it does**: Run Android apps and APKs natively on Linux

**Features**:
- Full Android container
- Install APK files
- Run Android apps as native Linux apps
- Hardware acceleration support
- Seamless integration with Linux desktop
- Access to Linux filesystem

**Pre-installed**: ✅ Yes  
**Status**: Ready to initialize  
**Service**: `waydroid-container`

### Using Waydroid

#### Initialize Waydroid

```bash
# First time setup
sudo waydroid init

# Start container
sudo systemctl start waydroid-container

# Enable on boot
sudo systemctl enable waydroid-container
```

#### Install APK Files

**Method 1: Using Waydroid CLI**
```bash
# Install APK
waydroid app install /path/to/app.apk

# Install multiple APKs
waydroid app install app1.apk app2.apk app3.apk
```

**Method 2: Using Waydroid UI**
```bash
# Open Waydroid UI
waydroid show-full-ui

# Then use Google Play Store or install APKs from file manager
```

#### Launch Android Apps

**From command line**:
```bash
# Show full UI
waydroid show-full-ui

# Launch specific app
waydroid app launch com.example.app

# List installed apps
waydroid app list
```

**From desktop**:
- Android apps appear in application launcher
- Click to launch just like Linux apps
- Integrated into taskbar

#### Manage Android Apps

**List installed apps**:
```bash
waydroid app list
```

**Uninstall app**:
```bash
waydroid app remove com.example.app
```

**Clear app data**:
```bash
waydroid app clear com.example.app
```

**Get app info**:
```bash
waydroid app info com.example.app
```

#### Popular APKs to Install

**Productivity**:
- Microsoft Office apps
- Google Docs/Sheets/Slides
- Notion
- Todoist

**Communication**:
- WhatsApp
- Telegram
- Signal
- Discord

**Media**:
- Netflix
- YouTube
- Spotify
- TikTok

**Utilities**:
- VLC
- MX Player
- File managers
- System tools

#### Waydroid Troubleshooting

**Container won't start**:
```bash
# Check status
sudo waydroid status

# Restart container
sudo systemctl restart waydroid-container

# Check logs
sudo journalctl -u waydroid-container -f
```

**APK won't install**:
```bash
# Check if container is running
sudo waydroid status

# Try installing with verbose output
waydroid app install -v /path/to/app.apk

# Check available space
df -h /var/lib/waydroid/
```

**Performance issues**:
```bash
# Enable GPU acceleration
# Edit /etc/waydroid/waydroid.cfg
# Set: gpu_mode=host

# Allocate more RAM
# Edit /etc/waydroid/waydroid.cfg
# Set: memory=4096
```

**Reset Waydroid**:
```bash
# Stop container
sudo systemctl stop waydroid-container

# Reset
sudo waydroid init -f

# Restart
sudo systemctl start waydroid-container
```

---

## 🔐 Security Best Practices

### 1. Keep Everything Updated

```bash
# Update system
sudo apt-get update && sudo apt-get upgrade -y

# Update antivirus definitions
sudo freshclam

# Update firewall rules
sudo ufw reload
```

### 2. Monitor Security

```bash
# Check firewall logs
sudo tail -f /var/log/ufw.log

# Check antivirus logs
sudo tail -f /var/log/clamav/clamav.log

# Check system logs
sudo journalctl -p err -b
```

### 3. Secure SSH

```bash
# Generate strong SSH key
ssh-keygen -t ed25519 -C "user@openos-bnode"

# Disable password authentication
sudo nano /etc/ssh/sshd_config
# Set: PasswordAuthentication no

# Restart SSH
sudo systemctl restart ssh
```

### 4. Use VPN

```bash
# Always use VPN for public WiFi
sudo systemctl start openvpn@client

# Verify VPN is connected
curl https://api.ipify.org
```

### 5. Scan Downloads

```bash
# Scan downloaded files
clamscan ~/Downloads

# Quarantine infected files
clamscan -r --move=/var/quarantine ~/Downloads
```

---

## 📊 Feature Comparison

| Feature | OpenOS/bNode | Ubuntu | Fedora | Elementary |
|---------|--------------|--------|--------|------------|
| **ClamAV Antivirus** | ✅ Pre-installed | ⚠️ Manual install | ⚠️ Manual install | ⚠️ Manual install |
| **UFW Firewall** | ✅ Pre-configured | ✅ Available | ✅ Available | ✅ Available |
| **OpenVPN** | ✅ Pre-installed | ⚠️ Manual install | ⚠️ Manual install | ⚠️ Manual install |
| **Waydroid** | ✅ Pre-installed | ❌ Not available | ❌ Not available | ❌ Not available |
| **Android APK Support** | ✅ Full support | ❌ No | ❌ No | ❌ No |
| **Security Focus** | ✅ High | ⚠️ Medium | ✅ High | ⚠️ Medium |

---

## 🚀 Quick Start

### First Boot Security Setup

```bash
# 1. Update everything
sudo apt-get update && sudo apt-get upgrade -y

# 2. Check firewall
sudo ufw status

# 3. Update antivirus
sudo freshclam

# 4. Scan system
clamscan -r /home

# 5. Setup VPN (optional)
sudo cp my-vpn.ovpn /etc/openvpn/client/
sudo systemctl start openvpn@client
```

### Install First Android App

```bash
# 1. Initialize Waydroid
sudo waydroid init

# 2. Start container
sudo systemctl start waydroid-container

# 3. Install APK
waydroid app install ~/Downloads/app.apk

# 4. Launch app
waydroid app launch com.example.app
```

---

## 📚 Advanced Configuration

### Custom Firewall Rules

```bash
# Allow specific service
sudo ufw allow Samba

# Allow from specific subnet
sudo ufw allow from 192.168.1.0/24 to any port 22

# Block specific IP
sudo ufw deny from 10.0.0.5

# Complex rules
sudo ufw allow in on eth0 to 192.168.1.1 port 53
```

### OpenVPN Advanced

```bash
# Use TCP instead of UDP
# Edit /etc/openvpn/client/config.ovpn
# Change: proto udp
# To: proto tcp

# Enable compression
# Add: comp-lzo

# Enable keepalive
# Add: keepalive 10 120
```

### Waydroid Advanced

```bash
# Change resolution
waydroid prop set ro.displayfeature.screenresolution 1920x1080

# Enable debug mode
waydroid logcat

# Access Android shell
waydroid shell

# Mount Linux directory in Android
waydroid prop set ro.mount.media_rw_mount_point /mnt/media_rw
```

---

## 🔧 Troubleshooting

### Firewall Issues

**Problem**: Can't access service  
**Solution**: Check if port is allowed
```bash
sudo ufw allow PORT/PROTOCOL
```

### Antivirus Issues

**Problem**: ClamAV daemon not running  
**Solution**: Restart service
```bash
sudo systemctl restart clamav-daemon
sudo systemctl status clamav-daemon
```

### OpenVPN Issues

**Problem**: Can't connect to VPN  
**Solution**: Check configuration
```bash
sudo systemctl status openvpn@client
sudo journalctl -u openvpn@client -n 50
```

### Waydroid Issues

**Problem**: Apps won't launch  
**Solution**: Restart container
```bash
sudo systemctl restart waydroid-container
sudo waydroid init -f
```

---

## 📞 Support

- **Forum**: https://forum.openos-bnode.dev
- **Discord**: https://discord.gg/openos-bnode
- **GitHub**: https://github.com/openos-bnode/os/issues
- **Email**: support@openos-bnode.dev

---

## 📝 Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0.0 Enhanced | June 2026 | Added ClamAV, UFW, OpenVPN, Waydroid |
| 1.0.0 | June 2026 | Initial release |

---

**OpenOS/bNode v1.0.0 Enhanced - Privacy-First Linux with Security & Android Support**

*Designed by ℒ (OTTAHEN) • For Everyone*
