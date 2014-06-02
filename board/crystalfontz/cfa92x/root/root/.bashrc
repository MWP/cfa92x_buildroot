# If not running interactively, don't do anything
[ -z "$PS1" ] && return

HISTCONTROL=$HISTCONTROL${HISTCONTROL+:}ignoredups
HISTCONTROL=ignoreboth
shopt -s histappend
shopt -s checkwinsize

PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\[\033[01;36m\]\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
	. /etc/bash_completion
fi

export HTTP_PROXY='http://192.168.1.1:3128'
export HTTPS_PROXY='http://192.168.1.1:3128'
		
export LANG=en_AU
export LC_ALL=C

export LS_OPTIONS='--color=auto'
alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -lash'
alias l='ls $LS_OPTIONS -lA'
alias du='du -h'
alias df='df -h'
alias vi='vim -p'
alias rm='rm -v'
alias cp='cp -v'
alias mv='mv -v'
export GREP_OPTIONS='--color=auto'

