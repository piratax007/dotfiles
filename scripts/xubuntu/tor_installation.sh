#!/usr/bin/env bash

# This script has to be run as root

set -e

cat <<END
+---------------------------------------------------------+
  tor will be installed. This process would be take
  some minutes.
+---------------------------------------------------------+
END

apt -y install apt-transport-https gnupg >> /dev/null

echo "deb     [signed-by=/usr/share/keyrings/tor-archive-keyring.gpg] https://deb.torproject.org/torproject.org jammy main" > /etc/apt/sources.list.d/tor.list

wget -qO- https://deb.torproject.org/torproject.org/A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89.asc | gpg --dearmor > /usr/share/keyrings/tor-archive-keyring.gpg

apt update >> /dev/null
apt -y install tor deb.torproject.org-keyring  >> /dev/null

cat <<END
+---------------------------------------------------------+
  tor has been installed successfully.
+---------------------------------------------------------+
END

# Backlog: Add configuration of SSH over tor
