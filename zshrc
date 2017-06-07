# {{{ ENV variables
export EDITOR='vim'
# }}}

# {{{ zsh options
ZSH_THEME="agnoster"
HYPHEN_INSENSITIVE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
DEFAULT_USER=zoid
# }}}

# {{{ Plugins
plugins=(git)
# }}}

# {{{ Aliases
alias zshrc="vim ~/.zshrc"
alias zshsrc="source ~/.zshrc"

# Apache
alias rldapache="sudo /etc/init.d/apache2 reload"                   # Reload apache
alias errapache="tail -f /var/log/apache2/error.log"                # Show error log of apache

# python
alias rmpyc="rm *.pyc"                                              # remove bytecode files
alias showpython="ps -fA | grep python"                             # show all running python processes
alias lsh='ls -l --ignore "*.pyc" --ignore "*.swp" --ignore "*swo"' # Clean ls without temp files

# stay in the folder navigated to when exiting ranger
alias ranger='ranger --choosedir=$HOME/.rangerdir;cd $(cat $HOME/.rangerdir)'

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

alias convertdoc="libreoffice --convert-to pdf *.doc* && rm *.doc*"
alias showkeys="screenkey -t 1 --bak-mode baked --ignore Caps_Lock"
# }}}

function zoidboot {
  xcape -e 'Caps_Lock=Escape'                                      # Map Caps-Lock to Escape
  setxkbmap -option 'caps:ctrl_modifier'                           # Map Caps-Lock-modifier to Ctrl
}

function apply {
  cat ~/dotfiles/terminalrc ~/dotfiles/$BACKGROUND > ~/.config/xfce4/terminal/terminalrc
  sleep 0.5
  touch ~/.config/xfce4/terminal/terminalrc
}
# change background color of terminal and vim
function light {
  export BACKGROUND="light" && apply
}
function dark {
  export BACKGROUND="dark" && apply
}
# default is dark
if [ -z "$BACKGROUND" ]; then
    export BACKGROUND="dark"
fi

# show filesizes sorted
function dusort {
  du -sch "$@" | sort -h
}

# count number of files in all subfolders
function treecount {
    find -maxdepth 1 -type d | while read -r dir; do
      printf "%5d files in %s\n" "$(find "$dir" -type f | wc -l)" "$dir";
    done
}

# {{{ oh-my-zsh
export ZSH=/home/zoid/.oh-my-zsh
source $ZSH/oh-my-zsh.sh
# }}}

# vi-keybindings
bindkey -v '^?' backward-delete-char

# zsh: foldmethod=marker
