#!/bin/bash
# This Bash script installs the Xfce desktop on Debian, by Andrei Pall
set -e

if [ $UID -ne 0 ]; then
    echo "ERROR: Run as root user..."
    exit 1
fi

tee /etc/polkit-1/rules.d/49-udisks2-mount.rules > /dev/null <<'INNER'
polkit.addRule(function(action, subject) {
    if (
        (action.id.indexOf("org.freedesktop.udisks2.") == 0) &&
        subject.isInGroup("sudo")
    ) {
        return polkit.Result.YES;
    }
});
INNER

cat <<'EOF' > /etc/apt/apt.conf.d/99norecommends
APT::Install-Recommends "false";
APT::Install-Suggests "false";
EOF

apt-get install xserver-xorg-video-intel xserver-xorg-input-all xserver-xorg-core polkitd systemd-timesyncd --no-install-recommends
apt-get install xfce4 exfatprogs eject sassc firefox-esr mousepad ristretto thunar-archive-plugin xfce4-notifyd xfce4-screenshooter xfce4-terminal gvfs-backends fonts-noto xarchiver 7zip unzip transmission-gtk parole network-manager-applet gstreamer1.0-libav gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gnome-icon-theme tumbler ca-certificates pulseaudio pavucontrol lightdm lightdm-gtk-greeter ufw  --no-install-recommends
apt remove os-prober
systemctl enable dbus
systemctl enable lightdm
systemctl enable NetworkManager
systemctl set-default graphical.target
ufw enable
ufw default deny incoming
ufw default allow outgoing
ufw allow 51413/tcp
ufw status verbose
timedatectl set-ntp true
timedatectl status
sed -i -e 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/g' /etc/default/grub
sed -i '/^GRUB_CMDLINE_LINUX=""/a GRUB_TIMEOUT_STYLE=hidden' /etc/default/grub
update-grub
sed -i -e 's/managed=false/managed=true/g' /etc/NetworkManager/NetworkManager.conf
sed -i -e 's/#xserver-command=X/xserver-command=X -s 0 -dpms/g' /etc/lightdm/lightdm.conf
sed -i -e 's/#autologin-user=/autologin-user=andrei/g' /etc/lightdm/lightdm.conf
sed -i -e 's/#autologin-session=/autologin-session=xfce/g' /etc/lightdm/lightdm.conf
sed -i -E '/^(deb|deb-src)/ {
  / non-free(\s|$)/! s/$/ non-free/
}' /etc/apt/sources.list
grep -E '^(deb|deb-src)' /etc/apt/sources.list
apt update
apt install unrar
sed -i -e 's/#SystemMaxUse=/SystemMaxUse=100M/g' /etc/systemd/journald.conf
sed -i -e 's/#MaxRetentionSec=0/MaxRetentionSec=1week/g' /etc/systemd/journald.conf
echo "The Xfce desktop has been installed successfully."
