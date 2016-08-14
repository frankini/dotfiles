#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

#
# Aliases
#
alias ll='ls -l'
alias la='ls -la'

alias du='du -kh'    # Makes a more readable output.
alias df='df -kTh'

alias sprunge="curl -F 'sprunge=<-' http://sprunge.us"
