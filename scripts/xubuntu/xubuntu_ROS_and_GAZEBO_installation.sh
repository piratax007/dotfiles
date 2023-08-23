#!/usr/bin/env bash

set -e

export DEBIAN_FRONTEND=noninteractive

cat <<END
+------------------------------------------------------------+
  Will be installed ROS 2 HUMBLE HAWKSBILL. Please use
  your password.
+------------------------------------------------------------+
END

existing_software_properties_common=`which software-properties-common || echo ""`
if [ -z "$existing_software_properties_common" ]; then
    echo ""
    echo "Will be installed software properties common, please use your password"
    sudo apt -y install software-properties-common >> /dev/null
fi

sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list >> /dev/null

sudo apt update && apt -y install ros-humble-desktop >> /dev/null

source /opt/ros/humble/setup.zsh

cat <<END
+------------------------------------------------------------+
  ROS 2 HUMBLE HAWKSBILL. Has been installed succesfully.
+------------------------------------------------------------+
END

existing_lsb_release=`which lsb-release || echo ""`
if [ -z "$existing-lsb-release" ]; then
    echo ""
    echo "Will be installed lsb-release, please use your password"
    sudo apt -y install lsb-release >> /dev/null
fi


existing_gnupg=`which gnupg || echo ""`
if [ -z "$existing-gnupg" ]; then
    echo ""
    echo "Will be installed gnupg, please use your password"
    sudo apt -y install gnupg >> /dev/null
fi

cat <<END
+------------------------------------------------------------+
  Will be installed GAZEBO IGNITION FORTRESS. Please use
  your password.
+------------------------------------------------------------+
END

sudo wget https://packages.osrfoundation.org/gazebo.gpg -O /usr/share/keyrings/pkgs-osrf-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/pkgs-osrf-archive-keyring.gpg] http://packages.osrfoundation.org/gazebo/ubuntu-stable $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/gazebo-stable.list >> /dev/null

sudo apt update

sudo apt -y install ignition-fortress

cat <<END
+------------------------------------------------------------+
  GAZEBO IGNITION FORTRESS. Has been installed succesfully.
+------------------------------------------------------------+
END
