#!/usr/bin/env bash

set -e

if [[ ! -b /dev/disk/by-label/arch-efi ]]; then
    echo "arch-efi labeled fat32 partition must be present"
    exit
fi

if [[ ! -b /dev/disk/by-label/arch ]] || [[ ! -b /dev/disk/by-label/arch-home ]]; then
    echo "arch & arch-home labeled btrfs partition must be present"
    exit
fi

### set_password "message" minimun_lenght
set_password() {
    PASS1=""
    PASS2=""
    while [[ "$PASS1" != "$PASS2" ]] ||  (( ${#PASS1} < $2 )); do
        read -sp "$1 (minimum $2 chars): " PASS1; echo >&2
        read -sp "confirm password: " PASS2; echo >&2
        if  [[ "$PASS1" != "$PASS2" ]]; then
            echo "the passwords don't match." >&2
        elif (( ${#PASS1} < $2 )); then
            echo "the password is too short." >&2
        fi
    done
    echo $PASS1
}

echo
read -p "Wich host install (jtx or ffm): " HOST
if [[ $HOST != "jtx" ]] && [[ $HOST != "ffm" ]]; then
    echo "The host $HOST doesn't exists"
    exit
fi
HOST=$HOST-arch

echo
ROOT_PASS=$(set_password "Enter root password" 5)
echo
JOTIX_PASS=$(set_password "Enter jotix password" 5)

if [[ $HOST == "ffm-arch" ]]; then
    echo
    FILOFEM_PASS=$(set_password  "Enter filofem password" 5)
fi

### disk configuration ########################################################

### EFI
# fat32 LABEL=arch-efi 
#
# btrfs LABEL=arch
# Subvolumes Layout
# @          /
# @log       /var/log
# @pkg       /var/cache/pacman/pkg
# @snapshots /.snapshots
#
# btrfs LABEL=arch-home
# @home      /home

# create subvolumes in arch disk
mount LABEL=arch /mnt
[[ ! -d /mnt/@ ]] && btrfs subvolume create /mnt/@
[[ ! -d /mnt/@log ]] && btrfs subvolume create /mnt/@log
[[ ! -d /mnt/@pkg ]] && btrfs subvolume create /mnt/@pkg
[[ ! -d /mnt/@snapshots ]] && btrfs subvolume create /mnt/@snapshots
umount -R /mnt

# create home subvolume in arch-home
mount LABEL=arch-home /mnt
[[ ! -d /mnt/@home ]] && btrfs subvolume create /mnt/@home 
umount -R /mnt

### make the directories & mounting

mount LABEL=arch /mnt -osubvol=/@

# EFI
mount --mkdir LABEL=arch-efi /mnt/boot/efi

# log
mount --mkdir LABEL=arch /mnt/var/log -osubvol=/@log

# pkg
mount --mkdir LABEL=arch /mnt/var/cache/pacman/pkg -osubvol=/@pkg

# snapshots
mount --mkdir LABEL=arch /mnt/.snapshots -osubvol=@snapshots

# home
mount --mkdir LABEL=arch-home /mnt/home -osubvol=/@home

### extra disks

# arch
mount --mkdir LABEL=arch /mnt/mnt/arch -osubvol=/

# arch-home
mount --mkdir LABEL=arch-home /mnt/mnt/arch-home -osubvol=/

# jtx-data
[[ -b "/dev/disk/by-label/jtx-data" ]] && mount --mkdir LABEL=jtx-data /mnt/mnt/jtx-data -osubvol=/

### enable parallel downloads
sed -i -e 's/#ParallelDownloads = 5/ParallelDownloads = 10/g' /etc/pacman.conf
sed -i -e 's/ParallelDownloads = 5/ParallelDownloads = 10/g' /etc/pacman.conf

### install base system
pacstrap /mnt base linux linux-firmware

### generate fstab
genfstab -U /mnt >> /mnt/etc/fstab

### network configuration
echo $HOST > /mnt/etc/hostname

### enable parallel downloads in new installation
sed -i -e 's/#ParallelDownloads = 5/ParallelDownloads = 10/g' /mnt/etc/pacman.conf
sed -i -e 's/ParallelDownloads = 5/ParallelDownloads = 10/g' /mnt/etc/pacman.conf

### chroot installation #######################################################

### chr function
chr() {
  arch-chroot /mnt $@
}

### locale config
chr ln -sf /usr/share/zoneinfo/America/Argentina/Buenos_Aires /etc/localtime
chr hwclock --systohc
sed -i -e 's/#en_US.UTF-8/en_US.UTF-8/g' /mnt/etc/locale.gen
sed -i -e 's/#es_AR.UTF-8/es_AR.UTF-8/g' /mnt/etc/locale.gen
chr locale-gen
echo LANG=en_US.UTF-8 > /mnt/etc/locale.conf

### install packages ##########################################################
PACKAGES="
networkmanager
ntp
btrfs-progs
efibootmgr
amd-ucode
sudo
neovim
git
openssh
fish
grub
base-devel
exa
bat
"
chr pacman -S --noconfirm --needed $PACKAGES

### install & config grub
chr grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=Grub
chr grub-mkconfig -o /boot/grub/grub.cfg

### config sudo
sed -i -e 's/# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/g' /mnt/etc/sudoers

### set the root password
echo "root:$ROOT_PASS" | chr chpasswd

### set jotix user
chr useradd -G wheel -s /usr/bin/fish jotix
echo "jotix:$JOTIX_PASS" | chr chpasswd jotix
# set home dir
[[ ! -d /mnt/home/jotix ]] && mkdir /mnt/home/jotix
chr chown -R jotix /home/jotix

### set filofem user
if [[ $HOST == "ffm-arch" ]]; then
    chr useradd -s /usr/bin/fish filofem
    echo "filofem:$FILOFEM_PASS" | chr chpasswd filofem
    # set home dir
    [[ ! -d /mnt/home/filofem ]] && mkdir /mnt/home/filofem
    chr chown -R filofem /home/filofem
fi

### enable services
chr systemctl enable fstrim.timer
chr systemctl enable NetworkManager
chr systemctl enable ntpdate

### unmount & reboot
echo "Installation finished, you can do some final asjustements now or reboot and use the new system:
> umount -R /mnt
> reboot
"
