HISTCONTROL=ignoredups:ignorespace
HISTSIZE=1000000
HISTFILESIZE=20000000
HISTTIMEFORMAT='%F %T '

#
# Path
#
export PATH=${PATH}:$HOME/bin/
export PATH="$HOME/.rbenv/bin:$PATH"

export EDITOR=vim
export PAGER=less
export PASSWORD_STORE_DIR=$HOME/sync/.password-store

eval "$(rbenv init -)"
