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

# fzf stuff
# Make fzf use ag and ignore rubbish
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git --ignore node_modules -g ""'
# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="command find -L . -mindepth 1 \\( -path '*/\\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \\) -prune -o -type d -print 2> /dev/null | cut -b3- | ag -v node_modules | ag -v .git"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Bind ^F to what's usually ^T
bindkey '^F' fzf-file-widget
bindkey '^J' fzf-cd-widget

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
# alias watch='watch '
alias s='googler'

# Conctr find-ip clone
find-ip() {
    AWS_DEFAULT_PROFILE=conctr-staging-logs aws ec2 describe-instances --query 'Reservations[*].Instances[*].[PrivateIpAddress,Tags[?Key==`Name`].Value]' --region us-west-2 --output text | perl -pe 'if ($. %2){ chomp  }else{ s/^/\t/  }' | perl -pe 's/(.*)\t(.*)/sprintf "%-26s %-18s", $2, $1/e' | sort
}

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
