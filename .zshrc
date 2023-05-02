# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/fausto/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="arrow"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git colorize colored-man-pages command-not-found extract web-search pep8)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#

# export GOROOT=/usr/bin
export GOPATH=/usr/local/go/bin
# export GOBIN=$GOPATH/bin
export PYCHARM=/opt/pycharm-community-2021.3.3/bin
export PASSWORD_STORE_DIR=/home/fausto/repos/secrets/password-store

export PATH=$GOBIN:$GOROOT/bin:$PASSWORD_STORE_DIR:/home/fausto/.local/bin:$PYCHARM:$PATH:/home/fausto/.rvm/bin

export ORIGIN=~/.config/primenote/notes
export ORIGIN1=~/.gnupg
export ORIGIN2=~/.ssh
export ORIGIN3=~/Documents
export ORIGIN5=~/Pictures
export ORIGIN6=~/repos/secrets
export ORIGIN7=~/.basrc
export ORIGIN8=~/.gitconfig
export ORIGIN9=~/.profile
export ORIGIN10=~/.zshrc
export ORIGIN11=~/.config/ranger
export ORIGIN12=~/.emacs
export DESTINY=/media/fausto/support/backup_CAD

alias bcoy='clear && rm ./bin/coyim && make build && ./bin/coyim'
alias bcoydb='G_DEBUG=fatal_warnings bin/coyim -debug'
alias backup='rsync -artvup --exclude 'go' --exclude 'processing-4.0b6' $ORIGIN $ORIGIN1 $ORIGIN2 $ORIGIN3 $ORIGIN5 $ORIGIN6 --exclude 'website' --exclude 'website-autonomia.digital' $ORIGIN7 $ORIGIN8 $ORIGIN9 $ORIGIN10 $ORIGIN11 $ORIGIN12 $DESTINY'
alias emacs="emacs -nw"
alias ls="lsd -alF"

[[ -s "/home/fausto/.gvm/scripts/gvm" ]] && source "/home/fausto/.gvm/scripts/gvm"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte-2.91.sh
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Thunderbird environments variables
export THUNDERBIRD_SOURCE="~/repos/thunderbird/"
export MOZBUILD="~/repos/thunderbird_deps"

export PATH=$PATH:/home/fausto/.spicetify
