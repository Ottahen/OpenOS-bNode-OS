#!/bin/bash

# Install OnlyOffice Desktop Editors

set -e

log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | sudo tee -a "/var/log/openos_setup.log"
}

log_message "Adding OnlyOffice GPG key..."
mkdir -p -m 700 ~/.gnupg
gpg --no-default-keyring --keyring gnupg-ring:/tmp/onlyoffice.gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys CB2DE8E5 || exit 1
chmod 644 /tmp/onlyoffice.gpg
sudo chown root:root /tmp/onlyoffice.gpg
sudo mv /tmp/onlyoffice.gpg /usr/share/keyrings/onlyoffice.gpg || exit 1

log_message "Adding OnlyOffice repository..."
echo 'deb [signed-by=/usr/share/keyrings/onlyoffice.gpg] https://download.onlyoffice.com/repo/debian squeeze main' | sudo tee /etc/apt/sources.list.d/onlyoffice.list || exit 1

log_message "Updating apt cache..."
sudo apt update -y || exit 1

log_message "Installing onlyoffice-desktopeditors..."
sudo apt install onlyoffice-desktopeditors -y || exit 1

log_message "OnlyOffice Desktop Editors installation complete."
