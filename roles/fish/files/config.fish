alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

fish_vi_key_bindings

xcape -e 'Caps_Lock=Escape'                                      # Map Caps-Lock to Escape
setxkbmap -option 'caps:ctrl_modifier'                           # Map Caps-Lock-modifier to Ctrl
