#!/usr/bin/env bash

set -e

export DEBIAN_FRONTEND=noninteractive

scripts_dir=$(pwd)
dotfiles_dir=$scripts_dir/..
user=$(whoami)

cat <<END
+----------------------------------------------------------------+
  Will be set the repositories list. In order to can do the
  operation, please use your root password
+----------------------------------------------------------------+
END

su -c "rsync -au $dotfiles_dir/sources.list /etc/apt/ && apt update >> /dev/null"

cat <<END
+----------------------------------------------------------------+
  The repositories list has been updated successfully.
+----------------------------------------------------------------+
END

cat <<END
+----------------------------------------------------------------+
  Will be installed the terminal utils and dependencies to
  allow compled the setup. Please use your root password.
+----------------------------------------------------------------+
END

su -c "apt -y install tilix lsd ranger cpufetch neofetch bat picom feh network-manager-gnome bpytop wget translate-shell emacs mc gdu pdftk unrar youtube-dl calcurse taskwarrior libxcb1-dev build-essential ytfzf qemu-system libvirt-daemon-system virt-manager >> /dev/null"

cat <<END
+----------------------------------------------------------------+
  The utilities has been installed successfully.
+----------------------------------------------------------------+
END

cat <<END
+----------------------------------------------------------------+
  Will be restored the configuration files.
+----------------------------------------------------------------+
END

rsync -au $dotfiles_dir/ranger ~/.config

rsync -au $dotfiles_dir/lsd ~/.config

rsync -au $dotfiles_dir/.emacs $dotfiles_dir/.emacs.d ~/

rsync -au $dotfiles_dir/NerdFonts ~/.local/share/fonts/

echo -n "Please enter the path of the sshd_config file, and use your root password in order to put that file in the right directory: "
read sshConfigFile

su -c "rsync sshConfigFile /etc/ssh/"

cat <<END
+----------------------------------------------------------------+
  The configuration files has been restored successfully.
+----------------------------------------------------------------+
END

cat <<END
+----------------------------------------------------------------+
  Will be installed rust.
+----------------------------------------------------------------+
END

existing_curl=`which curl || echo ""`
if [ -z "$existing_curl" ]; then
    echo ""
    echo "Will be installed curl, please use your root password"
    su -c "apt update && apt -y install curl >> /dev/null"
fi

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

source "$HOME/.cargo/env"

cat <<END
+----------------------------------------------------------------+
  Rust has been installed successfully.
+----------------------------------------------------------------+
END

./install_zsh.sh

cat <<END
+----------------------------------------------------------------+
  Will be installed atuin terminal history manager
+----------------------------------------------------------------+
END

cargo install atuin

rsync -au $dotfiles_dir/atuin ~/.config

echo -n "Please enter the path of the atuin db directory backup:"
read atuinDBBackup

rsync -au $atuinDBBackup ~/.local/share/atuin

cat <<END
+----------------------------------------------------------------+
  Atuin has been installed successfully.
+----------------------------------------------------------------+
END

cat <<END
+----------------------------------------------------------------+
  Will be installed Docker
+----------------------------------------------------------------+
END

su -c "/home/$(whoami)/repos/dotfiles/scripts/docker_installation.sh $(whoami)"

cat <<END
+----------------------------------------------------------------+
  Docker has been installed successfully.
+----------------------------------------------------------------+
END

cat <<END
+----------------------------------------------------------------+
  Will be installed tor
+----------------------------------------------------------------+
END

su -c "/home/$(whoami)/repos/dotfiles/scripts/tor_installation.sh"

cat <<END
+----------------------------------------------------------------+
  tor has been installed successfully.
+----------------------------------------------------------------+
END

cat <<END
+----------------------------------------------------------------+
  Will be restored the Documents and Pictures backups.
  This process would be take some minutes.
+----------------------------------------------------------------+
END

echo -n "Please enter the path to the Documents directory backup:"
read documentsDirectoryBackup

cat <<END
+----------------------------------------------------------------+
  The Documents directory will be restored..
+----------------------------------------------------------------+
END

rsync -au $documentsDirectoryBackup ~/Documents

cat <<END
+----------------------------------------------------------------+
  The Documents directory has been restored successfully.
+----------------------------------------------------------------+
END

echo -n "Please enter the path to the Pictures directory backup:"
read picturesDirectoryBackup

cat <<END
+----------------------------------------------------------------+
  The Documents directory will be restored..
+----------------------------------------------------------------+
END

rsync -au $picturesDirectoryBackup ~/Pictures

cat <<END
+----------------------------------------------------------------+
  The Pictures directory has been restored successfully.
+----------------------------------------------------------------+
END

cat <<END
+----------------------------------------------------------------+
  The backup script will be restored..
+----------------------------------------------------------------+
END

echo -n "Please enter the path to the backup scrip:"
read backupScript

rsync -au $backupScript ~/.local/bin

cat <<END
+----------------------------------------------------------------+
  The backup script has been restored successfully.
+----------------------------------------------------------------+
END

echo -n "Please enter the path to the task configuration file:"
read taskConfigFile

rsync -au $taskConfigFile ~/

cat <<END
+----------------------------------------------------------------+
  The task config file has been restored successfully.
+----------------------------------------------------------------+
END

cat <<END
+----------------------------------------------------------------+
  Will be restored the icons and themes for xfce4.
+----------------------------------------------------------------+
END

rsync -au $dotfiles_dir/.icons/ ~/
rsync -au $dotfiles_dir/.themes/ ~/

cat <<END
+----------------------------------------------------------------+
  Icons and themes for xfce has been restored successfully.
+----------------------------------------------------------------+
END
