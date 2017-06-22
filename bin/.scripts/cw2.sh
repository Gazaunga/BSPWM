#!/usr/bin/env bash
#
# [wp] - simple X wallpaper setter with optional
# interactive mode and save/restore functionality.
#
# Copyright 2016 Armin Jenewein (@netzverweigerer on GitHub)
#
# wp is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version.
#
# wp is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with wp. If not, see <http://www.gnu.org/licenses/>.
#

# path to wallpaper directory (this is likely the only
# thing you need to change...)
dir="$HOME/Pictures/Wallpapers"

banner () {
  tput setaf 12
  echo -n "["
  tput setaf 7
  echo -n "wp"
  tput setaf 12
  echo -n "]"
  tput sgr0
  echo -n " "
}

banner

usage () {
  echo -n "[wp] Usage: "
  echo "wp [--random|--set|--get|--save|--restore|--interactive]"
}

array=($dir/*)
totalcount="${#array[@]}"

echo "Total number of wallpapers found: $totalcount"

set () {
  file="$1"
  echo "Setting: $file"
  mkdir -p $HOME/.wp
  feh --no-fehbg --bg-fill "$file" && \
  echo "$file" > /tmp/.wp.${UID}.current
}

save () {
  if [[ ! -f /tmp/.wp.${UID}.current ]]; then
    echo "Error: /tmp/.wp.${UID}.current does not exist. Exiting."
    exit 1
  else
    echo -n "Saving wallpaper selection: "
    cat /tmp/.wp.${UID}.current > $HOME/.wp.current && f="$(cat $HOME/.wp.current)"; echo -n "$f "
    echo
  fi
}

restore () {
  echo "Restoring last set wallpaper... "
  if [[ -f $HOME/.wp.current ]]; then
    wp="$(head -n 1 $HOME/.wp.current)"
    set "$wp" || echo "Error: could not set wallpaper: $wp - exiting..."
    exit 1
  else
    echo "Error: could not re-store: $HOME/.wp.current does not exist - exiting..."
    exit 1
  fi
}

get () {
  cat $HOME/.wp.current
}

random () {
  if [[ "$(uname)" == FreeBSD ]]; then
    randomindex="$(shuffle -p 1 $(seq 1 ${totalcount}))"
   echo "Using random index: $randomindex"
  else
    randomindex="$(shuf -i 1-${totalcount} -n 1)"
   echo "Using random index: $randomindex"
  fi
	randomindex=$((randomindex-1))
	file=${array[$randomindex]}
  set "$file"
}

handler () {
  read -s -n 1 reply
  case "$reply" in
    n)
      random
    ;;
    s)
      save
    ;;
    q)
      echo "Bye..."
      exit 0
    ;;
  esac
}

interactive () {
  echo "Keys: [n]ext [s]ave [q]uit"
  while true; do
    handler
  done
}

case "$1" in
  --set)
    shift
    set "$1"
    save
  ;;
  --get)
    get
  ;;
  --random)
    random
  ;;
  --save)
    save 
  ;;
  --restore)
    restore 
  ;;
  --interactive)
    interactive
  ;;
  *)
    usage
  ;;
esac

