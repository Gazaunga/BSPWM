#!/bin/bash

# List contents after cd

function cd()
{
 builtin cd "$*" && ls
}

# Create a new directory and enter it

mkd() { mkdir $1 && cd $1; }

# Youtube Streaming

function mm() {
    mpv --no-video --ytdl-format=bestaudio ytdl://ytsearch10:"$@"
}

# Tar extraction

extract() {      # Handy Extract Program
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1     ;;
            *.tar.gz)    tar xvzf $1     ;;
            *.bz2)       bunzip2 $1      ;;
            *.rar)       unrar x $1      ;;
            *.gz)        gunzip $1       ;;
            *.tar)       tar xvf $1      ;;
            *.tbz2)      tar xvjf $1     ;;
            *.tgz)       tar xvzf $1     ;;
            *.zip)       unzip $1        ;;
            *.Z)         uncompress $1   ;;
            *.7z)        7z x $1         ;;
            *)           echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

# Create a .tar.gz archive, using `zopfli`, `pigz` or `gzip` for compression

function targz() {
	local tmpFile="${@%/}.tar";
	tar -cvf "${tmpFile}" --exclude=".DS_Store" "${@}" || return 1;

	size=$(
		stat -f"%z" "${tmpFile}" 2> /dev/null; # macOS `stat`
		stat -c"%s" "${tmpFile}" 2> /dev/null;  # GNU `stat`
	);

	local cmd="";
	if (( size < 52428800 )) && hash zopfli 2> /dev/null; then
		# the .tar file is smaller than 50 MB and Zopfli is available; use it
		cmd="zopfli";
	else
		if hash pigz 2> /dev/null; then
			cmd="pigz";
		else
			cmd="gzip";
		fi;
	fi;

	echo "Compressing .tar ($((size / 1000)) kB) using \`${cmd}\`…";
	"${cmd}" -v "${tmpFile}" || return 1;
	[ -f "${tmpFile}" ] && rm "${tmpFile}";

	zippedSize=$(
		stat -f"%z" "${tmpFile}.gz" 2> /dev/null; # macOS `stat`
		stat -c"%s" "${tmpFile}.gz" 2> /dev/null; # GNU `stat`
	);

	echo "${tmpFile}.gz ($((zippedSize / 1000)) kB) created successfully.";
}

# `s` with no arguments opens the current directory in Spacemacs, otherwise
# opens the given location

function s() {
	if [ $# -eq 0 ]; then
		subl .;
	else
		nvim "$@";
	fi;
}

# `tre` is a shorthand for `tree` with hidden files and color enabled, ignoring
# the `.git` directory, listing directories first. The output gets piped into
# `less` with options to preserve color and line numbers, unless the output is
# small enough for one screen.

function tre() {
	tree -aC -I '.git|node_modules|bower_components' --dirsfirst "$@" | less -FRNX;
}

# Exit

die() { echo $@; exit -1; }


# Stopwatch

function stopwatch(){
  case $(uname) in
    "Linux") DATE=date ;;
    "Darwin") DATE=gdate ;;
  esac
  local BEGIN=`$DATE +%s`
  while true; do
    echo -ne "$($DATE -u --date @$((`$DATE +%s` - $BEGIN)) +%H:%M:%S)\r";
  done
}

# Fuzzy cd

function cdf() {
  cd *$1*/
}

function md5() { md5sum<<<$1 | cut -f1 -d' '; }

function y2m() {
youtube-dl -t --extract-audio --audio-format mp3 "$@"
}

# This allows the use of "Transfer hello.txt" to create a unique sharing link
# files up to 10gb
transfer() { if [ $# -eq 0 ]; then echo "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"; return 1; fi 
tmpfile=$( mktemp -t transferXXX ); if tty -s; then basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g'); curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile; else curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >> $tmpfile ; fi; cat $tmpfile; rm -f $tmpfile; }

new-ruby-script()
{
    if [ -n "$1" ]; then
        local script="$1"
    else
        local script=`mktemp scriptster.rb.XXXX`
    fi

    local url="https://raw.githubusercontent.com/pazdera/scriptster/master"
    curl "$url/examples/minimal-template.rb" >"$script"
    #curl "$url/examples/documented-template.rb" >"$script"

    chmod +x "$script"
    $EDITOR "$script"
}

#This will download the minimal template from scripster’s git repo and start editing it Just drop it at the end of your ~/.bashrc or ~/.zshrc file and you’ll be able to start a script in a matter of seconds with the following command:
# new-ruby-script <file-path>

function up {
    if [[ "$#" < 1 ]]; then
        cd ..
    else
        CDSTR=""
        for i in {1..$1}; do
            CDSTR="../$CDSTR"
        done
        cd $CDSTR
    fi
}

# Rerun the last cmd and put its output into the clipboard
copy() {
  eval `history | line -s -2 | sed -r "s/[0-9]+//"` | pb;
}

# Just take the last command and put that command into the clipboard
copycmd() {
  echo `history | line -s -2 | sed -E "s/[0-9]+[ \t]+//"` | pb;
}

pb() {
  ruby -e "print STDIN.readlines.to_s.strip()" | pbcopy;
}

fileurl() {
  if [ "$1" ]
    then echo "file://$(pwd)/$1"
    else echo "file://$(pwd)"
  fi
}

# Get the full path of the current directory or the given file
path() {
  if [ "$1" ]
    then echo "$PWD/$1"
    else pwd
  fi
}

# Shortcut for `open` but no arguments opens the current directory
better_open() {
  if [ "$1" ]
    then `open "$1"`
    else `open .`
  fi
}

# Append to an Environmental Variable
addto() {
  old=`env | grep "^$1=" | sed "s/^$1=//"`
  export $1=$old:$2
}

# Merge two directories. Copying over files.
# Usage: merge dir1 dir2
# This copies everything in dir1 INTO dir2, overwriting same named files
dirmerge() {
  if [[ $# == 2 ]]; then
    dir1=$1
    dir2=$2
    echo "Merging $1 into $2"
    cp -R -v $1/* $2
  else
    echo 'usage: dirmerge dir1 dir2'
  fi
}

