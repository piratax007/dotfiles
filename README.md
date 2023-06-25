# dotfiles
Here I have a serie of scripts, instructions and descriptions about my setup on Debian GNU/Linux. The intention of these
is automate the installation and setup process.

## Disclaimer
These files are tested and useful in my personal configuration, if someone wants to use these, do it under your own risk.

## Scripts
The `scripts` directory has a serie of scripts to automate the installation and restart the setup to a functional state.
Execute the scripts listed below in the given order.

1. `install_and_setup_github_account.sh` script: This script will be install github and will ask you for the location of
   your PGP and SSH keys that use to login and sign in Github, and the location of you git config files. Additionally,
   this scripts will clone the dotfiles repo. To execute this script use the followin command:
   ```
   $ wget -q https://raw.githubusercontent.com/piratax007/dotfiles/main/scripts/install_and_setup_github_account.sh && bash install_and_setup_github_account.sh
   ```

2. `utils_installation.sh` script: Will be installed all the utilities that are useful on terminal.

3. `install_i3wm.sh` script: Will be installed and copied all the utilities and files need to have i3wm in production
   flow.
