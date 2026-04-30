#!/usr/bin/env bash

set -e

URL="https://github.com/vinceliuice/Qogir-icon-theme/archive/refs/tags/2025-02-15.tar.gz"
DEST="$HOME/Qogir-icon-theme.tar.gz"

echo "Downloading icon theme..."
curl -L "$URL" -o "$DEST"

echo "Extracting icon theme..."
tar -xzf "$DEST" -C "$HOME"

echo "Installing icon theme..."
cd /root/Qogir-icon-theme-2025-02-15
./install.sh -t default -c standard
cd /root/
rm -R Qogir-*
echo "Icon theme installed."

URL="https://github.com/vinceliuice/Qogir-theme/archive/refs/tags/2025-08-17.tar.gz"
DEST="$HOME/Qogir-theme.tar.gz"

echo "Downloading theme..."
curl -L "$URL" -o "$DEST"

echo "Extracting theme..."
tar -xzf "$DEST" -C "$HOME"

echo "Installing theme..."
cd /root/Qogir-theme-2025-08-17
./install.sh -t default -c standard --tweaks image
cd /root/
rm -R Qogir-*
echo "Theme installed."

sed -i -e 's/Adwaita/Qogir/g' /usr/share/icons/default/index.theme
echo "Cursor theme updated."

sed -i 's/^\s*load-module module-suspend-on-idle/#&/' /etc/pulse/default.pa
echo "Pulseaudio config updated."

echo "Done."