alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

fish_vi_key_bindings

if test -e xcape.config
    source xcape.config
end
