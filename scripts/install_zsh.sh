#!/usr/bin/env bash

# prerequisite:
# run the install_git script
# run the install_terminal_utils script

set -e

export DEBIAN_FRONTEND=noninteractive

scripts_dir=$(pwd)
dotfiles_dir=$scripts_dir/..

cat <<END
+-------------------------------------------------------+
  In order to install ZSH, use the root password.
+-------------------------------------------------------+
END

su -c "apt install -y zsh"

git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh

rsync -a $dotfiles_dir/.zshrc ~/

cat <<END
+-------------------------------------------------------+
  In order to set ZSH as default shell, use your
  user password.
+-------------------------------------------------------+
END

chsh -s $(which zsh)

cat <<END
+-------------------------------------------------------+
  ZSH has been installed and configured successfully.
+-------------------------------------------------------+
END
