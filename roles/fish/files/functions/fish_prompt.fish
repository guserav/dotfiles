function fish_prompt --description 'Write out the prompt'
	set laststatus $status
    function _git_branch_name
        echo (git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
    end
    function _is_git_dirty
        echo (git status -s --ignore-submodules=dirty ^/dev/null)
    end


    set git_info ""
    if [ (_git_branch_name) ]
        set -l git_branch (set_color -o blue)(_git_branch_name)
        if [ (_is_git_dirty) ]
            for i in (git branch -qv --no-color| string match -r '\*'|cut -d' ' -f4-|cut -d] -f1|tr , '\n')\
                (git status --porcelain | cut -c 1-2 | uniq)
                switch $i
                    case "*[ahead *"
                        set git_status "$git_status"(set_color red)⬆
                    case "*behind *"
                        set git_status "$git_status"(set_color red)⬇
                    case "."
                        set git_status "$git_status"(set_color green)✚
                    case " D"
                        set git_status "$git_status"(set_color red)✖
                    case "*M*"
                        set git_status "$git_status"(set_color green)✱
                    case "*R*"
                        set git_status "$git_status"(set_color purple)➜
                    case "*U*"
                        set git_status "$git_status"(set_color brown)═
                    case "??"
                        set git_status "$git_status"(set_color red)≠
                end
            end
        else
            set git_status (set_color green):
        end
        set git_info (set_color black)"(git$git_status$git_branch"(set_color black)")"
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
    set -l dir_info (echo -n (set_color green)(echo $PWD | sed -e "s|^$HOME|~|"))
    set -l shell_level (
        #indicate when shell level is higher then 4: sh, tmux (not counting), sh, nix-shell, sh
        if [ $SHLVL -gt 4 ]
            echo -n (set_color red)
        else
            echo -n (set_color normal)
        end
        echo -n "$SHLVL"
    )

    printf '%s %s[%s] %s %s%s %s\f\r%s '\
    $shell_level                \
    (set_color normal)          \
    (date "+%H:%M:%S")          \
    $user_info                  \
    $dir_info                   \
    $git_info                   \
    $laststatus_info            \
    $new_line_prompt
end
