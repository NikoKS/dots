# Compilation of function that check and install packages

###
# Inspired by: https://github.com/atomantic/dotfiles/blob/master/lib_sh/requires.sh
###

function require_brew() {
    running "brew $1 $2"
    brew list $1 > /dev/null 2>&1
    if [[ $? != 0 ]]; then
        action "brew install $1 $2"
        brew install $1 $2
        if [[ $? != 0 ]]; then
            error "failed to install $1! aborting..."
            # exit -1
        fi
    fi
    ok
}

function require_cask() {
    running "brew cask $1"
    brew list --cask $1 > /dev/null 2>&1
    if [[ $? != 0 ]]; then
        action "brew install --cask $1 $2"
        brew install --cask $1
        if [[ $? != 0 ]]; then
            error "failed to install $1! aborting..."
            # exit -1
        fi
    fi
    ok
}

function require_apt() {
    running "apt $1"
    apt list --installed $1 2> /dev/null | grep $1 > /dev/null
    if [[ $? != 0 ]]; then
        action "sudo apt install -y $1"
        sudo apt install $1
        if [[ $? != 0 ]]; then
            error "failed to install $1! aborting..."
            # exit -1
        fi
    fi
    ok
}

function apt_or_brew() {
    if [[ `uname -s` = 'Darwin' ]]; then
        require_brew $1 $2
    elif [[ `uname -s` = 'Linux' ]]; then
        require_apt $1 $2
    fi
}

function require_pip() {
    running "pip $1"
    pip show $1 > /dev/null 2>&1
    if [[ $? != 0 ]]; then
        action "pip install $1"
        python -m pip install $1
        if [[ $? != 0 ]]; then
            error "failed to install $1! aborting..."
            # exit -1
        fi
    fi
    ok
}
