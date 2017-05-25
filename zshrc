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
alias zshconf="vim ~/.zshrc"
alias zshsrc="source ~/.zshrc"

# Apache
alias rldapache="sudo /etc/init.d/apache2 reload"                   # Reload apache
alias errapache="tail -f /var/log/apache2/error.log"                # Show error log of apache

# DigitalOcean server
alias sshdo="ssh zoid@46.101.112.121"                               # Ssh into DigitalOcean server
alias dotunnel="ssh -R 10002:localhost:22 tunneler@46.101.112.121"  # Reverse tunnel to DO-Server

# python
alias rmpyc="rm *.pyc"                                              # remove bytecode files
alias showpython="ps -fA | grep python"                             # show all running python processes
alias lsh='ls -l --ignore "*.pyc" --ignore "*.swp" --ignore "*swo"' # Clean ls without temp files

# stay in the folder navigated to when exiting ranger
alias ranger='ranger --choosedir=$HOME/.rangerdir;cd $(cat $HOME/.rangerdir)'

#alias claer="clear"
# }}}

function zoidboot {
  xcape -e 'Caps_Lock=Escape'                          # Map Caps-Lock to Escape
  setxkbmap -option 'caps:ctrl_modifier'              # Map Caps-Lock-modifier to Ctrl
}

function dusort {
  du -hs "$@" | sort -h
}

# count number of files in all subfolders
function treecount {
    find . -type d -print0 | while read -d '' -r dir; do
        files=("$dir"/*)
        printf "%5d files in directory %s\n" "${#files[@]}" "$dir"
    done
}

# {{{ oh-my-zsh
export ZSH=/home/zoid/.oh-my-zsh
source $ZSH/oh-my-zsh.sh
# }}}

# vi-keybindings
bindkey -v '^?' backward-delete-char

# zsh: foldmethod=marker
