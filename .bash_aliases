#!/bin/bash

# ----------------------------------------------------------------------
# ALIASES
# ----------------------------------------------------------------------

alias tmp='mkdir /tmp/$$ ; cd /tmp/$$'
alias untmp='rm -rf /tmp/$$'

alias q64='qemu-system-x86_64 --enable-kvm -m 1536'

alias hr='printf $(printf "\e[$(shuf -i 91-97 -n 1);1m%%%ds\e[0m\n" $(tput cols)) | tr " " ='

alias npr='mpv http://wamu-1.streamguys.com'

alias y='youtube-dl --no-mtime --restrict-filenames --format "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best"'

alias ix='curl -F "'"f:1=<-"'" ix.io'

alias tmux='tmux -2'

alias make="clear && make"

alias shot="scrot ~/Screenshots/`date +%y-%m-%d-%H:%M:%S`.png"

alias getip="curl -s checkip.dyndns.org | sed -e 's/.*Current IP Address: //' -e 's/<.*$//'"

alias fuck="sudo !!"

alias path='echo $PATH | tr -s ":" "\n"'

alias tree="tree -A"

alias treed="tree -d"

alias tree1="tree -d -L 1"

alias tree2="tree -d -L 2"

alias ..='cd ..'

alias ...='cd ../..'

alias ....='cd ../../..'

alias .....='cd ../../../..'

alias ......='cd ../../../../..'

alias cp='cp -r'

alias home='cd ~/'

alias scripts='cd ~/bin/.scripts'

alias mkgrub='sudo grub-mkconfig -o /boot/grub/grub.cfg'

# This makes it so it will only get to use CPU and disk whenever nothing else is using it. 
alias makepkg='chrt --idle 0 ionice -c idle makepkg'

alias timer='echo "Timer started. Stop with Ctrl-D." && date && time cat && date' # Stopwatch

alias l="ls -o -hX --group-directories-first"

alias la="ls -o -AhX --group-directories-first"

alias texupdate='tlmgr update --all'

#resolution for your system
alias res='xdpyinfo | grep resolution'

# fonts
alias fontc='fc-cache -v'

alias exe='sudo chmod +x'

# make `less` not clear the screen upon exit
alias less='less -X'

alias ex="bash ~/bin/.scripts/exit-box.sh"

alias glances="glances -w"

alias mkdir='mkdir -p -v'

alias tnethack='telnet nethack.alt.org'

