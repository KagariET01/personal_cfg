# 自動啟動 tmux 並附加到預設會話
tmux new-session
# tmux attach-session -t default || tmux new-session -s default
# if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
#   tmux attach-session -t default || tmux new-session -s default
# fi

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
	*i*) ;;
	  *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
	debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
	xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
	if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
	else
	color_prompt=
	fi
fi

if [ "$color_prompt" = yes ]; then
	PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
	PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
	PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
	;;
*)
	;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
	#alias dir='dir --color=auto'
	#alias vdir='vdir --color=auto'

	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
	. /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
  fi
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion



# ===========================COSTOM========================
echo "====================================="
echo ""
echo "歡迎回來 ${USER}！"


ET01_NUMB_COLOR=$(tput setaf 15 bold)
ET01_LINE_COLOR=$(tput setaf 123 bold)
ET01_HOST_COLOR=$(tput setaf 10 bold)
ET01_PATH_COLOR=$(tput setaf  4 bold)
ET01_USER_COLOR=$(tput setaf 14 bold)
ET01_RESET_COLOR=$(tput sgr0)
ET01_SUCCESS_COLOR=$(tput setaf 46 bold)
ET01_FAIL_COLOR=$(tput setaf 196 bold)
ET01_TIME_COLOR=$(tput setaf 51 bold)
# ET01_FAIL_COLOR=$(tput setaf 201 bold)
# ET01_SUCCESS_COLOR=$(tput setaf 51 bold)

ET01_STATUS=""

if [ $(id -u) -eq 0 ];then # you are root, set red colour prompt
	ET01_LINE_COLOR=$(tput setaf  9 bold)
	ET01_USER_COLOR=$(tput setaf  9 bold)
elif [ $(id -u) -eq 131 ]; then # PostgreSQL 
	ET01_LINE_COLOR=$(tput setaf  3 bold)
	ET01_USER_COLOR=$(tput setaf  3 bold)
fi

ET01_RESET_COLOR=$(tput sgr0)

build_PS1(){
	PS1_1="\n"
	PS1_2="$ET01_LINE_COLOR""┏╸""$ET01_STATUS""$ET01_NUMB_COLOR""\#\n" # command number
	# PS1_3="$ET01_LINE_COLOR""┣╸""$ET01_NUMB_COLOR""\#\n"
	PS1_3="$ET01_LINE_COLOR""┣╸""$ET01_TIME_COLOR"$(date +"%Y-%m-%d %H:%M:%S")"\n" # time
	PS1_4="$ET01_LINE_COLOR""┣╸""$ET01_HOST_COLOR""\u@\h\n" # user@host
	PS1_5="$ET01_LINE_COLOR""┣╸""$ET01_PATH_COLOR""\w\n" # path
	PS1_6="$ET01_LINE_COLOR""┗╸""$ET01_USER_COLOR""[\u] ""$ET01_RESET_COLOR" # [user] command

	PS1="$PS1_1$PS1_2$PS1_3$PS1_4$PS1_5$PS1_6"
}
build_PS1

get_status(){
	if [ $? -eq 0 ];then
		ET01_STATUS="$ET01_SUCCESS_COLOR""● "
	else
		ET01_STATUS="$ET01_FAIL_COLOR""● "
	fi
}
PROMPT_COMMAND="get_status;build_PS1"

PS2="\033[A$ET01_LINE_COLOR""┣╸\n┗╸""$ET01_RESET_COLOR"
PS0="\n"

# PROMPT_COMMAND="if $?;then echo -e \"\x1b[38;5;46m●"$ET01_RESET_COLOR"\";else echo -e \"\x1b[38;5;196m●"$ET01_RESET_COLOR"\";fi;echo \"exit code: $?\""

# DISPLAY=localhost:10.0


