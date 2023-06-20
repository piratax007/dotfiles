#!/usr/bin/env bash

set -e

export DEBIAN_FRONTEND=noninteractive

scripts_dir=$(pwd)
dotfiles_dir=$scripts_dir/..

cat <<END
+----------------------------------------------------------------+
  Will be installed the terminal utils and dependencies to
  allow compled the setup. Please use your root password.
+----------------------------------------------------------------+
END

su -c "apt -y install tilix lsd ranger cpufetch neofetch bat picom feh nm-applet bpytop wget translate-shell emacs mc gdu pdftk unrar youtube-dl calcurse"

cat <<END
+----------------------------------------------------------------+
  Will be restored the configuration files.
+----------------------------------------------------------------+
END

rsync -a $dotfiles_dir/ranger/ ~/.config

rsync -a $dotfiles_dir/lsd/ ~/.config

rsync -a $dotfiles_dir/.emacs $dotfiles_dir/.emacs.d/ ~/.config

cat <<END
+----------------------------------------------------------------+
  Will be installed atuin terminal history manager
+----------------------------------------------------------------+
END

cargo install atuin

rsync -a $dotfiles_dir/atuin/ ~/.config

echo -n "Please enther the path of the atuin db directory backup:"
read atuinDBBackup

rsync -au atuinDBBackup ~/.local/share/atuin
