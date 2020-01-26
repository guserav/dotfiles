function attachGDB
    # Order needs to be one based
    set -l PROGRAM $argv[1]
    set -l ORDER $argv[2]
    echo (count $argv)
    if test (count $argv) -eq 2
        echo "Processes running: "(ps -eaww -o pid -o comm -o user | grep (whoami) | grep "$PROGRAM" | awk "{print \$1}" | grep -ce ".")
        if test $ORDER -ge 1
            echo (ps -eaww -o pid -o comm -o user | grep (whoami) | grep "$PROGRAM" | awk "{print \$1}" | sort -n )
            set pnum (ps -eaww -o pid -o comm -o user | grep (whoami) | grep "$PROGRAM" | awk "{print \$1}" | sort -n | sed -e $ORDER"q;d")
        else
            set pnum (ps -eaww -o pid -o comm -o user | grep (whoami) | grep "$PROGRAM" | awk "{print \$1}" | sort -n | head -1)
        end

        echo "attaching to: $pnum"
        sudo -E gdb -p $pnum
    else
        set -l HOSTFILE $argv[2]
        for line in (cat $HOSTFILE)
            set -l host (echo "$line" | awk "{print \$1}")
            set -l slots (echo "$line" | grep -oE "slots=[0-9]*" | grep -oE "[0-9]*")
            echo "$host slots=$slots"
            if test $ORDER -le $slots
                echo "Processes running: "(ssh $host ps -eaww -o pid -o comm -o user | grep (whoami) | grep "$PROGRAM" | awk "{print \$1}" | grep -ce ".")
                if test $ORDER -ge 1
                    set pnum (ssh $host ps -eaww -o pid -o comm -o user | grep (whoami) | grep "$PROGRAM" | awk "{print \$1}" | sort -n | sed -e $ORDER"q;d")
                else
                    echo "Have you put in a number: 0 < x <= n?"
                    break
                end
                echo "attaching to: $pnum"
                echo "ssh -t $host sudo -E gdb -p $pnum"
                ssh -t $host sudo -E gdb -p $pnum
                break
            else
                set ORDER (math $ORDER - $slots)
                echo "skipping to next host new ORDER=$ORDER"
            end
        end
    end
end

function attachGDB_debugWrapper
    attachGDB debug_wrapper $argv
end
