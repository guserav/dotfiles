alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# Show git status per default
set -g _show_git_status "show"

# show only 6 dirs in full length
set -q showDirs
if test $status -ne 0
    set -x showDirs 6
end

# Allow easy mount of shared folders in vm
alias mountVM="vmhgfs-fuse /mnt -o umask=22"

# Ensure rm is asking before deleting large files
alias rm="rm -I"
source ~/.profile

# Proxy stuff
# Enable corp proxy
alias useCorpPoxy="sudo systemctl stop noproxy.service; and sudo systemctl start corpproxy.service"
# no proxy
alias useNoProxy="sudo systemctl stop corpproxy.service; and sudo systemctl start noproxy.service"

# Set proper TERM varibale as this seems to brake a lot...
function ssh
    TERM=screen-256color command ssh $argv
end

# Run nix-shell with fish as shell
function ns
  nix-shell --run fish $argv
end

# rebuild cscope and ctags in the current directory
function rebuild-cscope
  if test -f ./cscope.files
   echo "Warning: rebuilding ./cscope.files"
    rm -f ./cscope.files
  end
  find . ! -type l -and \( -name "*.h" -o -name "*.c" -o -name "*.cc" -o -name "*.cc" -o -name "*.cpp" \) > cscope.files
  cscope -Rbkq -i cscope.files
  ctags -R *
end


# Should display a smooth gradient of colors from red over green to blue
# If your terminal doesn't support 16mil colors but only 256 the gradient isn't smooth
# If it's not a gradient at all, your terminal is broken
function check-colors
  awk 'BEGIN{
      s="aaaaaaaaaaaaaaaaa"; s=s s s s s s s s;
      for (colnum = 0; colnum<77; colnum++) {
        r = 255-(colnum*255/76);
        g = (colnum*510/76);
        b = (colnum*255/76);
        if (g>255) g = 510-g;
        printf "\033[48;2;%d;%d;%dm", r,g,b;
        printf "\033[38;2;%d;%d;%dm", 255-r,255-g,255-b;
        printf "%s\033[0m", substr(s,colnum+1,1);
      }
      printf "\n";
    }'
end

function git-blame-counter --description 'Generate a nice summary of people that have commited the specified pattern'
    git grep -n $argv | perl -F':' -ape '$_=`git blame --line-porcelain -L$F[1],+1 $F[0]`;' | grep -E "^committer " | grep -oE " .*\$" | sort | uniq -c
end

function tmux-find-pane --description 'Find a tmux pane from a given PID'
    tmux list-panes -F "#{session_name}:#{window_index}.#{pane_index} #{pane_tty}" | grep (ps -h -o tty $argv)
end

# Find out how much disk space is used from the specified directory subdirectories
function disk-usage --description 'Determine disk usage of specified folder subdirs'
    sudo du --human-readable --total --one-file-system --max-depth 1 $argv 2> /dev/null
    # sudo du -h -c -x -d 1 $argv 2> /dev/null
end

function vim --description 'map vim to nvim'
    nvim $argv
end

if test -e ~/.config/fish/load_sway.fish
    source ~/.config/fish/load_sway.fish
end
