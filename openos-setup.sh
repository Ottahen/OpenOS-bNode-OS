#!/bin/bash

# OpenOS (bNode) Installer Script
# This script orchestrates the installation and configuration of OpenOS.

set -e # Exit immediately if a command exits with a non-zero status.

LOG_FILE="/var/log/openos_setup.log"

# Function to log messages
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | sudo tee -a "$LOG_FILE"
}

# Function to handle errors
error_exit() {
    log_message "ERROR: $1"
    exit 1
}

log_message "OpenOS (bNode) installation started."

# Update system
log_message "Updating system packages..."
sudo apt update -y || error_exit "Failed to update package lists."
sudo apt upgrade -y || error_exit "Failed to upgrade system packages."
log_message "System packages updated."

# Install common dependencies
log_message "Installing common dependencies..."
sudo apt install -y curl wget gnupg software-properties-common apt-transport-https ca-certificates || error_exit "Failed to install common dependencies."
log_message "Common dependencies installed."

# Execute modular scripts
log_message "Executing modular scripts..."

# Install Brave Browser
log_message "Installing Brave Browser..."
/home/ubuntu/openos/scripts/install_brave.sh || error_exit "Brave Browser installation failed."
log_message "Brave Browser installed."

# Install OnlyOffice Desktop Editors
log_message "Installing OnlyOffice Desktop Editors..."
/home/ubuntu/openos/scripts/install_onlyoffice.sh || error_exit "OnlyOffice installation failed."
log_message "OnlyOffice Desktop Editors installed."

# Install VS Code (optional, but recommended)
log_message "Installing VS Code..."
/home/ubuntu/openos/scripts/install_vscode.sh || error_exit "VS Code installation failed."
log_message "VS Code installed."

# Configure Desktop Environment (UI, themes, extensions)
log_message "Configuring desktop environment..."
/home/ubuntu/openos/scripts/configure_desktop.sh || error_exit "Desktop configuration failed."
log_message "Desktop environment configured."

# Set default applications and system tweaks
log_message "Applying system defaults and tweaks..."
/home/ubuntu/openos/scripts/set_defaults.sh || error_exit "System defaults and tweaks failed."
log_message "System defaults and tweaks applied."

log_message "OpenOS (bNode) installation completed successfully!"
log_message "Please reboot your system for all changes to take effect."
