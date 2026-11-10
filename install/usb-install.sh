set -eu
[ "$(id -u)" -eq 0 ] || exec sudo sh "$0"

rm -rf /tmp/seanix
git clone https://github.com/sean-imus/seanix /tmp/seanix
exec sh /tmp/seanix/install/install.sh "$(dirname "$(readlink -f "$0")")"
