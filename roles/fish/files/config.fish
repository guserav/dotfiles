alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# Stay in the folger navigated to when exiting ranger
alias ranger="ranger --choosedir=$HOME/.rangerdir; cd (cat $HOME/.rangerdir)"

# Show git status per default
set -g _show_git_status "show"

# show only 6 dirs in full length
set -g showDirs 6

# Allow easy mount of shared folders in vm
alias mountVM="vmhgfs-fuse /mnt -o umask=22"

# Ensure rm is asking before deleting large files
alias rm="rm -I"

# Proxy stuff
# Enable corp proxy
alias useCorpPoxy="sudo systemctl stop noproxy.service; and sudo systemctl start corpproxy.service"
# no proxy
alias useNoProxy="sudo systemctl stop corpproxy.service; and sudo systemctl start noproxy.service"

# Set proper TERM varibale as this seems to brake a lot...
alias ssh="env TERM=\"xterm-256color\" ssh"

# Run nix-shell with fish as shell
function ns
  nix-shell --run fish $argv
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

if test -e ~/.config/fish/xcape.config
    source ~/.config/fish/xcape.config
end
