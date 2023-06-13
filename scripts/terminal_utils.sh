#!/usr/bin/env bash

set -e

export DEBIAN_FRONTEND=noninteractive

cat <<END
+----------------------------------------------------------------+
  Will be installed the terminal utils and dependencies to
  allow compled the setup.
+----------------------------------------------------------------+
END

su - "apt -y install tilix lsd ranger cpufetch neofetch bat picom feh nm-applet bpytop i3lock-fancy wget"

cat <<END
+----------------------------------------------------------------+
  Will be installed rust in order to allow the installation of
  iwwsr and atuin
+----------------------------------------------------------------+
END

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

cat <<END
+----------------------------------------------------------------+
  Will be installed iwwsr
+----------------------------------------------------------------+
END

cargo install iwwsr

cat <<END
+----------------------------------------------------------------+
  Will be installed atuin terminal history manager
+----------------------------------------------------------------+
END

cargo install atuin
