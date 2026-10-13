#!/bin/zsh
# This Zsh script installs the Xfce desktop on Arch Linux, by Andrei Pall
set -e

# Ask for password without displaying it
read -rs "PASSWORD?Enter password: "
echo

# Confirm password
read -rs "PASSWORD_CONFIRM?Confirm password: "
echo

if [[ -z "$PASSWORD" || "$PASSWORD" != "$PASSWORD_CONFIRM" ]]; then
    echo "Passwords do not match or are empty!"
    exit 1
fi

unset PASSWORD_CONFIRM

if [[ ! -b /dev/sdb1 || ! -b /dev/sdb2 ]]; then
    echo "Required partitions not found!"
    exit 1
fi

mkfs.fat -F32 /dev/sdb1
mkfs.ext4 /dev/sdb2
pacman -Syy
mount /dev/sdb2 /mnt
pacstrap -K /mnt base
touch /mnt/etc/vconsole.conf
pacstrap -K /mnt linux linux-firmware-intel linux-firmware-realtek sudo nano
genfstab -U /mnt >> /mnt/etc/fstab
mkdir -p /mnt/boot/efi
mount /dev/sdb1 /mnt/boot/efi

arch-chroot /mnt /bin/bash 3<<< "$PASSWORD" <<'CHROOT'
set -e

# Read password from file descriptor 3
IFS= read -r PASSWORD <&3
exec 3<&-

ln -sf /usr/share/zoneinfo/Europe/Bucharest /etc/localtime
hwclock --systohc
sed -i 's/^#\(en_US.UTF-8 UTF-8\)/\1/' /etc/locale.gen
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
export LANG=en_US.UTF-8
echo andrei-pc > /etc/hostname

# Set root password
printf 'root:%s\n' "$PASSWORD" | chpasswd

pacman -S --noconfirm grub efibootmgr intel-ucode
grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot/efi
grub-mkconfig -o /boot/grub/grub.cfg
pacman -S --noconfirm xorg-server xf86-video-intel
useradd -m -c "Andrei Pall" -G wheel andrei

# Set andrei password
printf 'andrei:%s\n' "$PASSWORD" | chpasswd

# Clear password variable inside chroot
unset PASSWORD

sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL) ALL/' /etc/sudoers
sed -i 's/^GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/' /etc/default/grub
sed -i 's/^GRUB_PRELOAD_MODULES="part_gpt part_msdos"/GRUB_PRELOAD_MODULES="part_gpt"/' /etc/default/grub
sed -i 's/^GRUB_TIMEOUT_STYLE=menu/GRUB_TIMEOUT_STYLE=hidden/' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

pacman -S --noconfirm pipewire-pulse exo garcon thunar thunar-volman tumbler xfce4-appfinder xfce4-panel xfce4-session xfce4-settings xfce4-terminal xfconf xfdesktop xfwm4 sassc mousepad ristretto thunar-archive-plugin xfce4-pulseaudio-plugin xfce4-screenshooter xfce4-notifyd lightdm-gtk-greeter network-manager-applet noto-fonts noto-fonts-extra noto-fonts-emoji parole gst-libav gst-plugins-bad gst-plugins-ugly firefox gvfs gvfs-mtp xarchiver unrar unzip 7zip pavucontrol transmission-gtk python-requests python-chardet bleachbit

systemctl enable lightdm.service
systemctl enable NetworkManager
systemctl set-default graphical.target
sed -i 's/^#xserver-command=X/xserver-command=X -s 0 -dpms/' /etc/lightdm/lightdm.conf
sed -i 's/^#autologin-user=/autologin-user=andrei/' /etc/lightdm/lightdm.conf
sed -i 's/^#autologin-session=/autologin-session=xfce/' /etc/lightdm/lightdm.conf
groupadd -r autologin
gpasswd -a andrei autologin

tee /etc/polkit-1/rules.d/49-udisks2-mount.rules > /dev/null <<'INNER'
polkit.addRule(function(action, subject) {
    if (
        (action.id.indexOf("org.freedesktop.udisks2.") == 0) &&
        subject.isInGroup("wheel")
    ) {
        return polkit.Result.YES;
    }
});
INNER

pacman -S --noconfirm ufw
systemctl enable ufw.service
systemctl start ufw.service
ufw default allow outgoing
ufw default deny incoming
ufw allow 51413/tcp
ufw enable
timedatectl set-ntp true
timedatectl status
exit
CHROOT

# Clear password variable in the parent shell
unset PASSWORD

umount -R /mnt
reboot
