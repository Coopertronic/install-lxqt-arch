#!/bin/bash

##  This script installs the LXQT desktop on Archlinux
PROGRAM=$(basename $0)
VERSION="0.0.1" # try to get the PKGBUILD file to update this when it builds the package.

# Functions
source ctos-functions
##  Print version info
version_info() {
    echo -e "\n$0 $VERSION - Matthew Phillip Cooper"
}
##  Help screen
help_me() {
    line_break
    version_info
    line_break
    cat <<EOT
    Usage: $PROGRAM < -a >
        -a to to automatily install LXQT.
        -v to display version information
        -h to view this help screen
    If used with no option then it will prompt you for eveything.

    Example:

        --  ./install-lxqt-arch.sh -a
    
EOT
    line_break
}

clear
cd "$PWD"
currentDir=${PWD##*/}
noConfirm=''

##  New section that accepts args -y and -n for yes and no, and -c for --noconfirm
while getopts "ahv" option; do
    case $option in
    a)
        noConfirm='--noconfirm'
        ;;
    h)
        help_me
        exit 3
        ;;
    v)
        version_info
        exit 3
        ;;
    ?)
        help_me
        exit 1
        ;;
    esac
done

line_break '#'
echo "this script will install LXQT."
echo "Are you ready to continue?"
auto_continue $noConfirm
echo "Running xorg install."
sudo pacman -S --needed xorg $noConfirm
echo "Getting LXQT ready."
sudo pacman -S --needed lxqt xdg-utils ttf-freefont sddm $noConfirm
echo "Install essentiel software."
sudo pacman -S --needed libpulse libstatgrab libsysstat lm_sensors network-manager-applet oxygen-icons pavucontrol-qt firewalld firewall-applet $noConfirm
echo "Installing basic modern software application."
sudo pacman -S --needed firefox vlc filezilla leafpad xscreensaver archlinux-wallpaper $noConfirm
sudo systemctl enable sddm
sudo systemctl enable NetworkManager
sudo systemctl enable firewalld
line_break
echo "LXQT has been installed."
echo "Do you want to reboot?"
auto_continue
reboot
