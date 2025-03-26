#!/bin/bash
# This Bash script hides the desktop menu entries for the current user, by Andrei Pall

entry_names=("avahi-discover.desktop" "bssh.desktop" "bvnc.desktop" "gcr-prompter.desktop" "gcr-viewer.desktop" "mpv.desktop" "qv4l2.desktop" "qvidcap.desktop" "xfce4-mail-reader.desktop" "debian-uxterm.desktop" "debian-xterm.desktop" "display-im6.q16.desktop")
path="/usr/share/applications/"
home_path="$HOME/.local/share/applications/"

# Check if the home directory exists and create it if it doesn't
if [ ! -d "$home_path" ]; then
    mkdir -p "$home_path"
fi

counter=0
for entry_name in "${entry_names[@]}"
do
    entry_path="$path$entry_name"
    entry_home_path="$home_path$entry_name"
    # Check if the entry exists
    if [ -f "$entry_path" ]; then
        if [ ! -f "$entry_home_path" ]; then
            cp "$entry_path" "$entry_home_path"
            # Check if the entry is hidden
            if ! grep -q "NoDisplay=true" "$entry_home_path"; then
                echo "NoDisplay=true" >> "$entry_home_path"
                echo "The file $entry_home_path is hidden."
                (( counter++ ))
            fi
        fi
    fi
done
if [ $counter -eq 0 ]; then
   echo "No desktop menu entries found.";
fi

# Disable "recent files" options for privacy reason on XFCE
mkdir -p ~/.config/gtk-3.0/
cat <<EOF >> ~/.config/gtk-3.0/settings.ini
[Settings]
gtk-recent-files-max-age=0
gtk-recent-files-limit=0
EOF
if [ -f ~/.local/share/recently-used.xbel ]; then
	rm ~/.local/share/recently-used.xbel
fi
