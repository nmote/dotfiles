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

alias hgslautorefresh="autorefresh 'hg sl --color always --all 2>&1' 'shasum .hg/dirstate .hg/bookmarks .hg/bookmarks.current .hg/remotenames 2>&1'"

if [ $platform == 'Linux' ]; then
   alias gopen="xdg-open"
fi

alias grep='grep --color=auto'
alias psgrep='ps -ef | grep'

function findgrep
{
  find . -type f -name "$1" -exec grep -H "$2" {} \;
}

export EDITOR=vim

# weird things happen with tput if we're not in a normal terminal
tty -s && export PS1="\[$(tput bold)\]\[$(tput setaf 2)\][\u@\h \D{%H:%M:%S} \W]$ \[$(tput sgr0)\]"

export PATH=$PATH:~/settings/scripts
export PATH=~/bin:$PATH

umask 027

# prevent ctrl-s, but only if we're in a normal terminal
tty -s && stty stop ''
tty -s && stty start ''
tty -s && stty -ixon
tty -s && stty -ixoff
