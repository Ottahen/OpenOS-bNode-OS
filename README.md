# OpenOS (bNode) - A Polished Linux Desktop Experience

## Overview

OpenOS (bNode) is a project dedicated to transforming a standard Ubuntu LTS installation into a stable, polished, and user-friendly Linux desktop operating system. Inspired by the aesthetics and workflow of macOS, OpenOS aims to provide a modern, Apple-like user experience while prioritizing stability, performance, and privacy. This project is not a new operating system from scratch but rather a comprehensive configuration and installer for an existing Linux base.

## Features

*   **Base System**: Built on Ubuntu LTS for maximum stability and compatibility.
*   **Apple-like UI**: Features a clean, modern desktop environment with a dock, smooth transitions, rounded corners, and a contemporary launcher, supporting both light and dark themes.
*   **Core Applications**: Automatic installation of essential applications including Brave Browser (default), OnlyOffice Desktop Editors, a file manager, and a terminal. Visual Studio Code is included as a recommended optional install.
*   **Productivity Enhancements**: Configured with workspace/virtual desktop support for efficient multitasking, natural file opening, and seamless application switching.
*   **Security & Privacy**: Minimized telemetry and tracking, no unnecessary background services, and secure defaults for network and privacy settings.
*   **Modular Installer**: An `openos-setup.sh` script automates the entire setup process, ensuring consistency and ease of deployment.

## Installation Guide

To install OpenOS, follow these steps. It is recommended to start with a fresh installation of Ubuntu LTS (e.g., Ubuntu 22.04 LTS or later).

1.  **Download the Project**: Clone the OpenOS repository to your local machine:

    ```bash
    git clone https://github.com/your-repo/openos.git # Replace with actual repo URL
    cd openos
    ```

2.  **Run the Installer**: Execute the main setup script. This script will update your system, install necessary dependencies, applications, and configure the desktop environment.

    ```bash
    chmod +x openos-setup.sh
    sudo ./openos-setup.sh
    ```

    The installation process will log its progress to `/var/log/openos_setup.log`.

3.  **Apply GNOME Settings**: After the main installation script completes, **reboot your system**. Once you log back into your GNOME session, run the `apply_gnome_settings.sh` script to finalize the UI configurations.

    ```bash
    chmod +x ui/apply_gnome_settings.sh
    ./ui/apply_gnome_settings.sh
    ```

    *Note: This step needs to be run from within a graphical session to apply GNOME-specific settings correctly.*

4.  **Enjoy OpenOS!**: Your system should now be configured with the OpenOS desktop experience.

## Project Structure

The project is organized into a modular structure for clarity and maintainability:

```
/openos/
├── core/               # Core system configurations (e.g., privacy tweaks)
├── ui/                 # UI-specific configurations (e.g., GNOME extension settings)
├── scripts/            # Modular installation scripts
│   ├── install_brave.sh
│   ├── install_onlyoffice.sh
│   ├── install_vscode.sh
│   ├── configure_desktop.sh
│   └── set_defaults.sh
├── themes/             # GTK themes, icon themes, wallpapers
├── apps/               # (Potentially) custom application packages or configurations
└── docs/               # Documentation (README, design plan, package list, roadmap)
    ├── README.md
    ├── design_plan.md
    ├── package_list.md
    └── roadmap.md
```

## Contributing

We welcome contributions! Please refer to `CONTRIBUTING.md` (to be created) for guidelines on how to contribute to OpenOS.

## License

This project is licensed under the MIT License - see the `LICENSE` file (to be created) for details.
