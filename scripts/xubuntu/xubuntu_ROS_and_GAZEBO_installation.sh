#!/usr/bin/env bash

set -e

export DEBIAN_FRONTEND=noninteractive

cat <<END
+------------------------------------------------------------+
  Will be installed ROS 2 JAZZY JALISCO. Please use
  your password.
+------------------------------------------------------------+
END

existing_software_properties_common=`which software-properties-common || echo ""`
if [ -z "$existing_software_properties_common" ]; then
    echo ""
    echo "Will be installed software properties common, please use your password"
    sudo apt -y install software-properties-common >> /dev/null
fi

sudo add-apt-repository universe
sudo apt update && sudo apt -y full-upgrade

export ROS_APT_SOURCE_VERSION=$(curl -s https://api.github.com/repos/ros-infrastructure/ros-apt-source/releases/latest | grep -F "tag_name" | awk -F'"' '{print $4}')

curl -L -o /tmp/ros2-apt-source.deb "https://github.com/ros-infrastructure/ros-apt-source/releases/download/${ROS_APT_SOURCE_VERSION}/ros2-apt-source_${ROS_APT_SOURCE_VERSION}.$(. /etc/os-release && echo ${UBUNTU_CODENAME:-${VERSION_CODENAME}})_all.deb"

sudo dpkg -i /tmp/ros2-apt-source.deb >> /dev/null

sudo apt update >> /dev/null

sudo apt -y install ros-dev-tools >> /dev/null

sudo apt -y upgrade >> /dev/null

sudo apt -y install ros-jazzy-desktop-full

# source /opt/ros/humble/setup.zsh

cat <<END
+------------------------------------------------------------+
  ROS 2 JAZZY JALISCO. Has been installed succesfully.
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
  Will be installed GAZEBO HARMONIC. Please use
  your password.
+------------------------------------------------------------+
END

sudo curl https://packages.osrfoundation.org/gazebo.gpg --output /usr/share/keyrings/pkgs-osrf-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/pkgs-osrf-archive-keyring.gpg] https://packages.osrfoundation.org/gazebo/ubuntu-stable $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/gazebo-stable.list >> /dev/null

sudo apt-get update

sudo apt-get -y install gz-harmonic

cat <<END
+------------------------------------------------------------+
  GAZEBO IGNITION FORTRESS. Has been installed succesfully.
+------------------------------------------------------------+
END
