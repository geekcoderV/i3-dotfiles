#!/bin/bash
# ----------------------------------------------------------------------
# i3 Wallpaper Changer Script (Requires 'feh')
# ----------------------------------------------------------------------
# This script randomly selects an image from a specified directory
# and sets it as the desktop wallpaper using 'feh --bg-fill'.
#
# USAGE:
# 1. Make the script executable: chmod +x /path/to/change_wallpaper.sh
# 2. Update the WALLPAPER_DIR variable below to your image location.
# 3. Add a keybinding to your ~/.config/i3/config (Example provided below).
# ----------------------------------------------------------------------

# --- CONFIGURATION ---

# 1. Set the directory where your wallpapers are located.
#    Use an absolute path or path relative to the user's home directory.
WALLPAPER_DIR="$HOME/Pictures/wallpapers"

# 2. Define the feh options.
#    --bg-fill: scales the image to fill the screen without preserving aspect ratio.
#    --bg-scale: scales the image to fit, preserving aspect ratio (may leave borders).
FEH_OPTIONS="--bg-fill"

# --- EXECUTION ---

# Check if the wallpaper directory exists
if [ ! -d "$WALLPAPER_DIR" ]; then
    echo "Error: Wallpaper directory not found at $WALLPAPER_DIR" >&2
    exit 1
fi

# Find all files recursively in the directory that end with common image extensions,
# shuffle them randomly, and select only the first one (-n 1).
SELECTED_WALLPAPER=$(
    find "$WALLPAPER_DIR" -type f \
    \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" -o -iname "*.webp" \) \
    | shuf -n 1
)

# Check if an image was successfully selected
if [ -z "$SELECTED_WALLPAPER" ]; then
    echo "Error: No valid image files found in $WALLPAPER_DIR" >&2
    exit 1
fi

# Apply the selected wallpaper using feh
feh $FEH_OPTIONS "$SELECTED_WALLPAPER"

echo "Wallpaper successfully set to: $SELECTED_WALLPAPER"
# ----------------------------------------------------------------------
