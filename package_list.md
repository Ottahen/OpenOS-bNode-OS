# OpenOS (bNode) - Installed Packages List

This document lists the key packages installed and configured by the OpenOS setup script.

## Core System Utilities & Dependencies

*   `curl`: Command-line tool for transferring data with URLs.
*   `wget`: Non-interactive network downloader.
*   `gnupg`: GNU Privacy Guard - a free implementation of OpenPGP.
*   `software-properties-common`: Manage the repositories that you install software from.
*   `apt-transport-https`: Allows apt to fetch packages over HTTPS.
*   `ca-certificates`: Common CA certificates.
*   `git`: Distributed version control system (used for cloning themes).
*   `sassc`: Sass compiler (dependency for WhiteSur theme).
*   `libglib2.0-dev-bin`: Development binaries for GLib (dependency for WhiteSur theme).
*   `imagemagick`: Image manipulation programs (optional, for GDM theme tweak).
*   `dialog`: Display dialog boxes from shell scripts (optional, for interactive theme install).
*   `optipng`: PNG optimizer (optional, for asset rendering).
*   `inkscape`: Vector graphics editor (optional, for asset rendering).

## Desktop Environment & UI Components

*   `gnome-tweaks`: Tool to customize GNOME desktop settings.
*   `gnome-shell-extension-manager`: Application to browse and install GNOME Shell extensions.
*   `gnome-shell-extension-dash-to-dock`: GNOME Shell extension that transforms the dash into a dock.
*   `gnome-shell-extension-blur-my-shell`: GNOME Shell extension that adds a blur effect to various parts of the shell.
*   `WhiteSur GTK Theme`: macOS-like theme for GTK desktops.
*   `WhiteSur Icon Theme`: macOS-like icon theme.

## Applications

*   `brave-browser`: The Brave web browser.
*   `onlyoffice-desktopeditors`: ONLYOFFICE Desktop Editors suite.
*   `code`: Visual Studio Code, a powerful code editor.

## Default File Manager and Terminal

Ubuntu LTS typically includes:

*   `nautilus` (GNOME Files): The default file manager for the GNOME desktop.
*   `gnome-terminal`: The default terminal emulator for the GNOME desktop.

These are part of the base Ubuntu installation and are not explicitly installed by the `openos-setup.sh` script unless they are missing from a minimal installation.
