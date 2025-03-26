#!/bin/bash
# This Bash script installs and changes the cursor theme, by Andrei Pall

if [ $UID -ne 0 ]; then
    echo "ERROR: Run as root user..."
    exit 1
fi

pacman -S vimix-cursors papirus-icon-theme materia-gtk-theme
sed -i -e 's/Adwaita/Vimix-cursors/g' /usr/share/icons/default/index.theme
