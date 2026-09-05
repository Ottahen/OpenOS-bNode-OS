# 🔓 OpenOS/bNode - Cybersecurity & Hacking Tools Guide

**Version**: 2.0 Security Edition  
**Total Security Tools**: 80+  
**Penetration Testing Tools**: 50+  
**Terminal Tools**: 150+  
**Status**: ⚠️ **For Authorized Security Testing Only**

---

## ⚖️ **LEGAL DISCLAIMER**

**IMPORTANT**: These tools are for **authorized security testing only**. Unauthorized access to computer systems is **ILLEGAL** and can result in:
- Criminal charges
- Imprisonment
- Fines
- Civil lawsuits

**Use responsibly and legally!**

---

## 🔐 **CYBERSECURITY TOOLS (80+)**

### **Network Reconnaissance**

| Tool | Purpose | Usage |
|------|---------|-------|
| **Nmap** | Network scanning | `nmap -sV target.com` |
| **Masscan** | Fast port scanning | `masscan -p0-65535 target.com` |
| **Shodan** | Search internet devices | Web interface |
| **Amass** | Subdomain enumeration | `amass enum -d target.com` |
| **Subfinder** | Subdomain discovery | `subfinder -d target.com` |
| **TheHarvester** | Email/subdomain gathering | `theharvester -d target.com -b google` |
| **Recon-ng** | Web reconnaissance | Interactive framework |
| **Maltego** | OSINT visualization | GUI application |

### **Vulnerability Scanning**

| Tool | Purpose |
|------|---------|
| **Nikto** | Web server scanning |
| **Burp Suite Community** | Web application testing |
| **OWASP ZAP** | Web security scanning |
| **SQLMap** | SQL injection testing |
| **Wfuzz** | Web fuzzing |
| **FFuf** | Fast web fuzzer |
| **Gobuster** | Directory brute-forcing |
| **Dirb** | Web directory scanner |
| **DirBuster** | GUI directory scanner |

### **Exploitation**

| Tool | Purpose |
|------|---------|
| **Metasploit Framework** | Exploitation framework |
| **Exploit-DB** | Exploit database |
| **Searchsploit** | Search exploits offline |
| **Pwntools** | CTF/exploit development |
| **Scapy** | Packet crafting |
| **Impacket** | Network protocol tools |

### **Password Cracking**

| Tool | Purpose | Speed |
|------|---------|-------|
| **Hashcat** | GPU password cracking | 100 GB/s+ |
| **John the Ripper** | CPU password cracking | 1 GB/s+ |
| **Hydra** | Online brute-forcing | Protocol-dependent |
| **Medusa** | Parallel brute-forcing | Fast |
| **Ncrack** | Network service cracking | Fast |
| **Patator** | Multi-protocol brute-forcing | Flexible |
| **CeWL** | Custom wordlist generation | Targeted |
| **Hashid** | Hash type identification | Instant |

### **Wireless Hacking**

| Tool | Purpose |
|------|---------|
| **Aircrack-ng** | WiFi cracking suite |
| **Airmon-ng** | Monitor mode |
| **Airodump-ng** | Packet capture |
| **Aireplay-ng** | Packet injection |
| **Airbase-ng** | Fake AP |

### **Reverse Engineering**

| Tool | Purpose |
|------|---------|
| **Ghidra** | Binary analysis |
| **Radare2** | Reverse engineering framework |
| **Binwalk** | Binary extraction |
| **GDB** | Debugger |
| **Objdump** | Object file analysis |
| **Strings** | Extract strings |
| **Strace** | System call tracing |
| **Ltrace** | Library call tracing |

### **Forensics & Data Recovery**

| Tool | Purpose |
|------|---------|
| **Volatility** | Memory forensics |
| **Autopsy** | Digital forensics |
| **Sleuthkit** | Forensic analysis |
| **Foremost** | Data recovery |
| **PhotoRec** | File recovery |
| **TestDisk** | Partition recovery |
| **Steghide** | Steganography |
| **Stegsolve** | Image analysis |
| **Exiftool** | Metadata extraction |

### **Cryptography**

| Tool | Purpose |
|------|---------|
| **OpenSSL** | Encryption/decryption |
| **GPG** | PGP encryption |
| **Hashdeep** | Hash verification |
| **SSDeep** | Fuzzy hashing |

### **Windows Exploitation**

| Tool | Purpose |
|------|---------|
| **Evil-WinRM** | Windows shell |
| **CrackMapExec** | Windows enumeration |
| **SMBMap** | SMB enumeration |
| **Enum4linux** | Linux enumeration |

---

## 💻 **TERMUX & TERMINAL TOOLS (150+)**

### **Terminal Emulators**
- Termux (Android-like)
- Kitty (GPU accelerated)
- Alacritty (Fast)
- Tilix (Tiling)
- GNOME Terminal
- Xterm
- Rxvt-unicode

### **Shell Environments**
- Zsh (Advanced)
- Fish (User-friendly)
- Bash (Standard)
- Oh-my-zsh (Framework)
- Starship (Prompt)
- Powerlevel10k (Theme)

### **Terminal Multiplexers**
- Tmux (Powerful)
- Screen (Classic)
- Byobu (User-friendly)

### **Modern Unix Tools**
- **ripgrep** (Fast grep)
- **fd** (Fast find)
- **bat** (Better cat)
- **exa** (Better ls)
- **lsd** (Colorful ls)
- **fzf** (Fuzzy finder)
- **ncdu** (Disk usage)
- **tldr** (Quick help)
- **thefuck** (Command correction)
- **autojump** (Smart cd)

### **Programming Languages**
- Python 3
- Node.js
- Go
- Rust
- Ruby
- Java
- PHP
- Perl
- Lua
- Kotlin
- Scala
- Haskell
- Elixir
- Clojure

### **Version Managers**
- NVM (Node)
- Rbenv (Ruby)
- Pyenv (Python)
- Rustup (Rust)
- ASDF (Multi-language)

### **Package Managers**
- NPM (Node)
- Yarn (Node)
- PNPM (Node)
- Pip (Python)
- Poetry (Python)
- Pipenv (Python)
- Conda (Scientific)
- Mamba (Fast Conda)

### **Git Tools**
- Git (Version control)
- GitHub CLI (GitHub integration)
- Hub (Git wrapper)
- LazyGit (Interactive)
- Tig (Text interface)

### **Download Tools**
- Curl (HTTP client)
- Wget (File downloader)
- HTTPie (User-friendly curl)
- Aria2 (Multi-threaded)
- Transmission (Torrent)
- YouTube-DL (Video download)
- yt-dlp (Modern YouTube-DL)

### **Media Tools**
- FFmpeg (Video/audio)
- ImageMagick (Image processing)
- GraphicsMagick (Fast image)
- SoX (Audio processing)
- MPV (Video player)
- VLC (Media player)

### **Data Processing**
- Jq (JSON processing)
- Yq (YAML processing)
- Xmllint (XML processing)
- Pandoc (Document conversion)

### **System Monitoring**
- Top (Process monitor)
- Htop (Interactive top)
- Btop (Beautiful top)
- Iotop (I/O monitor)
- Nethogs (Network monitor)
- Iftop (Network traffic)
- Dstat (System stats)

### **File Management**
- Find (File search)
- Locate (Fast search)
- Rsync (File sync)
- Tree (Directory tree)
- Ls (List files)
- Cd (Change directory)
- Pwd (Print working directory)

### **Network Tools**
- Ping (Connectivity test)
- Traceroute (Route tracing)
- Mtr (Traceroute + ping)
- Dig (DNS lookup)
- Nslookup (DNS query)
- Host (DNS info)
- Whois (Domain info)
- SSH (Secure shell)
- SCP (Secure copy)
- SFTP (Secure FTP)
- Telnet (Remote connection)

---

## 🎬 **NEWPIPE & PRIVACY MEDIA**

### **YouTube Alternatives**
- **NewPipe** - YouTube without ads/tracking
- **Invidious** - Privacy YouTube frontend
- **Piped** - Lightweight YouTube
- **FreeTube** - Desktop YouTube client
- **Minitube** - Minimal YouTube client
- **SMTube** - Simple YouTube client

### **Features**
✅ No ads  
✅ No Google tracking  
✅ Video download  
✅ Audio extraction  
✅ Playlist management  
✅ Subscription management  
✅ Offline viewing  
✅ Format selection  
✅ Quality selection  
✅ Subtitle support  

### **Usage**
```bash
# Download video
youtube-dl https://www.youtube.com/watch?v=xxx

# Download audio only
youtube-dl -x https://www.youtube.com/watch?v=xxx

# Use NewPipe (GUI)
newpipe
```

---

## 🚫 **CHROME BAN POLICY**

### **Why Chrome is Blocked**

Chrome collects:
- ❌ Browsing history
- ❌ Search queries
- ❌ Location data
- ❌ Device information
- ❌ Behavioral data
- ❌ Cross-site tracking

### **Approved Browsers**

| Browser | Privacy | Speed | Features |
|---------|---------|-------|----------|
| **Firefox** | ✅ High | ✅ Fast | ✅ Excellent |
| **Brave** | ✅ Maximum | ✅ Very Fast | ✅ Ad-blocking |
| **LibreWolf** | ✅ Maximum | ✅ Fast | ✅ Hardened |
| **Tor Browser** | ✅ Maximum | ⚠️ Slow | ✅ Anonymity |
| **Ungoogled Chromium** | ✅ High | ✅ Very Fast | ✅ Chromium |

### **Installation**
```bash
# Firefox
sudo apt install firefox

# Brave
sudo apt install brave-browser

# LibreWolf
sudo apt install librewolf

# Tor Browser
sudo apt install tor torbrowser-launcher

# Ungoogled Chromium
sudo apt install ungoogled-chromium
```

---

## 🎯 **QUICK START GUIDE**

### **Network Scanning**
```bash
# Scan network
nmap -sV target.com

# Fast scanning
masscan -p0-65535 target.com

# Subdomain enumeration
amass enum -d target.com
```

### **Web Testing**
```bash
# SQL injection testing
sqlmap -u "http://target.com/page?id=1" --dbs

# Directory brute-forcing
gobuster dir -u http://target.com -w wordlist.txt

# Web fuzzing
wfuzz -c -z file,wordlist.txt http://target.com/FUZZ
```

### **Password Cracking**
```bash
# Identify hash type
hashid hash.txt

# Crack with Hashcat
hashcat -m 1000 hash.txt wordlist.txt

# Brute-force SSH
hydra -l admin -P wordlist.txt ssh://target.com
```

### **Reverse Engineering**
```bash
# Analyze binary
ghidra binary

# Use Radare2
radare2 binary

# Extract strings
strings binary
```

### **Terminal Productivity**
```bash
# Use Tmux
tmux new-session -s work

# Use Zsh with Starship
exec zsh

# Fuzzy find files
fzf

# Fast grep
rg "pattern" file
```

---

## 📚 **DOCUMENTATION & RESOURCES**

### **Learning Resources**
- HackTheBox (Practice)
- TryHackMe (Tutorials)
- OWASP (Web security)
- PortSwigger (Web testing)
- Exploit-DB (Exploits)
- GitHub (Tools & code)

### **Official Documentation**
- Metasploit: https://docs.metasploit.com
- Nmap: https://nmap.org/docs.html
- Burp Suite: https://portswigger.net/burp/documentation
- OWASP ZAP: https://www.zaproxy.org/docs/
- Ghidra: https://ghidra-sre.org/

---

## ⚠️ **RESPONSIBLE USE**

### **Legal Uses**
✅ Authorized penetration testing  
✅ Security research  
✅ CTF competitions  
✅ Personal lab testing  
✅ Educational purposes  
✅ Bug bounty programs  

### **Illegal Uses**
❌ Unauthorized network access  
❌ Data theft  
❌ System compromise  
❌ Denial of service  
❌ Malware distribution  
❌ Fraud  

---

## 🎓 **ETHICAL HACKING CAREER**

### **Certifications**
- CEH (Certified Ethical Hacker)
- OSCP (Offensive Security Certified Professional)
- GPEN (GIAC Penetration Tester)
- ECIH (Certified Incident Handler)
- Security+

### **Career Paths**
- Penetration Tester
- Security Researcher
- Bug Bounty Hunter
- Security Analyst
- Incident Response
- Forensics Analyst

---

## 🎉 **STAY SAFE & LEGAL!**

OpenOS/bNode provides professional-grade security tools for authorized testing and research. Always obtain proper authorization before testing any systems.

**Happy hacking (responsibly)!** 🔓

---

**OpenOS/bNode v2.0 - Cybersecurity Edition**

*Privacy-First Linux with 80+ Security Tools*

*For Authorized Security Testing Only*

*Designed by ℒ (OTTAHEN) • For Everyone*
