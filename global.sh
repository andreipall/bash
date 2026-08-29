#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "Please run this script with sudo"
  exit 1
fi

# Detect the original user (who invoked sudo)
ORIGINAL_USER="${SUDO_USER:-$(whoami)}"
USER_UID=$(id -u "$ORIGINAL_USER")

echo "Running as root: $(whoami)"

# Run a script as root
echo "Running root scripts..."
./themes.sh

# Running scripts as the original user
echo "Running user script as $ORIGINAL_USER..."
sudo -u "$ORIGINAL_USER" ./hide_xfce_menu_icons.sh
# sudo -E -u "$ORIGINAL_USER" ./xfce_customization.sh
sudo -u "$ORIGINAL_USER" DISPLAY="$DISPLAY" XDG_RUNTIME_DIR="/run/user/$USER_UID" DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$USER_UID/bus" XAUTHORITY="/home/$ORIGINAL_USER/.Xauthority" ./xfce_customization.sh