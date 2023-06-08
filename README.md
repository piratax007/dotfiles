# dotfiles
Here I have a serie of scripts, instructions and descriptions about my setup on Debian GNU/Linux. The intention of these
is automate the installation and setup process.

## Disclaimer
These files are tested and useful in my personal configuration, if someone wants to use these, do it under your own risk.

## Software
Here I have a description of the software that I usually install. In some files I have specific instructions to install
specific dependencies.

```
# apt install bat lsd neofetch cpufetch i3 ranger bpytop bluman zsh
```

## Setup files

1. Copy `i3`, `lsd` and `ranger` to the `~/.config/` directory
2. Copy `.icons`, `.themes` and `.emacs.d` to `~` directory
3. Copy `.emacs` and `.zshrc` files to `~` directory

## i3WM

### prerequisites

1. `rofi` - app launcher: `# apt install rofi`
2. `compton` - window compositor: `# apt install compton`
3. `feh` - background desktop manage: `# apt install feh`. Add to `.config/i3/config` -> `exec_always feh --bg-scale
   /path/to/image.jpg`
4. `lxappearance` - windown appearance: `# apt install lxappearance`
5. `lxrandr` - monitors manage: `# apt install lxrandr`
