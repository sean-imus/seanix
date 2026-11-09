#!/bin/sh
# Unlocks the encrypted partition on this stick and runs the real installer from it.
set -eu
[ "$(id -u)" -eq 0 ] || exec sudo sh "$0"

dev=/dev/disk/by-uuid/7685cddb-6ca4-4e91-b108-d137b3ab1af3
name=privat-usb
mnt=/privat

[ -e "$dev" ] || { echo "Encrypted partition not found: $dev" >&2; exit 1; }
[ -e "/dev/mapper/$name" ] || cryptsetup open "$dev" "$name"
mkdir -p "$mnt"
mountpoint -q "$mnt" || mount "/dev/mapper/$name" "$mnt"
exec sh "$mnt/usb-install.sh"
