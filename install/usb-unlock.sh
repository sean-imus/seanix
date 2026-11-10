# Unlocks the encrypted partition on this stick and runs the real installer from it.
set -eu
[ "$(id -u)" -eq 0 ] || exec sudo sh "$0"

name=privat-usb
mnt=/privat

# The stick is whatever disk this script lives on; the internal disk may be LUKS too.
src=$(findmnt -no SOURCE --target "$(dirname "$(readlink -f "$0")")")
disk=$(lsblk -nsrpo NAME "$src" | tail -n 1)
dev=$(lsblk -nrpo NAME,FSTYPE "$disk" | awk '$2 == "crypto_LUKS" { print $1 }')

case $(printf '%s\n' "$dev" | grep -c .) in
  1) ;;
  0) echo "No encrypted partition on $disk" >&2; exit 1 ;;
  *) echo "More than one encrypted partition on $disk:" >&2; echo "$dev" >&2; exit 1 ;;
esac

[ -e "/dev/mapper/$name" ] || cryptsetup open "$dev" "$name"
mkdir -p "$mnt"
mountpoint -q "$mnt" || mount "/dev/mapper/$name" "$mnt"
exec sh "$mnt/usb-install.sh"
