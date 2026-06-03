#!/bin/bash

# Install Visual Studio Code

set -e

log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | sudo tee -a "/var/log/openos_setup.log"
}

log_message "Adding Microsoft GPG key..."
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg || exit 1
rm -f packages.microsoft.gpg

log_message "Adding VS Code repository..."
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null || exit 1

log_message "Updating apt cache..."
sudo apt update -y || exit 1

log_message "Installing code..."
sudo apt install code -y || exit 1

log_message "VS Code installation complete."
