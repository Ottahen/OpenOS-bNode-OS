# OpenOS (bNode) Design Plan

## 1. Modular Architecture
- **openos-setup.sh**: Main entry point. Orchestrates the installation.
- **scripts/install_apps.sh**: Handles Brave, OnlyOffice, VS Code.
- **scripts/configure_ui.sh**: Installs themes (WhiteSur), icons, and GNOME extensions.
- **scripts/system_tweaks.sh**: Optimizes workspaces, privacy, and performance.
- **themes/**: Contains GTK themes, Icon packs, and Wallpapers.
- **ui/**: GNOME extension configs (Dash to Dock, Blur my Shell).

## 2. Core Components
- **Base**: Ubuntu LTS (GNOME).
- **Theme**: WhiteSur GTK Theme (Dark/Purple variant).
- **Icons**: WhiteSur Icon Theme.
- **Dock**: Dash to Dock (configured to look like macOS).
- **Effects**: Blur my Shell for glassmorphism.
- **Apps**: Brave (Default Browser), OnlyOffice (Default Office), VS Code.

## 3. UI/UX Targets
- Rounded corners for windows.
- Transparent/Blurry top bar and dock.
- Workspace-friendly defaults (Dynamic workspaces).
- Custom OpenOS wallpaper matching the dark blue/purple aesthetic.
