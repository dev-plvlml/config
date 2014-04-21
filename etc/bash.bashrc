#!/bin/bash

#
# /etc/bash.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# PS1='[\u@\h \W]\$ '
# PS2='> '
PS3='> '
PS4='+ '

set_prompt() {
    local Default='\[\e[0m\]'
    local Black='\[\e[0;30m\]'
    local Red='\[\e[0;31m\]'
    local Green='\[\e[0;32m\]'
    local Yellow='\[\e[0;33m\]'
    local Blue='\[\e[0;34m\]'
    local Magenta='\[\e[0;35m\]'
    local Cyan='\[\e[0;36m\]'
    local White='\[\e[0;37m\]'
    local BoldBlack='\[\e[1;30m\]'
    local BoldRed='\[\e[1;31m\]'
    local BoldGreen='\[\e[1;32m\]'
    local BoldYellow='\[\e[1;33m\]'
    local BoldBlue='\[\e[1;34m\]'
    local BoldMagenta='\[\e[1;35m\]'
    local BoldCyan='\[\e[1;36m\]'
    local BoldWhite='\[\e[1;37m\]'

    local Color
    local BoldColor
    if [[ $EUID != 0 ]]; then
	Color=$Green
	BoldColor=$BoldGreen
    else
	Color=$Red
	BoldColor=$BoldRed
    fi
    
    PS1="${Default}\342\224\214[${BoldColor}\u${Color}@${BoldColor}\h${Default} ${BoldBlue}\w${Default}]\n"
    PS1+="${Default}\342\224\224\342\224\200${BoldColor}\$${Default} "
    PS2="${Default}\342\224\224\342\224\200${BoldColor}>${Default} "
}

set_prompt

## Use coreutils with colorized output
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias dir='dir --color=auto'
alias dmesg='dmesg --color'
alias diff='colordiff'
alias tree='tree -C'

## Use less with source-highlight...
# export LESSOPEN="| source-highlight-esc.sh %s"

## ...or use less with lesspipe
# export LESSOPEN="| lesspipe.sh %s" # NOTE: /etc/profile.d/lesspipe.sh
export LESS=' -R '

## Use less with GNU Global tags
export LESSGLOBALTAGS=global

case ${TERM} in
  xterm*|rxvt*|Eterm|aterm|kterm|gnome*)
    PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'

    ;;
  screen)
    PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033_%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'
    ;;
esac

[ -r /usr/share/bash-completion/bash_completion   ] && . /usr/share/bash-completion/bash_completion
