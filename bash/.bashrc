#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '


# Set SSH to use gpg-agent
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
fi

#
# Aliases
#
alias ll='ls -l'
alias la='ls -la'

alias du='du -kh'    # Makes a more readable output.
alias df='df -kTh'

alias sprunge="curl -F 'sprunge=<-' http://sprunge.us"

