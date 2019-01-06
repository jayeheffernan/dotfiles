# From `curl -L git.io/antigen > ~/antigen.zsh`
source $HOME/antigen.zsh
    
# Load the oh-my-zsh's library
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh)
antigen bundle git

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Fish-like auto suggestions
antigen bundle zsh-users/zsh-autosuggestions

# Extra zsh completions
antigen bundle zsh-users/zsh-completions

# My additions from the quick-start
# Just sources the file! autojump must be installed on system separately
antigen bundle autojump
antigen bundle hcgraf/zsh-sudo
antigen bundle taskwarrior

# Load the theme
antigen theme robbyrussell

# Tell antigen that you're done
antigen apply

# Export go path (for go get)
export GOPATH=~/.go
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/home/jaye/.scripts:/home/jaye/.rvm/gems/ruby-2.4.1/bin:/opt/android-sdk/platform-tools:/opt/android-sdk/tools"

export EDITOR='vim'

# Start an SSH agent
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > ~/.ssh-agent-thing
fi
if [[ "$SSH_AGENT_PID" == "" ]]; then
    eval "$(<~/.ssh-agent-thing)"
fi

if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > ~/.ssh-agent-thing
fi
if [[ "$SSH_AGENT_PID" == "" ]]; then
    eval "$(<~/.ssh-agent-vars)"
fi

# Aliases
alias pms="pacman -Ss"
alias pmi="sudo pacman -S"
alias pmu="sudo pacman -Syu"
alias pmr="sudo pacman -Rns"
alias sc="systemctl"
alias tmux="tmux -2"
alias mux=tmuxinator

alias gi="git"
alias g="git"
alias s=sudo
alias c=clear

alias R="R --quiet --no-save --no-restore"

alias mz=minizinc

alias wordfreq="tr '[A-Z]' '[a-z]' | tr -cd '[A-Za-z0-9_ \012]' | tr -s '[  ]' '\012' | sort | uniq -c | sort -nr"

# Get Conctr ips
find-ip() {
    AWS_DEFAULT_PROFILE=conctr-staging-logs aws ec2 describe-instances --query 'Reservations[*].Instances[*].[PrivateIpAddress,Tags[?Key==`Name`].Value]' --region us-west-2 --output text | perl -pe 'if ($. %2){ chomp  }else{ s/^/\t/  }' | perl -pe 's/(.*)\t(.*)/sprintf "%-26s %-18s", $2, $1/e' | sort
}

# Improved cd command with autojump
function change_dir() {
    DIR=$1
    cd $DIR 2> /dev/null
    if [ $? != "0" ]
    then
        j $DIR
    fi
}
alias cd=change_dir

export DISABLE_AUTO_TITLE=true
#export PROMPT='${ret_status}%T%{$fg_bold[green]%}%p %{$fg[cyan]%}%c %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}'
source /usr/share/nvm/init-nvm.sh

export JAVA_HOME=/usr/lib/jvm/java-8-openjdk
