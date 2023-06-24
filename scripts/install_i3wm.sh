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

su -c "apt -y install i3 i3-wm i3status i3lock i3blocks i3lock-fancy rofi lxappearance lxrandr"

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

existing_curl=`which curl || echo ""`
if [ -z "$existing_curl" ]; then
    echo ""
    echo "Will be installed curl, please use your root password"
    su -c "apt update && apt -y install curl >> /dev/null"
fi

su - "apt -y install libxcb1-dev build-essential"

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

source "$HOME/.cargo/env"

cargo install iwwsr

cat <<END
+----------------------------------------------------------------+
  i3wm has been installed and configured successfully.
+----------------------------------------------------------------+
END
