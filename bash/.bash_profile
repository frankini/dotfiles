# .bash_profile

HISTCONTROL=ignoredups:ignorespace
HISTSIZE=1000000
HISTFILESIZE=20000000
HISTTIMEFORMAT='%F %T '

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi


# Set SSH to use gpg-agent
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/.local/bin:$HOME/bin

export PATH
