#!/bin/bash

# Hyprland Setup Script for Arch Linux
# This script configures Hyprland with a light coffee theme
# Author: Claude
# Date: 2024

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Log file
LOG_DIR="$HOME/.local/log"
LOG_FILE="$LOG_DIR/hyprland-setup.log"

# Create log directory if it doesn't exist
mkdir -p "$LOG_DIR"

# Logging function
log() {
    local message="$1"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    if ! echo -e "${GREEN}[$timestamp]${NC} $message" | tee -a "$LOG_FILE" 2>/dev/null; then
        echo -e "${RED}Warning: Could not write to log file. Continuing without logging.${NC}" >&2
        echo -e "${GREEN}[$timestamp]${NC} $message"
    fi
}

# Error handling
set -e
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'echo -e "${RED}Error: Command \"$last_command\" failed with exit code $?.${NC}"' EXIT

# Function to check if a command exists
command_exists() {
    command -v "$1" &>/dev/null
}

# Function to install package if not present
install_package() {
    local package="$1"
    if ! command_exists "$package"; then
        log "Installing $package..."
        sudo pacman -S --noconfirm "$package"
    else
        log "$package is already installed"
    fi
}

# Function to configure GTK themes
configure_gtk_theme() {
    log "Configuring GTK themes..."
    
    # GTK 3 settings
    cat > "$HOME/.config/gtk-3.0/settings.ini" << EOF
[Settings]
gtk-theme-name=Catppuccin-Latte
gtk-icon-theme-name=Papirus
gtk-font-name=Sans 10
gtk-cursor-theme-name=Adwaita
gtk-toolbar-style=GTK_TOOLBAR_BOTH
gtk-toolbar-icon-size=GTK_ICON_SIZE_LARGE_TOOLBAR
gtk-button-images=1
gtk-menu-images=1
gtk-enable-animations=1
EOF

    # GTK 4 settings
    cat > "$HOME/.config/gtk-4.0/settings.ini" << EOF
[Settings]
gtk-theme-name=Catppuccin-Latte
gtk-icon-theme-name=Papirus
gtk-font-name=Sans 10
gtk-cursor-theme-name=Adwaita
gtk-toolbar-style=GTK_TOOLBAR_BOTH
gtk-toolbar-icon-size=GTK_ICON_SIZE_LARGE_TOOLBAR
gtk-button-images=1
gtk-menu-images=1
gtk-enable-animations=1
EOF
}

# Function to configure Alacritty
configure_alacritty() {
    log "Configuring Alacritty..."
    
    cat > "$HOME/.config/alacritty/alacritty.yml" << EOF
import:
  - ~/.config/alacritty/catppuccin-latte.yml

window:
  padding:
    x: 10
    y: 10
  opacity: 0.9
  decorations: full
  title: Alacritty

font:
  normal:
    family: JetBrainsMono Nerd Font
    style: Regular
  bold:
    family: JetBrainsMono Nerd Font
    style: Bold
  size: 12.0

cursor:
  style: Block
  blinking: true

scrolling:
  history: 10000
  multiplier: 3

selection:
  semantic_escape_chars: ",│`|:\"' ()[]{}<>\t"

colors:
  primary:
    background: '#EFF1F5'
    foreground: '#4C4F69'
EOF

    # Download Catppuccin Latte theme for Alacritty
    curl -L -o "$HOME/.config/alacritty/catppuccin-latte.yml" \
        "https://raw.githubusercontent.com/catppuccin/alacritty/main/catppuccin-latte.yml"
}

# Function to download wallpapers
download_wallpapers() {
    log "Downloading wallpapers..."
    
    # Array of wallpaper URLs (light coffee theme)
    local wallpapers=(
        "https://w.wallhaven.cc/full/7p/wallhaven-7p39gy.png"
        "https://w.wallhaven.cc/full/9d/wallhaven-9d8kxk.jpg"
        "https://w.wallhaven.cc/full/2e/wallhaven-2e5qy7.jpg"
        "https://w.wallhaven.cc/full/1p/wallhaven-1p39w1.jpg"
        "https://w.wallhaven.cc/full/85/wallhaven-85k9m7.jpg"
    )

    for url in "${wallpapers[@]}"; do
        local filename=$(basename "$url")
        log "Downloading $filename..."
        curl -L -o "$HOME/Pictures/Wallpapers/$filename" "$url"
    done
}

# Function to configure Hyprland
configure_hyprland() {
    log "Configuring Hyprland..."
    
    cat > "$HOME/.config/hypr/hyprland.conf" << EOF
# Monitor configuration
monitor=,preferred,auto,1

# Execute your favorite apps at launch
exec-once = hyprpaper
exec-once = nm-applet
exec-once = waybar
exec-once = dunst

# Source a file (multi-file configs)
source = ~/.config/hypr/theme.conf

# Set programs that you use
\$terminal = alacritty
\$menu = rofi -show drun
\$browser = firefox

# Some default env vars
env = XCURSOR_SIZE,24
env = QT_QPA_PLATFORMTHEME,qt5ct

# For all categories, see https://wiki.hyprland.org/Configuring/Variables/
input {
    kb_layout = us
    kb_variant =
    kb_model =
    kb_options =
    kb_rules =

    follow_mouse = 1
    touchpad {
        natural_scroll = yes
    }
    sensitivity = 0
}

general {
    gaps_in = 5
    gaps_out = 10
    border_size = 2
    col.active_border = rgba(220,138,120ff)
    col.inactive_border = rgba(220,138,12033)
    layout = dwindle
}

decoration {
    rounding = 10
    blur {
        enabled = true
        size = 3
        passes = 1
    }
    drop_shadow = yes
    shadow_range = 4
    shadow_render_power = 3
    col.shadow = rgba(1a1a1aee)
}

animations {
    enabled = yes
    bezier = myBezier, 0.05, 0.9, 0.1, 1.05
    animation = windows,    1, 7,  myBezier
    animation = windowsOut, 1, 7,  default, popin 80%
    animation = border,     1, 10, default
    animation = fade,       1, 7,  default
    animation = workspaces, 1, 6,  default
}

dwindle {
    pseudotile = yes
    preserve_split = yes
}

master {
    new_is_master = true
}

gestures {
    workspace_swipe = off
}

# Example windowrule v1
windowrule = float, ^(kitty)$
windowrule = float, ^(thunar)$

# Example windowrule v2
windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
windowrulev2 = float,class:^(thunar)$,title:^(thunar)$

# Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
bind = SUPER, Return, exec, \$terminal
bind = SUPER, B, exec, \$browser
bind = SUPER, D, exec, \$menu
bind = SUPER, Q, killactive
bind = SUPER, F, fullscreen, 1
bind = SUPER, L, exec, hyprlock
bind = SUPER, 1, workspace, 1
bind = SUPER, 2, workspace, 2
bind = SUPER, 3, workspace, 3
bind = SUPER, 4, workspace, 4
bind = SUPER, 5, workspace, 5
bind = SUPER SHIFT, 1, movetoworkspace, 1
bind = SUPER SHIFT, 2, movetoworkspace, 2
bind = SUPER SHIFT, 3, movetoworkspace, 3
bind = SUPER SHIFT, 4, movetoworkspace, 4
bind = SUPER SHIFT, 5, movetoworkspace, 5
bind = SUPER, mouse_down, workspace, e+1
bind = SUPER, mouse_up, workspace, e-1
bind = SUPER, h, movefocus, l
bind = SUPER, l, movefocus, r
bind = SUPER, k, movefocus, u
bind = SUPER, j, movefocus, d
bind = SUPER SHIFT, h, movewindow, l
bind = SUPER SHIFT, l, movewindow, r
bind = SUPER SHIFT, k, movewindow, u
bind = SUPER SHIFT, j, movewindow, d
bind = SUPER, period, exec, wofi-emoji
bind = SUPER, comma, exec, wofi-calc
bind = SUPER, slash, exec, wofi-search
bind = SUPER, escape, exec, wlogout
bind = SUPER, p, exec, wofi-power
bind = SUPER, v, exec, cliphist list | wofi -dmenu | cliphist decode | wl-copy
bind = SUPER, c, exec, cliphist wipe
bind = SUPER, r, exec, wofi -show drun
bind = SUPER, t, exec, \$terminal
bind = SUPER, b, exec, \$browser
bind = SUPER, f, exec, thunar
bind = SUPER, m, exec, wofi-mount
bind = SUPER, u, exec, wofi-umount
bind = SUPER, e, exec, wofi-emoji
bind = SUPER, w, exec, wofi-calc
bind = SUPER, s, exec, wofi-search
bind = SUPER, x, exec, wlogout
bind = SUPER, p, exec, wofi-power
bind = SUPER, v, exec, cliphist list | wofi -dmenu | cliphist decode | wl-copy
bind = SUPER, c, exec, cliphist wipe
bind = SUPER, r, exec, wofi -show drun
bind = SUPER, t, exec, \$terminal
bind = SUPER, b, exec, \$browser
bind = SUPER, f, exec, thunar
bind = SUPER, m, exec, wofi-mount
bind = SUPER, u, exec, wofi-umount
EOF

    # Create theme configuration
    cat > "$HOME/.config/hypr/theme.conf" << EOF
# Theme configuration
\$accent = rgba(220,138,120ff)
\$accentAlpha = rgba(220,138,12033)
\$font = JetBrainsMono Nerd Font

# General
general {
    gaps_in = 5
    gaps_out = 10
    border_size = 2
    col.active_border = \$accent
    col.inactive_border = \$accentAlpha
    layout = dwindle
}

# Decoration
decoration {
    rounding = 10
    blur {
        enabled = true
        size = 3
        passes = 1
    }
    drop_shadow = yes
    shadow_range = 4
    shadow_render_power = 3
    col.shadow = rgba(1a1a1aee)
}

# Animations
animations {
    enabled = yes
    bezier = myBezier, 0.05, 0.9, 0.1, 1.05
    animation = windows,    1, 7,  myBezier
    animation = windowsOut, 1, 7,  default, popin 80%
    animation = border,     1, 10, default
    animation = fade,       1, 7,  default
    animation = workspaces, 1, 6,  default
}
EOF
}

# Function to configure Hyprpaper
configure_hyprpaper() {
    log "Configuring Hyprpaper..."
    
    cat > "$HOME/.config/hypr/hyprpaper.conf" << EOF
preload = ~/Pictures/Wallpapers/wallhaven-7p39gy.png
preload = ~/Pictures/Wallpapers/wallhaven-9d8kxk.jpg
preload = ~/Pictures/Wallpapers/wallhaven-2e5qy7.jpg
preload = ~/Pictures/Wallpapers/wallhaven-1p39w1.jpg
preload = ~/Pictures/Wallpapers/wallhaven-85k9m7.jpg

wallpaper = ,~/Pictures/Wallpapers/wallhaven-7p39gy.png
EOF
}

# Update main setup function
setup_hyprland() {
    log "Starting Hyprland setup..."

    # Create necessary directories
    mkdir -p "$HOME/.config/hypr"
    mkdir -p "$HOME/.config/gtk-3.0"
    mkdir -p "$HOME/.config/gtk-4.0"
    mkdir -p "$HOME/.config/alacritty"
    mkdir -p "$HOME/Pictures/Wallpapers"

    # Install required packages
    log "Installing required packages..."
    local packages=(
        "firefox"
        "rofi"
        "hyprland"
        "hyprpaper"
        "hypridle"
        "hyprlock"
        "xdg-desktop-portal-hyprland"
        "pipewire"
        "wireplumber"
        "pipewire-audio"
        "networkmanager"
        "network-manager-applet"
        "thunar"
        "alacritty"
        "mpv"
        "neovim"
        "git"
        "curl"
        "wget"
        "unzip"
        "tar"
        "catppuccin-gtk-theme-latte"
        "papirus-icon-theme"
        "jetbrains-mono-nerd-font"
        "wofi"
        "cliphist"
        "wl-clipboard"
    )

    for package in "${packages[@]}"; do
        install_package "$package"
    done

    # Configure components
    configure_gtk_theme
    configure_alacritty
    download_wallpapers
    configure_hyprland
    configure_hyprpaper

    log "Setup completed successfully!"
}

# Start the setup
log "Starting Hyprland setup script..."
setup_hyprland
log "Setup completed successfully!" 
