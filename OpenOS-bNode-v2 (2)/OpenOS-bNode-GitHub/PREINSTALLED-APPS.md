# 🎉 OpenOS/bNode - Pre-installed Applications

**Version**: 1.0.0 Enhanced  
**Total Pre-installed Apps**: 20+  
**Auto-start Services**: 10+  

---

## 📱 **Android App Store**

### **Aurora Store**
- **What**: Alternative Google Play Store
- **Purpose**: Download Android apps without Google Play
- **Status**: Pre-installed with Waydroid
- **Launch**: `waydroid show-full-ui`
- **Features**:
  - Privacy-focused
  - No tracking
  - Free apps
  - Works offline

---

## ☁️ **Cloud & Storage**

### **Nextcloud**
- **What**: Self-hosted file sync platform
- **Purpose**: Store and sync files, calendars, contacts
- **Port**: 80/443
- **Access**: `http://localhost`
- **Features**:
  - File sync
  - Collaborative editing
  - Calendar & contacts
  - End-to-end encryption
  - No vendor lock-in

**Setup**:
```bash
docker ps | grep nextcloud
# Access at http://localhost
```

---

## 💬 **Communication**

### **Jitsi Meet**
- **What**: Video conferencing platform
- **Purpose**: Host video meetings
- **Port**: 8080/8443
- **Access**: `http://localhost:8080`
- **Features**:
  - Screen sharing
  - Recording
  - Encryption
  - No account needed
  - Open-source

**Start Meeting**:
```bash
# Visit http://localhost:8080
# Create room name and share link
```

### **Element (Matrix)**
- **What**: Encrypted messaging platform
- **Purpose**: Decentralized communication
- **Port**: 8081
- **Access**: `http://localhost:8081`
- **Features**:
  - End-to-end encryption
  - Decentralized
  - Voice & video calls
  - File sharing
  - Cross-platform

**Setup**:
```bash
# Visit http://localhost:8081
# Create account or join existing server
```

---

## 📧 **Email**

### **Mailcow**
- **What**: Full-featured mail server
- **Purpose**: Host your own email
- **Ports**: 25, 465, 587, 993, 995
- **Access**: `https://localhost`
- **Features**:
  - Multiple domains
  - Spam filtering
  - Virus scanning
  - SSL/TLS encryption
  - Web admin panel

**Setup**:
```bash
# Visit https://localhost
# Configure mail domains
# Create user accounts
```

---

## 🔐 **Security**

### **Vaultwarden**
- **What**: Password manager (Bitwarden compatible)
- **Purpose**: Secure password storage
- **Port**: 8082
- **Access**: `http://localhost:8082`
- **Features**:
  - End-to-end encryption
  - Self-hosted
  - 2FA support
  - Cross-platform
  - No cloud dependency

**Setup**:
```bash
# Visit http://localhost:8082
# Create account
# Install Bitwarden extension
```

---

## 📝 **Productivity**

### **AFFiNE**
- **What**: Knowledge base and workspace
- **Purpose**: Notes, whiteboarding, databases
- **Port**: 8083
- **Access**: `http://localhost:8083`
- **Features**:
  - Note-taking
  - Whiteboarding
  - Database
  - Collaborative editing
  - Real-time sync

**Usage**:
```bash
# Visit http://localhost:8083
# Create workspace
# Start collaborating
```

---

## 🔍 **Search**

### **SearXNG**
- **What**: Privacy-focused metasearch engine
- **Purpose**: Search without tracking
- **Port**: 8084
- **Access**: `http://localhost:8084`
- **Features**:
  - No tracking
  - No ads
  - Multiple search engines
  - Decentralized
  - Open-source

**Usage**:
```bash
# Visit http://localhost:8084
# Search anything
# Results from multiple engines
```

---

## 🤖 **AI & Machine Learning**

### **Open WebUI + OLLAMA**
- **What**: Local AI models with web interface
- **Purpose**: Run AI models locally
- **Ports**: 11434 (OLLAMA), 8085 (WebUI)
- **Access**: `http://localhost:8085`
- **Features**:
  - No cloud required
  - Privacy-first
  - GPU acceleration
  - Multiple models
  - Chat interface

**Available Models**:
- Llama 2
- Mistral
- Neural Chat
- CodeLlama
- Orca

**Usage**:
```bash
# Visit http://localhost:8085
# Select model
# Start chatting
# Generate code
# Ask questions
```

**Download Models**:
```bash
ollama pull llama2
ollama pull mistral
ollama pull neural-chat
ollama pull codellama
```

---

## 🔧 **Development**

### **Gitea**
- **What**: Self-hosted Git service
- **Purpose**: Host your own repositories
- **Ports**: 3000 (HTTP), 2222 (SSH)
- **Access**: `http://localhost:3000`
- **Features**:
  - GitHub-like interface
  - Issue tracking
  - Pull requests
  - Wiki
  - CI/CD integration

**Setup**:
```bash
# Visit http://localhost:3000
# Create account
# Create repository
# Push code
```

**SSH Access**:
```bash
git clone ssh://git@localhost:2222/username/repo.git
```

---

## 🎬 **Entertainment**

### **ANI-CLI**
- **What**: Command-line anime streaming
- **Purpose**: Stream anime from terminal
- **Installation**: Pre-installed
- **Usage**: Terminal command
- **Features**:
  - No ads
  - Free
  - Lightweight
  - Fast
  - Multiple sources

**Usage**:
```bash
# Start ANI-CLI
ani-cli

# Search for anime
ani-cli search "anime-name"

# Help
ani-cli --help
```

---

## 🚀 **Quick Start Guide**

### **Access All Services**

| Service | URL | Port |
|---------|-----|------|
| **Nextcloud** | http://localhost | 80 |
| **Jitsi Meet** | http://localhost:8080 | 8080 |
| **Element** | http://localhost:8081 | 8081 |
| **Vaultwarden** | http://localhost:8082 | 8082 |
| **AFFiNE** | http://localhost:8083 | 8083 |
| **SearXNG** | http://localhost:8084 | 8084 |
| **Open WebUI** | http://localhost:8085 | 8085 |
| **Gitea** | http://localhost:3000 | 3000 |
| **Mailcow** | https://localhost | 443 |

### **Start All Services**

```bash
# All services start automatically on boot
# Check status:
docker ps

# View logs:
docker logs nextcloud
docker logs jitsi-meet
docker logs element
docker logs vaultwarden
docker logs affine
docker logs searxng
docker logs open-webui
docker logs gitea
docker logs mailcow
```

### **Stop/Restart Services**

```bash
# Stop all
docker stop $(docker ps -q)

# Restart all
docker restart $(docker ps -aq)

# Restart specific service
docker restart nextcloud
```

---

## 📊 **System Requirements for All Services**

**Minimum**:
- CPU: 4+ cores
- RAM: 8-16 GB
- Storage: 100+ GB SSD
- Network: 10 Mbps

**Recommended**:
- CPU: 8+ cores
- RAM: 32 GB
- Storage: 500+ GB NVMe
- Network: 100+ Mbps
- GPU: For AI models

---

## 🔒 **Security Considerations**

### **Enable HTTPS**
```bash
# Use Let's Encrypt certificates
# Configure SSL/TLS for each service
```

### **Firewall Rules**
```bash
# Allow only necessary ports
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw allow 8080/tcp
sudo ufw allow 8085/tcp
```

### **Backup Data**
```bash
# Backup important data
docker exec nextcloud tar -czf /backup/nextcloud.tar.gz /var/www/html
docker exec vaultwarden tar -czf /backup/vaultwarden.tar.gz /data
```

---

## 🛠️ **Troubleshooting**

### **Service Won't Start**
```bash
# Check logs
docker logs service-name

# Check ports
sudo netstat -tlnp | grep :8080

# Restart service
docker restart service-name
```

### **Can't Access Service**
```bash
# Check if container is running
docker ps | grep service-name

# Check network
docker network ls

# Check firewall
sudo ufw status
```

### **Performance Issues**
```bash
# Check resource usage
docker stats

# Increase resources
docker update --memory 4g service-name

# Restart
docker restart service-name
```

---

## 📚 **Documentation Links**

- **Nextcloud**: https://docs.nextcloud.com
- **Jitsi Meet**: https://jitsi.org/user-documentation
- **Element**: https://element.io/help
- **Mailcow**: https://mailcow.email/post-installation/
- **Vaultwarden**: https://github.com/dani-garcia/vaultwarden/wiki
- **AFFiNE**: https://affine.pro/docs
- **SearXNG**: https://docs.searxng.org
- **OLLAMA**: https://ollama.ai
- **Open WebUI**: https://github.com/open-webui/open-webui
- **Gitea**: https://docs.gitea.io
- **ANI-CLI**: https://github.com/pystardust/ani-cli

---

## 🎉 **Enjoy Your Pre-installed Apps!**

All services are configured and ready to use. Start exploring and building!

**Questions?** Check the documentation or visit the community forums.

---

**OpenOS/bNode v1.0.0 Enhanced**

*Privacy-First Linux with 20+ Pre-installed Applications*

*Designed by ℒ (OTTAHEN) • For Everyone*
