function toggle_git_info --description 'Toggle the git info part of the prompt'
    if set -q _show_git_status
        echo "Git status will now be hidden"
        set -g -e _show_git_status
    else
        echo "Git status will now be shown"
        set -g _show_git_status "show"
    end
end

function shortened_pwd --description 'Print the working directory in short form with n directories spelled out'
    set -l short (prompt_pwd)
    set -l realhome ~
    set -l long (string replace -r '^'"$realhome"'($|/)' '~$1' (pwd))

    set -q showDirs # default to not collapsing any dirs
    or set -l showDirs 0

    if test $showDirs -eq 0 # when showDirs is 0 don't collapse anything
        echo $long
    else
        if test $showDirs -gt 0
            # ((/.*){0,n})$
            set -l short (string replace -r '^(~?)((/[^/]*)*?)((/[^/]*){0,'"$showDirs"'})$' '$1$2' $short)
            set -l long (string replace -r '^(~?)((/[^/]*)*?)((/[^/]*){0,'"$showDirs"'})$' '$4' $long)
            echo $short$long
        else
            set -l showDirs (expr -1 \* $showDirs)
            set -l short (string replace -r '^(~?)((/[^/]*){'"$showDirs"'})((/[^/]*)*?)$' '$1$2' $short)
            set -l long (string replace -r '^(~?)((/[^/]*){'"$showDirs"'})((/[^/]*)*?)$' '$4' $long)
            echo $short$long
            # TODO implement
        end
    end
end

function fish_prompt --description 'Write out the prompt'
	set laststatus $status
    function _git_branch_name
        echo (git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
    end
    function _is_git_dirty
        echo (git status -s --ignore-submodules=dirty ^/dev/null)
    end


    set git_info ""
    if git --version 2>&1 > /dev/null
        if set -q _show_git_status
           if [ (_git_branch_name) ]
               set -l git_branch (set_color -o blue)(_git_branch_name)
               if [ (_is_git_dirty) ]
                   for i in (git branch -qv --no-color| string match -r '\*'|cut -d' ' -f4-|cut -d] -f1|tr , '\n')\
                       (git status --porcelain | cut -c 1-2 | uniq)
                       switch $i
                           case "*[ahead *"
                               set git_status "$git_status"(set_color red)"^"
                           case "*behind *"
                               set git_status "$git_status"(set_color red)"_"
                           case "."
                               set git_status "$git_status"(set_color green)"+"
                           case " D"
                               set git_status "$git_status"(set_color red)"X"
                           case "*M*"
                               set git_status "$git_status"(set_color yellow)"~"
                           case "*R*"
                               set git_status "$git_status"(set_color purple)"~"
                           case "*U*"
                               set git_status "$git_status"(set_color brown)"═"
                           case "??"
                               set git_status "$git_status"(set_color red)"?"
                       end
                   end
               else
                   set git_status (set_color green):
               end
               set git_info (set_color black)"(git$git_status$git_branch"(set_color black)")"
           end
        end
    end

    if test $laststatus -eq 0
        set laststatus_info (set_color green)$laststatus
    else
        set laststatus_info (set_color -o red)$laststatus
    end

    # //copied from https://github.com/JohnAZoidberg/dotfiles
    set -l nix_shell_info (
        # Variable can be empty, "impure" or "pure"
        if test -n "$IN_NIX_SHELL"
            echo -n (set_color red)"nix"
        end
    )

    set -l new_line_prompt "$nix_shell_info"(set_color normal)">"(set_color normal)
    set -l user_info (set_color blue)"$USER"
    set -l host_info (set_color normal)"@"(hostname --short)
    set -l dir_info (echo -n (set_color green)(shortened_pwd))
    set -l shell_level (
        #indicate when shell level is higher then 4: sh, tmux (not counting), sh, nix-shell, sh
        if [ $SHLVL -gt 4 ]
            echo -n (set_color red)
        else
            echo -n (set_color normal)
        end
        echo -n "$SHLVL"
    )

    printf '%s %s[%s] %s%s %s%s %s\f\r%s '\
    $shell_level                \
    (set_color normal)          \
    (date "+%H:%M:%S")          \
    $user_info                  \
    $host_info                  \
    $dir_info                   \
    $git_info                   \
    $laststatus_info            \
    $new_line_prompt
end
