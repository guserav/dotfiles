## The panes {{{
set -g pane-border-bg colour235
set -g pane-border-fg colour235
set -g pane-active-border-bg colour236
set -g pane-active-border-fg colour51
## }}}
#
## The statusbar {{{
#
set -g status-bg colour234
set -g status-fg colour137
#set -g status-attr dim
set -g status-right ' #[fg=colour137,bg=colour237,bold] #h #[fg=colour233,bg=colour241,bold] %d/%m #[fg=colour233,bg=colour245,bold] %H:%M:%S '
## general window tittle{{{
setw -g window-status-fg colour138
setw -g window-status-bg colour235
setw -g window-status-attr none
setw -g window-status-format ' #I#[fg=colour237]:#[fg=colour250]#W#{?window_activity_flag,#[fg=colour1],#[fg=colour244]}#F '
## }}}
## current window title{{{
setw -g window-status-current-fg colour81
setw -g window-status-current-bg colour238
setw -g window-status-current-attr bold
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
