#!/bin/bash

# Configure Desktop Environment (UI, themes, extensions)

set -e

log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | sudo tee -a "/var/log/openos_setup.log"
}

log_message "Installing GNOME Tweaks and Extension Manager..."
sudo apt install -y gnome-tweaks gnome-shell-extension-manager git sassc libglib2.0-dev-bin imagemagick dialog optipng inkscape || exit 1

# Install WhiteSur GTK Theme
log_message "Cloning WhiteSur GTK Theme..."
cd /tmp
git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git --depth=1
cd WhiteSur-gtk-theme
log_message "Installing WhiteSur GTK Theme (Dark Purple variant)..."
./install.sh -t purple -c dark -o normal -a alt -N glassy || exit 1

log_message "Copying OpenOS wallpaper..."
sudo cp /home/ubuntu/openos/themes/openos-wallpaper.png /usr/share/backgrounds/openos-wallpaper.png || exit 1

# Install WhiteSur Icon Theme
log_message "Cloning WhiteSur Icon Theme..."
cd /tmp
git clone https://github.com/vinceliuice/WhiteSur-icon-theme.git --depth=1
cd WhiteSur-icon-theme
log_message "Installing WhiteSur Icon Theme..."
./install.sh -t purple || exit 1

# Install GNOME Extensions (Dash to Dock, Blur my Shell)
log_message "Installing GNOME Extensions via apt..."
sudo apt install -y gnome-shell-extension-dash-to-dock gnome-shell-extension-blur-my-shell || exit 1

# Note: Enabling extensions and setting themes via gsettings usually requires a running D-Bus session for the user.
# We will create a separate script that the user runs after reboot or login to apply these settings.
log_message "Desktop configuration packages installed."
