# .bash_profile

# Get the aliases and functions
#if [ -f ~/.bashrc ]; then
#	. ~/.bashrc
#fi

# User specific environment and startup programs

PATH=$PATH:$HOME/bin
PYTHONPATH=$HOME:$HOME/hacking

export PATH
export PYTHONPATH

# Load RVM function
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Fancy git
## Mac
if [ -f /usr/local/git/contrib/completion/git-completion.bash ]; then
    source /usr/local/git/contrib/completion/git-completion.bash
else
# Linux
    if [ -f /etc/bash_completion.d/git ]; then
        source /etc/bash_completion.d/git
    else
        echo "Booo!"
    fi
fi

GIT_PS1_SHOWDIRTYSTATE=true
export PS1='[\u@\W$(__git_ps1 " (%s)")]\$ '
#export PS1='[\u@\h \w$(__git_ps1)]\$ '
