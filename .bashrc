# .bashrc

# use vi keybindings in bash
set -o vi

platform=`uname`

alias vi="vim"
alias e="vim"
alias vs="vim -O"

alias g="git"
alias gg="git graph"
alias h="hg"

alias lsa="ls -a"
alias lsl="ls -l"
alias lsla="ls -la"
alias lslh="ls -lh"

alias ..="cd .."
alias ...="cd ../.."
alias cdp="cd -P"

alias ci="echo 'did you mean vi?'"

alias yrf="yarn run flow"

alias hgslautorefresh="autorefresh 'hg sl --color always --all 2>&1' 'shasum .hg/dirstate .hg/bookmarks .hg/bookmarks.current .hg/remotenames 2>&1'"

if [ $platform == 'Linux' ]; then
   alias gopen="xdg-open"
fi

alias grep='grep --color=auto'
alias psgrep='ps -ef | grep'

alias autorefresh-git="autorefresh 'git go --color=always'"

alias copy="xsel -ib"

alias git-mega-clean='git clean -xfd; git submodule foreach --recursive git clean -xfd'

function findgrep
{
  find . -type f -name "$1" -exec grep -H -- "$2" {} \;
}

function forward-port() {
  if [[ -z "$1" || -z "$2" ]] ; then
    echo "Usage:"
    echo "  forward-port remote-user-and-address port"
    return 1
  fi
  # Will use the same port number for the remote and local port
  ssh -N -L "$2:localhost:$2" "$1"
}

function mount-luks() {
  if [[ -z "$1" || -z "$2" || -z "$3" ]] ; then
    echo "Usage:"
    echo "  mount-luks partition-device luks-mapper-name mount-location"
    echo
    echo "  partition-device: e.g. /dev/sdb1"
    echo "  luks-mapper-name: some unique name, appears in /dev/mapper"
    echo "  mount-location: self-explanatory"
    return 1
  fi
  sudo cryptsetup luksOpen "$1" "$2" || return 1
  sudo mount "/dev/mapper/$2" "$3" || return 1
}

function unmount-luks() {
  if [[ -z "$1" || -z "$2" ]] ; then
    echo "Usage:"
    echo "  unmount-luks luks-mapper-name mount-location"
    echo
    echo "  luks-mapper-name: same name used when mounting, appears in /dev/mapper"
    echo "  mount-location: self-explanatory"
    return 1
  fi
  sudo umount "$2" || return 1
  sudo cryptsetup luksClose "/dev/mapper/$1" || return 1
}

function wav-to-mp3() {
  if [[ -z "$1" || -z "$2" ]] ; then
    echo "Usage:"
    echo "  wav-to-mp3 input.wav output.mp3"
    return 1
  fi

  ffmpeg -i "$1" -vn -ac 2 -b:a 320k "$2"
}

function git-rb-stack() {
  if [[ -z "$1" || -z "$2" ]] ; then
    echo "Usage:"
    echo "  git-rb-stack dest source [source2] [source3] ..."
    return 1
  fi
  DEST=$1
  shift 1

  PREV_SRC=$DEST
  for SRC in "$@" ; do
    git checkout "$SRC"
    git rebase "$PREV_SRC"
    PREV_SRC=$SRC
  done
}

alias mtime="$(which time) -f 'real: %e s\nMax RSS (Kb): %M Kb'"

export EDITOR=vim

# weird things happen with tput if we're not in a normal terminal
tty -s && export PS1="\[$(tput bold)\]\[$(tput setaf 2)\][\u@\h \D{%H:%M:%S} \W]$ \[$(tput sgr0)\]"

export PATH=$PATH:~/dotfiles/scripts
export PATH=~/bin:$PATH

umask 027

# prevent ctrl-s, but only if we're in a normal terminal
tty -s && stty stop ''
tty -s && stty start ''
tty -s && stty -ixon
tty -s && stty -ixoff
