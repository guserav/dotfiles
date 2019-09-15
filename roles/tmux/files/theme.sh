## The panes {{{
set -g pane-border-style fg=colour235,bg=colour235
set -g pane-active-border-style fg=colour51,bg=colour236
## }}}
#
## The statusbar {{{
#
set -g status-style fg=colour137,bg=colour234
#set -g status-attr dim
set -g status-right ' #[fg=colour137,bg=colour237,bold] #h #[fg=colour233,bg=colour241,bold] %d/%m #[fg=colour233,bg=colour245,bold] %H:%M:%S '
## general window tittle{{{
setw -g window-status-style fg=colour138,bg=colour235,none
setw -g window-status-format ' #I#[fg=colour237]:#[fg=colour250]#W#{?window_activity_flag,#[fg=colour1],#[fg=colour244]}#F '
## }}}
## current window title{{{
setw -g window-status-current-style fg=colour81,bg=colour238,bold
setw -g window-status-current-format ' #I#[fg=colour250]:#[fg=colour255]#W#[fg=colour50]#{?window_zoomed_flag,#[fg=colour40]Z , }' # no asterisk #F
## }}}
## bell or activity {{{
setw -g window-status-bell-style bold,fg=colour138,bg=colour235
setw -g window-status-activity-style bold,fg=colour138,bg=colour235
# }}}
## }}}
#
## The messages {{{
#
#set -g message-attr bold
#set -g message-fg colour232
#set -g message-bg colour166
#
## }}}
#
## vim: foldmethod=marker filetype=tmux
