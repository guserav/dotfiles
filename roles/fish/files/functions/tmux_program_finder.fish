function tmux_program_finder
    set -l pidList (pgrep -U (logname) $argv)
    for pane_id in (tmux list-panes -a -F "#{pane_id}")
        set -l pane_tty (tmux display-message -pF "#{pane_tty}" -t $pane_id)
        if ps -o pid= -o comm= -t $pane_tty | grep -q $argv
            echo
            echo "Pane_id: $pane_id $pane_tty | "(set_color -o green)(tmux display-message -t $pane_id -pF "#{session_name}:#{window_index}.#{pane_index}")(set_color normal)
            # Grep at the end is needed because numbers are padded with spaces by ps
            for pid in (ps -ww h -o pid= -t $pane_tty | grep -oE "[0-9]*")
                if set -l index (contains -i $pid $pidList)
                    set --erase pidList[$index]
                end
            end
            ps -ww h -o pid= -o stime= -o comm -o cmd= -H -t $pane_tty | grep -E "$argv|\$"
        end
    end
    for pid in $pidList
        echo (set_color red) "Missing process id" (set_color -o red)$pid(set_color normal)
        ps $pid
    end
end

