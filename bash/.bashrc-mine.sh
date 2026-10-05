alias ll='ls -alFh'
alias l.='ls -d .*'
alias ..='cd ..'

alias duh='du -h -d 1'

alias py=python

sv() {  # source venv
    if [ -f ".venv/bin/activate" ]; then
        source .venv/bin/activate
    elif [ -f "venv/bin/activate" ]; then
        source venv/bin/activate
    else
        echo "no venv/ nor .venv/ found"
    fi
}

alias hg='history | grep'

[ command --version nvim > /dev/null ] && alias nv=nvim
