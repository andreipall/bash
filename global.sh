#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "Please run this script with sudo"
  exit 1
fi

# Detect the original user (who invoked sudo)
ORIGINAL_USER="${SUDO_USER:-$(whoami)}"

echo "Running as root: $(whoami)"

# Run a script as root
echo "Running root scripts..."
./themes.sh

# Running scripts as the original user
echo "Running user script as $ORIGINAL_USER..."
sudo -u "$ORIGINAL_USER" ./hide_xfce_menu_icons.sh
sudo -E -u "$ORIGINAL_USER" ./xfce_customization.sh