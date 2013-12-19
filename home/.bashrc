if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
  fi

#Add ~/bin to path
PATH=~/bin:$PATH

#Make cask install apps in /Applications
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

source "$HOME/.homesick/repos/homeshick/homeshick.sh"

source "$HOME/.homesick/repos/homeshick/completions/homeshick-completion.bash"