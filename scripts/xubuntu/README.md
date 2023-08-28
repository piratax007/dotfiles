Once you have your installation of Xubuntu 22.04 Jammy Jellyfish, you will be able to run the configuration scripts to
have all the development environment ready. Follow the next steps in ordet to run the scripts in the right way.

1. Run the script `install_and_setup_github_accound.sh` using this command
   ```
   $ wget -q https://raw.githubusercontent.com/piratax007/dotfiles/main/scripts/xubuntu/install_and_setup_github_account.sh && bash install_and_setup_github_account.sh
   ```
   
2. Run the script `utilis_installation.sh` in order to have all the utilities that are useful on terminal.

3. _Before to continue with the installation of `i3wm`, is highly recommendable restart all the system._ Continue with
   the installation of `i3wm`, executing the `install_i3wm.sh` script.
   
4. In order to can work with ROS and GAZEBO, execute the script `xubuntu_ROS_and_GAZEBO_installation.sh`
