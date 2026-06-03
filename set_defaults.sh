#!/bin/bash

# Set default applications and system tweaks

set -e

log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | sudo tee -a "/var/log/openos_setup.log"
}

log_message "Setting Brave as the default browser..."
xdg-settings set default-web-browser brave-browser.desktop || log_message "Warning: Could not set Brave as default browser via xdg-settings."
sudo update-alternatives --set x-www-browser /usr/bin/brave-browser || log_message "Warning: Could not set Brave as default x-www-browser."
sudo update-alternatives --set gnome-www-browser /usr/bin/brave-browser || log_message "Warning: Could not set Brave as default gnome-www-browser."

log_message "Disabling Ubuntu Apport (Crash reporting)..."
sudo sed -i 's/enabled=1/enabled=0/g' /etc/default/apport || log_message "Warning: Could not disable Apport."
sudo systemctl stop apport.service || true
sudo systemctl disable apport.service || true

log_message "Disabling Ubuntu Popularity Contest (Telemetry)..."
sudo apt-get remove -y popularity-contest || log_message "Warning: Could not remove popularity-contest."

log_message "System defaults and tweaks applied."
