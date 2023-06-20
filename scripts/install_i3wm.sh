#!/usr/bin/env bash

set -e

export DEBIAN_FRONTEND=noninteractive

scripts_dir=$(pwd)
dotfiles_dir=$scripts_dir/..

cat <<END
+----------------------------------------------------------------+
  Will be installed i3WM, please use your root password.
+----------------------------------------------------------------+
END

su -c "apt -y install i3 i3-wm i3status i3lock i3blocks i3lock-fancy rofi"

cat <<END
+----------------------------------------------------------------+
  Will be restored the configuration files.
+----------------------------------------------------------------+
END

rsync -a $dotfiles_dir/i3 ~/.config

rsync -a $dotfiles_dir/i3status ~/.config

cd ~/repos

git clone --depth=1 https://github.com/adi1090x/rofi.git

cd ~/repos/rofi

chmod +x setup.sh

./setup.sh

rsync -au $dotfiles_dir/rofi ~/.config/rofi

rsync -a $dotfiles_dir/moon.jpg ~/Pictures

cat <<END
+----------------------------------------------------------------+
  Will be installed rust in order to allow the installation of
  iwwsr
+----------------------------------------------------------------+
END

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

cat <<END
+----------------------------------------------------------------+
  Will be installed iwwsr
+----------------------------------------------------------------+
END

cargo install iwwsr
