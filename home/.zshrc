source ~/antigen.zsh

# Export go path (for go get)
export GOPATH=~/.go

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle pip
antigen bundle docker
antigen bundle docker-compose
antigen bundle tmuxinator
antigen bundle aws
antigen bundle autojump
antigen bundle brew
# antigen bundle common-aliases
antigen bundle git-flow
antigen bundle npm
antigen bundle osx
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle sudo
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-history-substring-search

# Load the theme.
antigen theme robbyrussell

# Tell antigen that you're done.
antigen apply

bindkey '' history-substring-search-up
bindkey '' history-substring-search-down

# User configuration
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/jaye/.scripts"
export EDITOR='vim'

alias gi="git"
alias g="git"
alias suod=sudo
alias sduo=sudo
alias dp="sh -c 'docker ps -a --format "'"table {{.Names}}\t{{.Command}}\t{{.Status}}"'" | tail -n +2 | sort'"
alias dr="docker restart"
alias watch='watch '

function change_dir() {
    DIR=$1
    cd $DIR 2> /dev/null
    if [ $? != "0" ]
    then
        j $DIR
    fi
}

alias cd=change_dir

alias mux=tmuxinator
export DISABLE_AUTO_TITLE=true

export PROMPT='${ret_status}%T%{$fg_bold[green]%}%p %{$fg[cyan]%}%c %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}'
