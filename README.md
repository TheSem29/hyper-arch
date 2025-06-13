# Hyprland Setup Script for Arch Linux

This script automates the setup of Hyprland with a beautiful light coffee theme on Arch Linux. It configures all necessary components including window management, themes, wallpapers, and keyboard shortcuts.

## Prerequisites

- A minimal Arch Linux installation with:
  - Internet connection
  - Basic utilities (pacman, systemctl, sudo)
  - A user with sudo privileges

## Features

- Installs and configures Hyprland with a light coffee theme
- Sets up GTK themes and icons
- Configures Alacritty terminal with Catppuccin Latte theme
- Downloads and sets up beautiful wallpapers
- Configures keyboard shortcuts and window management
- Sets up additional utilities (wofi, cliphist, etc.)
- Installs and configures Firefox and rofi if not present

## Installation

1. Clone this repository or download the script:
   ```bash
   git clone https://github.com/yourusername/hyprland-setup.git
   cd hyprland-setup
   ```

2. Make the script executable:
   ```bash
   chmod +x setup-hyprland.sh
   ```

3. Run the script:
   ```bash
   ./setup-hyprland.sh
   ```

## What Gets Installed

### Core Components
- Hyprland (window manager)
- Hyprpaper (wallpaper manager)
- Hypridle (idle daemon)
- Hyprlock (screen locker)
- xdg-desktop-portal-hyprland

### Audio
- PipeWire
- WirePlumber
- pipewire-audio

### Network
- NetworkManager
- network-manager-applet

### File Management
- Thunar (file manager)

### Terminal
- Alacritty (terminal emulator)

### Additional Tools
- MPV (media player)
- Neovim (text editor)
- Git, curl, wget, unzip, tar
- Wofi (application launcher)
- cliphist (clipboard manager)
- wl-clipboard (Wayland clipboard utilities)

### Themes
- Catppuccin Latte GTK theme
- Papirus icon theme
- JetBrains Mono Nerd Font

## Configuration

The script creates the following configuration files:

- `~/.config/hypr/hyprland.conf` - Main Hyprland configuration
- `~/.config/hypr/theme.conf` - Theme-specific settings
- `~/.config/hypr/hyprpaper.conf` - Wallpaper configuration
- `~/.config/alacritty/alacritty.yml` - Terminal configuration
- `~/.config/gtk-3.0/settings.ini` - GTK3 theme settings
- `~/.config/gtk-4.0/settings.ini` - GTK4 theme settings

## Key Bindings

- `Super + Return` - Open terminal
- `Super + B` - Open browser
- `Super + D` - Open application launcher
- `Super + Q` - Close active window
- `Super + F` - Toggle fullscreen
- `Super + L` - Lock screen
- `Super + 1-5` - Switch workspaces
- `Super + Shift + 1-5` - Move window to workspace
- `Super + H/J/K/L` - Move focus
- `Super + Shift + H/J/K/L` - Move window

## Wallpapers

The script downloads 5 beautiful light coffee-themed wallpapers to `~/Pictures/Wallpapers/`. Hyprpaper is configured to use these wallpapers.

## Logging

The script logs all actions to `~/hyprland-setup.log` for troubleshooting purposes.

## Troubleshooting

If you encounter any issues:

1. Check the log file: `~/hyprland-setup.log`
2. Ensure all prerequisites are met
3. Verify your internet connection
4. Check if you have sufficient disk space
5. Make sure you have sudo privileges

## Contributing

Feel free to submit issues and enhancement requests! 