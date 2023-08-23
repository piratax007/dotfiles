#!/usr/bin/env bash

set -e

export DEBIAN_FRONTEND=noninteractive

cat <<END
+------------------------------------------------------------+
  Will be installed ROS 2 HUMBLE HAWKSBILL. Please use
  your root password.
+------------------------------------------------------------+
END

existing_software_properties_common=`which curl || echo ""`
if [ -z "$existing_software_properties_common" ]; then
    echo ""
    echo "Will be installed software properties common, please use your root password"
    sudo "apt -y install software-properties-common >> /dev/null"
fi

sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu jammy main" | sudo tee /etc/apt/sources.list.d/ros2.list >> /dev/null

sudo "apt install ros-humble-desktop >> /dev/null"

source /opt/ros/humble/setup.zsh

cat <<END
+------------------------------------------------------------+
  ROS 2 HUMBLE HAWKSBILL. Has been installed succesfully.
+------------------------------------------------------------+
END
