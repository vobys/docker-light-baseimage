#!/bin/sh -e

# download curl and ca-certificate from apt-get if needed
to_install=""

if [ $(dpkg-query -W -f='${Status}' curl 2>/dev/null | grep -c "ok installed") -eq 0 ]; then
  to_install="curl"
fi

if [ $(dpkg-query -W -f='${Status}' ca-certificates 2>/dev/null | grep -c "ok installed") -eq 0 ]; then
  to_install="$to_install ca-certificates"
fi

if [ -n "$to_install" ]; then
  LC_ALL=C DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends $to_install
fi

LC_ALL=C DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends openssl jq

curl -o cfssl.deb -SL http://ftp.us.debian.org/debian/pool/main/g/golang-github-cloudflare-cfssl/golang-cfssl_1.2.0+git20160825.89.7fb22c8-3+b1_arm64.deb
apt install ./cfssl.deb
rm -f ./cfssl.deb

# remove tools installed to download cfssl
if [ -n "$to_install" ]; then
  apt-get remove -y --purge --auto-remove $to_install
fi

exit 0
