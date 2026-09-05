# OpenOS/bNode Quick Start Guide

**Version**: 1.0.0 | **Last Updated**: June 2026

---

## What is OpenOS/bNode?

OpenOS/bNode is a **privacy-first, performance-optimized Linux operating system** designed for developers and power users. It combines:

- **Hardened Linux Kernel** with security patches and no telemetry
- **Beautiful Glassmorphic UI** with cosmic minimalism design
- **Pre-installed Developer Tools**: Brave, VS Code, OnlyOffice, OLLAMA
- **Zero Tracking**: No data collection, no metadata harvesting
- **Full Kernel Control**: Advanced users can customize everything

---

## Installation (5 Minutes)

### Option 1: USB Installation (Recommended)

```bash
# 1. Download ISO
wget https://releases.openos-bnode.dev/openos-bnode-1.0.0.iso

# 2. Create bootable USB (replace sdX with your USB device)
sudo dd if=openos-bnode-1.0.0.iso of=/dev/sdX bs=4M && sync

# 3. Boot from USB and follow installer prompts
# 4. Reboot and enjoy OpenOS/bNode!
```

### Option 2: Docker (Instant)

```bash
# Build and run in Docker
docker build -f Dockerfile.openos -t openos-bnode:1.0 .
docker run -it openos-bnode:1.0 bash
```

### Option 3: Virtual Machine

```bash
# VirtualBox
VBoxManage createvm --name "OpenOS-bNode" --ostype Ubuntu_64 --register
# Configure and boot from ISO

# Or use KVM/QEMU
qemu-system-x86_64 -m 8192 -smp 4 -hda openos-bnode.qcow2 -cdrom openos-bnode-1.0.0.iso -enable-kvm
```

---

## First Boot

### Lock Screen

- **Time Display**: Centered, animated cosmic gradient background
- **Authentication**: Fingerprint or password
- **Wallpaper**: Beautiful space-themed image with stars

### Desktop

- **Dock**: Bottom dock with app icons (always visible)
- **Floating Windows**: Applications appear as floating cards
- **Right-Click Menu**: Quick access to common actions
- **Keyboard Shortcuts**:
  - `Cmd+Space`: Application launcher
  - `Cmd+Tab`: Switch between apps
  - `Cmd+Q`: Quit application
  - `Cmd+,`: Settings

---

## Essential Apps

### Pre-Installed

| App | Purpose | Keyboard Shortcut |
|-----|---------|-------------------|
| **Brave Browser** | Privacy-focused web browsing | `Cmd+B` |
| **VS Code** | Code editor with extensions | `Cmd+E` |
| **OnlyOffice** | Office suite (Writer, Calc, Impress) | `Cmd+O` |
| **File Manager** | Browse and manage files | `Cmd+F` |
| **Terminal** | Command-line interface | `Cmd+T` |
| **Settings** | System configuration | `Cmd+,` |
| **OLLAMA** | Local LLM inference (optional) | N/A |

### Launching Apps

```bash
# Using launcher (Cmd+Space)
# Type app name and press Enter

# Or from terminal
brave &
code &
onlyoffice &
```

---

## Development Setup

### Node.js

```bash
# Node.js and npm are pre-installed
node --version
npm --version

# Install packages
npm install -g pnpm yarn

# Create new project
npm init -y
npm install express
```

### Python

```bash
# Python 3.11+ is pre-installed
python3 --version

# Create virtual environment
python3 -m venv myenv
source myenv/bin/activate

# Install packages
pip install flask django numpy pandas
```

### Rust

```bash
# Rust is pre-installed
rustc --version
cargo --version

# Create new project
cargo new my-project
cd my-project
cargo build --release
```

### Git

```bash
# Configure Git
git config --global user.name "Your Name"
git config --global user.email "your@email.com"

# Generate SSH key
ssh-keygen -t ed25519 -C "your@email.com"

# Clone repository
git clone https://github.com/user/repo.git
```

---

## Customization

### Change Theme

1. Open **Settings** (Cmd+,)
2. Go to **Appearance** → **Theme**
3. Choose from:
   - **Cosmic Dark** (default)
   - **Cosmic Light**
   - **Custom** (create your own)

### Change Wallpaper

1. Right-click on desktop
2. Select **Change Wallpaper**
3. Browse and select image

### Keyboard Shortcuts

1. Open **Settings** (Cmd+,)
2. Go to **Keyboard** → **Shortcuts**
3. Customize shortcuts as needed

### Install Fonts

```bash
# Download fonts
wget https://fonts.google.com/download?family=Poppins

# Install
mkdir -p ~/.local/share/fonts
cp Poppins.ttf ~/.local/share/fonts/
fc-cache -fv
```

---

## Terminal Essentials

### File Management

```bash
# List files
ls -la

# Create directory
mkdir my-folder

# Copy file
cp source.txt destination.txt

# Move file
mv old-name.txt new-name.txt

# Delete file
rm file.txt

# Find files
find . -name "*.txt"
```

### System Information

```bash
# System info
uname -a
neofetch

# Disk usage
df -h
du -sh *

# Memory usage
free -h
top

# Network
ip addr show
ping google.com
```

### Package Management

```bash
# Update packages
sudo apt-get update
sudo apt-get upgrade

# Install package
sudo apt-get install package-name

# Remove package
sudo apt-get remove package-name

# Search package
apt-cache search keyword
```

### User & Permissions

```bash
# Current user
whoami

# Change password
passwd

# Add user to group
sudo usermod -aG group username

# Change file permissions
chmod 755 file.txt

# Change file owner
sudo chown user:group file.txt
```

---

## Security Tips

### Enable Firewall

```bash
# Enable UFW
sudo ufw enable

# Allow SSH
sudo ufw allow 22/tcp

# Check status
sudo ufw status
```

### SSH Keys

```bash
# Generate SSH key
ssh-keygen -t ed25519

# Copy to server
ssh-copy-id -i ~/.ssh/id_ed25519.pub user@server

# SSH without password
ssh user@server
```

### Encryption

```bash
# Encrypt file
gpg --encrypt --recipient email@example.com file.txt

# Decrypt file
gpg --decrypt file.txt.gpg
```

### System Updates

```bash
# Check for updates
sudo apt-get update

# Install updates
sudo apt-get upgrade

# Full upgrade (recommended monthly)
sudo apt-get dist-upgrade
```

---

## Troubleshooting

### System Won't Boot

```bash
# Boot into recovery mode
# Press 'e' at GRUB menu
# Add 'nomodeset' to kernel parameters
# Press Ctrl+X to boot

# After boot, check logs
sudo journalctl -xe
```

### Network Issues

```bash
# Check connection
ip link show

# Restart networking
sudo systemctl restart networking

# Check DNS
cat /etc/resolv.conf
```

### Performance Issues

```bash
# Check CPU usage
top

# Check disk I/O
iostat -x 1

# Check memory
free -h

# Enable performance mode
echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
```

### Application Crashes

```bash
# Check system logs
sudo journalctl -n 50

# Check application logs
~/.local/share/openos/logs/

# Reinstall application
sudo apt-get reinstall application-name
```

---

## Advanced Features

### OLLAMA (Local AI)

```bash
# Start OLLAMA service
sudo systemctl start ollama

# Download model
ollama pull llama2

# Run inference
ollama run llama2 "What is OpenOS/bNode?"
```

### Docker

```bash
# Start Docker daemon
sudo systemctl start docker

# Run container
docker run -it ubuntu:22.04 bash

# Build image
docker build -t myimage .

# Push to registry
docker push myimage
```

### Kernel Tuning

```bash
# View kernel parameters
sudo sysctl -a

# Set parameter
sudo sysctl -w vm.swappiness=10

# Make persistent
echo 'vm.swappiness = 10' | sudo tee -a /etc/sysctl.conf
sudo sysctl -p
```

---

## Useful Resources

- **Documentation**: https://docs.openos-bnode.dev
- **GitHub**: https://github.com/openos-bnode
- **Community Forum**: https://forum.openos-bnode.dev
- **Security**: https://openos-bnode.dev/security
- **Privacy Policy**: https://openos-bnode.dev/privacy

---

## Getting Help

### Common Issues

**Q: How do I update OpenOS/bNode?**
```bash
sudo apt-get update && sudo apt-get upgrade
```

**Q: How do I install a new application?**
```bash
sudo apt-get install application-name
```

**Q: How do I check system logs?**
```bash
sudo journalctl -xe
```

**Q: How do I enable SSH?**
```bash
sudo systemctl enable ssh
sudo systemctl start ssh
```

### Support Channels

- **GitHub Issues**: Report bugs and request features
- **Community Forum**: Ask questions and share tips
- **Email**: support@openos-bnode.dev
- **Security Issues**: security@openos-bnode.dev

---

## Next Steps

1. ✅ Install OpenOS/bNode
2. ✅ Customize theme and wallpaper
3. ✅ Set up development environment
4. ✅ Configure security settings
5. ✅ Join the community
6. ✅ Start building amazing things!

---

**Welcome to OpenOS/bNode! Enjoy your privacy-first, beautiful Linux experience. 🚀**
