if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
  fi

#Add ~/bin to path
PATH=~/bin:$PATH

#Make cask install apps in /Applications
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

alias homeshick="$HOME/.homesick/repos/homeshick/home/.homeshick"
