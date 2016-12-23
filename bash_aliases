# typo aliases
alias claer="clear"

# change working directory to frequently used directories
alias cdhtml="cd /var/www/html"
alias cdprjct="cd ~/projects"

alias tabesc="xcape -e 'Caps_Lock=Escape'"                          # Map Caps-Lock to Escape
alias tabctrl="setxkbmap -option 'caps:ctrl_modifier'"              # Map Caps-Lock-modifier to Ctrl
alias middlemouse="synclient TapButton3=2"                          # Map triple tap to 3rd mouse button
alias zoidboot="tabesc|tabctrl|middlemouse"                         # Enable my custom settings

alias rldapache="sudo /etc/init.d/apache2 reload"                   # Reload apache
alias errapache="tail -f /var/log/apache2/error.log"                # Show error log of apache

alias sshdo="ssh zoid@46.101.112.121"                               # Ssh into DigitalOcean server
alias dotunnel="ssh -R 10002:localhost:22 tunneler@46.101.112.121"  # Reverse tunnel to DO-Server

alias rmpyc="rm *.pyc"                                              # remove bytecode files
alias showpython="ps -fA | grep python"                             # show all running python processes
alias lsh='ls -l --ignore "*.pyc" --ignore "*.swp" --ignore "*swo"' # Clean ls without temp files


set -o vi                                                           # Enable vi mode for the terminal

shopt -s globstar                                                   # Enable globstar (**) recurses directories
