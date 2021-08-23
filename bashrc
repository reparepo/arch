#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
#PS1='[\u@\h \W]\$ '
PS1='\e[0;31m[\e[0;33m\u\e[0;32m@\e[0;36m\h\e[2;36m\w\e\e[0;31m]\e[0;37m\$ \e \e[0m'

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
