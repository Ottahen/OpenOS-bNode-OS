#!/bin/bash

# Install Brave Browser

set -e

log_message() {
    echo "$(date 
'+%Y-%m-%d %H:%M:%S
') - $1" | sudo tee -a "/var/log/openos_setup.log"
}

log_message "Adding Brave Browser GPG key..."
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg || exit 1

log_message "Adding Brave Browser repository..."
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list || exit 1

log_message "Updating apt cache..."
sudo apt update -y || exit 1

log_message "Installing brave-browser..."
sudo apt install brave-browser -y || exit 1

log_message "Brave Browser installation complete."
