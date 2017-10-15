alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# Stay in the folger navigated to when exiting ranger
alias ranger="ranger --choosedir=$HOME/.rangerdir; cd (cat $HOME/.rangerdir)"

fish_vi_key_bindings

if test -e ~/.config/fish/xcape.config
    source ~/.config/fish/xcape.config
end
