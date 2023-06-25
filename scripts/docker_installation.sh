#!/usr/bin/env bash

set -e

# Should be run as root
# This needs the username of the user to add as an argument

regular_user=$1

export DEBIAN_FRONTEND=noninteractive

cat <<END
+--------------------------------------------------------------+
+  The installation process of Docker has been started.        +
+  This process whould take some minutes                       +
+--------------------------------------------------------------+
END

apt -y install ca-certificates curl gnupg bookworm >> /dev/null

mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
bookworm stable" | tee /etc/apt/sources.list.d/docker.list >> /dev/null

chmod a+r /etc/apt/keyrings/docker.gpg
apt update >> /dev/null

apt -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin >> /dev/null

# put docker as service
systemctl enable docker >> /dev/null

su - -c "usermod -aG docker $regular_user"

cat <<END
+------------------------------------------------+
+ Docker installation has end successfully.      +
+------------------------------------------------+
END
