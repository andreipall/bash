#!/bin/bash
# This Bash script installs the Xfce desktop on Debian, by Andrei Pall

if [ $UID -ne 0 ]; then
    echo "ERROR: Run as root user..."
    exit 1
fi

apt-get install xfce4 firefox-esr mousepad ristretto thunar-archive-plugin xfce4-notifyd xfce4-screenshooter xfce4-terminal xfce4-taskmanager fonts-liberation yaru-theme-gtk yaru-theme-icon transmission-gtk
apt-get install gvfs-backends celluloid xfce4-power-manager --no-install-recommends
echo "The Xfce desktop has been installed successfully."