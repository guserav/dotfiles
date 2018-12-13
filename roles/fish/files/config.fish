alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# Stay in the folger navigated to when exiting ranger
alias ranger="ranger --choosedir=$HOME/.rangerdir; cd (cat $HOME/.rangerdir)"

# Show git status per default
set -g _show_git_status "show"

# Allow easy mount of shared folders in vm
alias mountVM="vmhgfs-fuse /mnt -o umask=22"

fish_vi_key_bindings

if test -e ~/.config/fish/xcape.config
    source ~/.config/fish/xcape.config
end
