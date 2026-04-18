#!/bin/zsh
# This Bash script installs the Xfce desktop on Arch Linux, by Andrei Pall
if [[ ! -b /dev/sdb1 || ! -b /dev/sdb2 ]]; then
    echo "Required partitions not found!"
    exit 1
fi
mkfs.fat -F32 /dev/sdb1
mkfs.ext4 /dev/sdb2
pacman -Syy
mount /dev/sdb2 /mnt
touch /mnt/etc/vconsole.conf
pacstrap -K /mnt base linux linux-firmware-intel linux-firmware-realtek sudo nano
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt
ln -sf /usr/share/zoneinfo/Europe/Bucharest /etc/localtime
hwclock --systohc
sed -i 's/^#\(en_US.UTF-8 UTF-8\)/\1/' /etc/locale.gen
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
export LANG=en_US.UTF-8
echo andrei-pc > /etc/hostname
passwd
pacman -S grub efibootmgr intel-ucode
mkdir /boot/efi
mount /dev/sdb1 /boot/efi
grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot/efi
grub-mkconfig -o /boot/grub/grub.cfg
cat > /etc/systemd/network/20-wired.network <<EOF
[Match]
Name=enp4s0

[Network]
DHCP=yes
EOF
systemctl enable systemd-networkd.service
systemctl enable systemd-resolved.service
pacman -S xorg-server xf86-video-intel
useradd -m -c "Andrei Pall" -G wheel andrei
passwd andrei
sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL) ALL/' /etc/sudoers
sed -i 's/^GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/' /etc/default/grub
sed -i 's/^GRUB_PRELOAD_MODULES="part_gpt part_msdos"/GRUB_PRELOAD_MODULES="part_gpt"/' /etc/default/grub
sed -i 's/^GRUB_TIMEOUT_STYLE=menu/GRUB_TIMEOUT_STYLE=hidden/' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg
pacman -S exo garcon thunar thunar-volman tumbler xfce4-appfinder xfce4-panel xfce4-session xfce4-settings xfce4-terminal xfconf xfdesktop xfwm4
pacman -S mousepad ristretto thunar-archive-plugin xfce4-pulseaudio-plugin xfce4-screenshoter xfce4-notifyd
pacman -S lightdm-gtk-greeter network-manager-applet noto-fonts parole gst-libav gst-plugins-bad gst-plugins-ugly firefox gvfs gvfs-mtp xarchiver unrar unzip pulseaudio pavucontrol transmission-gtk
systemctl enable lightdm.service
systemctl enable NetworkManager
sed -i 's/^#xserver-command=X/xserver-command=X -s 0 -dpms/' /etc/lightdm/lightdm.conf
sed -i 's/^#autologin-user=/autologin-user=andrei/' /etc/lightdm/lightdm.conf
sed -i 's/^#autologin-session=/autologin-session=xfce/' /etc/lightdm/lightdm.conf
groupadd -r autologin
gpasswd -a andrei autologin
pacman -S ufw
systemctl enable ufw.service
systemctl start ufw.service
systemctl status ufw
ufw default allow outgoing
ufw default deny incoming
ufw allow 51413/tcp
ufw enable
ufw status numbered
timedatectl set-ntp true
timedatectl status
exit
umount -R /mnt
reboot
