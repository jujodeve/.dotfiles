#!/usr/bin/env bash

sudo pacman -S --noconfirm --ask=4 libvirt iptables-nft dnsmasq dmidecode virt-manager qemu-full

sudo usermod -a -G libvirt jotix

sudo systemctl enable libvirtd.service --now
