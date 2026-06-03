#!/bin/bash

# Apply GNOME Settings for OpenOS
# This script should be run by the user after logging into the GNOME session.

echo "Applying OpenOS GNOME settings..."

# Enable extensions
gnome-extensions enable ubuntu-dock@ubuntu.com || true
gnome-extensions enable dash-to-dock@micxgx.gmail.com || true
gnome-extensions enable blur-my-shell@aunetx || true
gnome-extensions enable user-theme@gnome-shell-extensions.gcampax.github.com || true

# Set Themes
gsettings set org.gnome.desktop.interface gtk-theme 'WhiteSur-Dark-purple'
gsettings set org.gnome.desktop.interface icon-theme 'WhiteSur-purple-dark'
gsettings set org.gnome.desktop.interface cursor-theme 'WhiteSur-cursors'
gsettings set org.gnome.shell.extensions.user-theme name 'WhiteSur-Dark-purple'

# Configure Dash to Dock (Apple-like)
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'BOTTOM'
gsettings set org.gnome.shell.extensions.dash-to-dock extend-height false
gsettings set org.gnome.shell.extensions.dash-to-dock transparency-mode 'FIXED'
gsettings set org.gnome.shell.extensions.dash-to-dock background-opacity 0.4
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 48
gsettings set org.gnome.shell.extensions.dash-to-dock show-apps-at-top false
gsettings set org.gnome.shell.extensions.dash-to-dock custom-theme-shrink true

# Configure Blur my Shell
gsettings set org.gnome.shell.extensions.blur-my-shell.panel blur true
gsettings set org.gnome.shell.extensions.blur-my-shell.dash-to-dock blur true
gsettings set org.gnome.shell.extensions.blur-my-shell.overview blur true

# Window Settings (Rounded corners, buttons on left)
gsettings set org.gnome.desktop.wm.preferences button-layout 'close,minimize,maximize:'

# Workspace Settings
gsettings set org.gnome.mutter dynamic-workspaces true

# Set Wallpaper (Assuming wallpaper is placed in /usr/share/backgrounds/openos-wallpaper.png)
if [ -f "/usr/share/backgrounds/openos-wallpaper.png" ]; then
    gsettings set org.gnome.desktop.background picture-uri 'file:///usr/share/backgrounds/openos-wallpaper.png'
    gsettings set org.gnome.desktop.background picture-uri-dark 'file:///usr/share/backgrounds/openos-wallpaper.png'
fi

echo "GNOME settings applied successfully!"
