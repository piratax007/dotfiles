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

su -c "apt -y install tilix lsd ranger cpufetch neofetch bat picom feh nm-applet bpytop wget translate-shell emacs mc gdu pdftk unrar youtube-dl calcurse taskwarrior >> /dev/null"

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

rsync -a $dotfiles_dir/ranger/ ~/.config

rsync -a $dotfiles_dir/lsd/ ~/.config

rsync -a $dotfiles_dir/.emacs $dotfiles_dir/.emacs.d/ ~/.config

cat <<END
+----------------------------------------------------------------+
  The configuration files has been restored successfully.
+----------------------------------------------------------------+
END

cat <<END
+----------------------------------------------------------------+
  Will be installed atuin terminal history manager
+----------------------------------------------------------------+
END

cargo install atuin

rsync -a $dotfiles_dir/atuin/ ~/.config

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

su -c "docker-installation.sh $USER"

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

su -c "tor-installation.sh"

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
  The backup script has been restores successfully.
+----------------------------------------------------------------+
END
