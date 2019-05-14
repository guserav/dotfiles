alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# Stay in the folger navigated to when exiting ranger
alias ranger="ranger --choosedir=$HOME/.rangerdir; cd (cat $HOME/.rangerdir)"

# Show git status per default
set -g _show_git_status "show"

# show only 6 dirs in full length
set -g showDirs 6

# Allow easy mount of shared folders in vm
alias mountVM="vmhgfs-fuse /mnt -o umask=22"

# Ensure rm is asking before deleting large files
alias rm="rm -I"

# Proxy stuff
# Enable corp proxy
alias useCorpPoxy="sudo systemctl stop noproxy.service; and sudo systemctl start corpproxy.service"
# no proxy
alias useNoProxy="sudo systemctl stop corpproxy.service; and sudo systemctl start noproxy.service"

# Set proper TERM varibale as this seems to brake a lot...
alias ssh="env TERM=\"xterm-256color\" ssh"

# Run nix-shell with fish as shell
function ns
  nix-shell --run fish $argv
end
if test -e ~/.config/fish/xcape.config
    source ~/.config/fish/xcape.config
end
