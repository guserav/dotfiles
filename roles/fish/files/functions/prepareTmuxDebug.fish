# Spawn a given AMOUNT-1 of tmux panes from the current pane
#
# SHELL specifies the program to run in the split panes
# PROGRAM the text to add via send-keys to the panes before the upwards counting number
# SLEEP time argument for sleep to run between every sleep (to prevent overload of system)
# AMOUNT of tmux panes to have at the end
function prepareTmuxDebug
    set -l SHELL $argv[1]
    set -l PROGRAM $argv[2]
    set -l SLEEP $argv[3]
    set -l AMOUNT $argv[4]

    if test (tmux list-panes -F "#{session_name}:#{window_index}" | grep -cE .) -gt 1
        echo "There are multiple panes allready in the current window. This command assumes a window with only one pane."
        return 1
    end
    if test (tmux display-message -p "0#{synchronize-panes}") -ge 1
        echo "synchronized panes is enabled please disable and retry"
        return 1
    end

    set -l window_name (tmux list-panes -F "#{session_name}:#{window_index}")
    echo "window_name: $window_name"
    echo "command: \"$PROGRAM\""
    tmux send-keys -t $window_name.0 "$PROGRAM"
    tmux send-keys -t $window_name.0 " 1"
    for i in (seq 2 $AMOUNT)
        set pane_id (math $i-1)
        tmux split-pane -t $window_name.(math $pane_id-1) "$SHELL"
        tmux send-keys -t $window_name.$pane_id "$PROGRAM"
        tmux send-keys -t $window_name.$pane_id " $i"
        tmux select-layout -t $window_name tiled
        sleep $SLEEP
    end
end
