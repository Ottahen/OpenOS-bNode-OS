# OpenOS/bNode Installation & Deployment Guide

**Version**: 1.0.0  
**Last Updated**: June 2026  
**Maintainer**: OpenOS/bNode Project

---

## Table of Contents

1. [System Requirements](#system-requirements)
2. [Installation Methods](#installation-methods)
3. [Building from Source](#building-from-source)
4. [Docker Deployment](#docker-deployment)
5. [Post-Installation Configuration](#post-installation-configuration)
6. [Troubleshooting](#troubleshooting)
7. [Security Hardening](#security-hardening)
8. [Performance Tuning](#performance-tuning)

---

## System Requirements

### Minimum Requirements

- **CPU**: 2 cores @ 2.0 GHz (Intel/AMD x86_64 or ARM64)
- **RAM**: 4 GB DDR4 or newer
- **Storage**: 20 GB SSD (NVMe recommended for optimal performance)
- **GPU**: Integrated graphics (dedicated GPU optional)
- **Display**: 1024x768 or higher resolution
- **Network**: Ethernet or WiFi adapter
- **Firmware**: UEFI or BIOS with boot support

### Recommended Requirements

- **CPU**: 4+ cores @ 2.5 GHz or higher
- **RAM**: 8-16 GB DDR4/DDR5
- **Storage**: 50+ GB NVMe SSD
- **GPU**: NVIDIA/AMD dedicated GPU for better performance
- **Display**: 1920x1080 or higher (4K supported)
- **Network**: Gigabit Ethernet for faster downloads

### Supported Hardware

**Processors**: Intel Core i5/i7/i9, AMD Ryzen 5/7/9, Apple Silicon (M1+)

**Graphics**: NVIDIA (GeForce/RTX), AMD (Radeon), Intel (Iris/Arc), Apple GPU

**Storage**: SATA SSD, NVMe M.2, USB 3.0+ external drives

---

## Installation Methods

### Method 1: USB Installation (Recommended)

#### Prerequisites

- OpenOS/bNode ISO file (openos-bnode.iso)
- USB drive with 8+ GB capacity
- Another computer with Linux, macOS, or Windows

#### Steps

**Step 1: Download ISO**

```bash
# Download the latest OpenOS/bNode ISO
wget https://releases.openos-bnode.dev/openos-bnode-1.0.0.iso
```

**Step 2: Create Bootable USB**

On Linux or macOS:

```bash
# Identify USB drive
lsblk  # Linux
diskutil list  # macOS

# Write ISO to USB (replace sdX with your USB device)
sudo dd if=openos-bnode-1.0.0.iso of=/dev/sdX bs=4M && sync

# Eject USB
sudo eject /dev/sdX
```

On Windows (using Rufus or Etcher):

1. Download [Rufus](https://rufus.ie/) or [Balena Etcher](https://www.balena.io/etcher/)
2. Select the ISO file
3. Select the USB drive
4. Click "Write" or "Flash"

**Step 3: Boot from USB**

1. Insert USB into target computer
2. Restart and enter boot menu (F12, F2, Del, or Esc depending on manufacturer)
3. Select USB drive as boot device
4. Press Enter to start OpenOS/bNode installer

**Step 4: Run Installer**

```bash
# The installer will start automatically
# Follow on-screen prompts for:
# - Disk selection and partitioning
# - Hostname configuration
# - User account creation
# - Password setup
# - Timezone selection
# - Package selection
```

**Step 5: Complete Installation**

```bash
# After installation completes, remove USB and reboot
# System will boot into OpenOS/bNode
```

### Method 2: Virtual Machine (VirtualBox/KVM)

#### VirtualBox Steps

```bash
# Create new VM
VBoxManage createvm --name "OpenOS-bNode" --ostype Ubuntu_64 --register

# Configure VM
VBoxManage modifyvm "OpenOS-bNode" \
  --cpus 4 \
  --memory 8192 \
  --vram 128 \
  --nic1 bridged \
  --bridgeadapter1 eth0

# Create disk
VBoxManage createhd --filename ~/VirtualBox\ VMs/OpenOS-bNode/disk.vdi \
  --size 50000 \
  --format VDI

# Attach disk
VBoxManage storagectl "OpenOS-bNode" --name "SATA" --add sata
VBoxManage storageattach "OpenOS-bNode" --storagectl "SATA" \
  --port 0 --device 0 --type hdd --medium ~/VirtualBox\ VMs/OpenOS-bNode/disk.vdi

# Attach ISO
VBoxManage storageattach "OpenOS-bNode" --storagectl "SATA" \
  --port 1 --device 0 --type dvddrive --medium openos-bnode-1.0.0.iso

# Start VM
VBoxManage startvm "OpenOS-bNode" --type gui
```

#### KVM/QEMU Steps

```bash
# Create disk
qemu-img create -f qcow2 openos-bnode.qcow2 50G

# Launch VM
qemu-system-x86_64 \
  -name "OpenOS-bNode" \
  -m 8192 \
  -smp 4 \
  -hda openos-bnode.qcow2 \
  -cdrom openos-bnode-1.0.0.iso \
  -boot d \
  -enable-kvm \
  -display gtk
```

---

## Building from Source

### Prerequisites

```bash
# Install build dependencies
sudo apt-get update
sudo apt-get install -y \
  build-essential \
  debootstrap \
  xorriso \
  grub-pc-bin \
  grub-efi-amd64-bin \
  git \
  curl \
  wget \
  squashfs-tools \
  libelf-dev \
  libssl-dev \
  bc \
  bison \
  flex \
  rustc \
  cargo \
  pkg-config
```

### Building the OS

```bash
# Clone OpenOS repository
git clone https://github.com/openos-bnode/os.git
cd os

# Run build script
sudo bash build-openos.sh \
  --arch x86_64 \
  --output ./openos-bnode.iso \
  --jobs $(nproc) \
  --verbose

# Build takes 30-60 minutes depending on hardware
# Output: openos-bnode.iso
```

### Build Options

```bash
# Skip kernel compilation (use pre-built)
sudo bash build-openos.sh --skip-kernel

# Skip UI compilation
sudo bash build-openos.sh --skip-ui

# Specify output location
sudo bash build-openos.sh --output /tmp/openos-bnode.iso

# Use specific number of parallel jobs
sudo bash build-openos.sh --jobs 8

# Enable verbose output for debugging
sudo bash build-openos.sh --verbose
```

---

## Docker Deployment

### Building Docker Image

```bash
# Build Docker image
docker build -f Dockerfile.openos -t openos-bnode:1.0 .

# Build takes 10-20 minutes
# Image size: ~3-4 GB
```

### Running Container

```bash
# Interactive shell
docker run -it openos-bnode:1.0 bash

# With volume mount
docker run -it -v /home/user/data:/home/openos/data openos-bnode:1.0 bash

# With GPU support (NVIDIA)
docker run -it --gpus all openos-bnode:1.0 bash

# Detached mode with port forwarding
docker run -d \
  -p 2222:22 \
  -p 8080:8080 \
  -v openos-data:/home/openos \
  --name openos-bnode \
  openos-bnode:1.0
```

### Docker Compose

```yaml
# docker-compose.yml
version: '3.8'

services:
  openos-bnode:
    build:
      context: .
      dockerfile: Dockerfile.openos
    image: openos-bnode:1.0
    container_name: openos-bnode-dev
    stdin_open: true
    tty: true
    volumes:
      - openos-home:/home/openos
      - openos-root:/root
    environment:
      - LANG=en_US.UTF-8
      - LC_ALL=en_US.UTF-8
    ports:
      - "2222:22"
      - "8080:8080"
    networks:
      - openos-network

volumes:
  openos-home:
  openos-root:

networks:
  openos-network:
    driver: bridge
```

Run with Docker Compose:

```bash
docker-compose up -d
docker-compose exec openos-bnode bash
```

---

## Post-Installation Configuration

### Initial Setup

```bash
# Update system
sudo apt-get update
sudo apt-get upgrade -y

# Configure hostname
sudo hostnamectl set-hostname openos-bnode

# Set timezone
sudo timedatectl set-timezone UTC

# Enable SSH (optional)
sudo systemctl enable ssh
sudo systemctl start ssh
```

### User Configuration

```bash
# Create new user
sudo useradd -m -s /bin/bash -G sudo,docker newuser
sudo passwd newuser

# Switch to user
su - newuser

# Configure SSH keys (optional)
ssh-keygen -t ed25519 -C "user@openos-bnode"
```

### Network Configuration

```bash
# View network interfaces
ip link show

# Configure static IP (netplan)
sudo cat > /etc/netplan/01-openos.yaml << 'EOF'
network:
  version: 2
  ethernets:
    eth0:
      dhcp4: true
      dhcp6: true
EOF

# Apply configuration
sudo netplan apply
```

### Firewall Setup

```bash
# Enable UFW
sudo ufw enable

# Allow SSH
sudo ufw allow 22/tcp

# Allow HTTP/HTTPS
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp

# Check status
sudo ufw status
```

### Install Additional Software

```bash
# Development tools
sudo apt-get install -y \
  git \
  vim \
  tmux \
  htop \
  curl \
  wget

# Python development
sudo apt-get install -y \
  python3-dev \
  python3-pip \
  python3-venv

# Node.js development
sudo apt-get install -y \
  nodejs \
  npm

# Rust development
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

---

## Troubleshooting

### Boot Issues

**Problem**: System won't boot from USB

**Solution**:
```bash
# Verify ISO integrity
sha256sum openos-bnode-1.0.0.iso
# Compare with official checksum

# Re-write ISO to USB
sudo dd if=openos-bnode-1.0.0.iso of=/dev/sdX bs=4M
sudo sync
```

**Problem**: GRUB boot menu not appearing

**Solution**:
```bash
# Boot into recovery mode
# Press 'e' at GRUB menu to edit
# Add 'nomodeset' to kernel parameters
# Press Ctrl+X to boot

# After boot, reinstall GRUB
sudo grub-install /dev/sda
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

### Installation Issues

**Problem**: Disk partitioning fails

**Solution**:
```bash
# Boot into live environment
# Clear partition table
sudo parted /dev/sda mklabel gpt
sudo parted /dev/sda mkpart primary ext4 0% 100%

# Retry installation
```

**Problem**: Out of disk space during installation

**Solution**:
```bash
# Ensure 50+ GB free space
df -h

# Use smaller ISO (minimal installation)
# Install additional packages after boot
```

### Runtime Issues

**Problem**: Low performance

**Solution**:
```bash
# Check system resources
htop
free -h
df -h

# Enable performance governor
echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

# Disable swap if not needed
sudo swapoff -a
```

**Problem**: Network not working

**Solution**:
```bash
# Check network interfaces
ip link show

# Restart networking
sudo systemctl restart networking

# Check DNS
cat /etc/resolv.conf
sudo systemctl restart systemd-resolved
```

---

## Security Hardening

### Kernel Hardening

```bash
# Apply kernel hardening parameters
sudo sysctl -w kernel.kptr_restrict=2
sudo sysctl -w kernel.dmesg_restrict=1
sudo sysctl -w kernel.unprivileged_userns_clone=0
sudo sysctl -w kernel.yama.ptrace_scope=2

# Make persistent
sudo cat > /etc/sysctl.d/99-openos-hardening.conf << 'EOF'
kernel.kptr_restrict = 2
kernel.dmesg_restrict = 1
kernel.unprivileged_userns_clone = 0
kernel.yama.ptrace_scope = 2
EOF

sudo sysctl -p /etc/sysctl.d/99-openos-hardening.conf
```

### SSH Hardening

```bash
# Generate SSH keys
ssh-keygen -t ed25519 -C "openos-bnode"

# Configure SSH
sudo cat > /etc/ssh/sshd_config.d/99-openos.conf << 'EOF'
PermitRootLogin no
PasswordAuthentication no
PubkeyAuthentication yes
X11Forwarding no
MaxAuthTries 3
MaxSessions 2
ClientAliveInterval 300
ClientAliveCountMax 2
EOF

# Restart SSH
sudo systemctl restart ssh
```

### Firewall Rules

```bash
# Default deny incoming
sudo ufw default deny incoming
sudo ufw default allow outgoing

# Allow SSH
sudo ufw allow 22/tcp

# Allow specific ports
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp

# Enable firewall
sudo ufw enable
```

### Full Disk Encryption

```bash
# During installation, select "Encrypt the new OpenOS installation"
# Or encrypt existing partition:

sudo apt-get install -y cryptsetup

# Backup data first!
sudo cryptsetup luksFormat /dev/sda1
sudo cryptsetup luksOpen /dev/sda1 encrypted-disk
sudo mkfs.ext4 /dev/mapper/encrypted-disk
```

---

## Performance Tuning

### I/O Optimization

```bash
# Check current I/O scheduler
cat /sys/block/sda/queue/scheduler

# Set BFQ scheduler (recommended)
echo bfq | sudo tee /sys/block/sda/queue/scheduler

# Make persistent
echo 'ACTION=="add|change", KERNEL=="sd*", ATTR{queue/scheduler}="bfq"' | \
  sudo tee /etc/udev/rules.d/60-iosched.rules
```

### Memory Optimization

```bash
# Reduce swappiness
sudo sysctl -w vm.swappiness=10

# Optimize vfs cache
sudo sysctl -w vm.vfs_cache_pressure=50

# Make persistent
echo 'vm.swappiness = 10' | sudo tee -a /etc/sysctl.conf
echo 'vm.vfs_cache_pressure = 50' | sudo tee -a /etc/sysctl.conf
```

### CPU Optimization

```bash
# Set performance governor
echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

# Or use powersave for laptops
echo powersave | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

# Make persistent with cpupower
sudo apt-get install -y linux-cpupower
sudo cpupower frequency-set -g performance
```

---

## Next Steps

After installation, explore OpenOS/bNode:

1. **Customize Theme**: Settings → Appearance → Theme
2. **Configure Keyboard**: Settings → Input → Keyboard
3. **Set Up Development Environment**: Install your preferred tools
4. **Enable Optional Features**: OLLAMA, Docker, additional languages
5. **Join Community**: GitHub, Forums, Discord

For more information, visit: https://docs.openos-bnode.dev

---

## Support & Feedback

- **Documentation**: https://docs.openos-bnode.dev
- **GitHub Issues**: https://github.com/openos-bnode/os/issues
- **Community Forum**: https://forum.openos-bnode.dev
- **Security Issues**: security@openos-bnode.dev

---

**OpenOS/bNode v1.0.0 - Privacy-First Linux Operating System**
