################################################################################
# EXPORTS
################################################################################

export HOMEBREW_NO_AUTO_UPDATE=1

# twilio autocomplete setup
TWILIO_AC_ZSH_SETUP_PATH=/Users/jaye.heffernan/.twilio-cli/autocomplete/zsh_setup && test -f $TWILIO_AC_ZSH_SETUP_PATH && source $TWILIO_AC_ZSH_SETUP_PATH;

BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

export NVM_DIR="$HOME/.nvm"
export PATH="$PATH:$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/jaye.heffernan/.scripts:/Users/jaye.heffernan/Library/Python/3.7/bin:/Users/jaye.heffernan/.cargo/bin"

export RIPGREP_CONFIG_PATH=~/.ripgreprc
export FZF_DEFAULT_COMMAND='rg --files'
source ~/.config/base16-fzf/bash/base16-material.config
export EDITOR='nvim'

################################################################################
# ALIASES
################################################################################

alias vim='nvim'

# Typos
alias gi="git"
alias g="git"
alias suod=sudo
alias sduo=sudo

alias mux=tmuxinator
export DISABLE_AUTO_TITLE=true

alias l='ls -lFh'     #size,show type,human readable
alias la='ls -lAFh'   #long list,show almost all,show type,human readable
alias ll='ls -l'      #long list

# Docker alias and options
export COMPOSE_HTTP_TIMEOUT=300
alias d="docker"
alias dc="docker-compose"
alias dp="sh -c 'docker ps -a --format "'"table {{.Names}}\t{{.Command}}\t{{.Status}}"'" | tail -n +2 | sort'"
alias dr="docker restart"
alias dcr="docker-compose restart"

# Make/build/run common things
make-it() {
if [ -x build ]; then
    ./build
elif [ -f Makefile ]; then
    make
elif [ -f Cargo.toml ]; then
    cargo run
else
    echo can\'t build;
    return 1;
fi
}
alias b=make-it
alias m=make-it

# Regular cd with fallback to autojump
function change_dir() {
    DIR="$1"
    cd "$DIR" 2> /dev/null
    if [ $? != "0" ]
    then
        j "$DIR"
    fi
}
alias cd=change_dir

# Moving and copying with FZF
function fzf_exec_from_to() {
  CMD="$1"
  FLAGS="$2"
  MOVE_FROM="$3"
  MOVE_TO="$4"
  mkdir -p "$MOVE_TO"
  if [ -z "$FLAGS" ]; then
    find "$MOVE_FROM" | fzf  -m --height 40% --layout=reverse | xargs -I {} "$CMD" {} "$MOVE_TO"
  else
    find "$MOVE_FROM" | fzf  -m --height 40% --layout=reverse | xargs -I {} "$CMD" "$FLAGS" {} "$MOVE_TO"
  fi
}
function fzf_move() {
  fzf_exec_from_to mv "" "$1" "$2"
}
function fzf_copy() {
  fzf_exec_from_to cp "-R" "$1" "$2"
}
function fzf_move_in() {
  fzf_exec_from_to mv "" ~/Downloads .
}
function fzf_copy_in() {
  fzf_exec_from_to cp "-R" ~/Downloads .
}
function fzf_move_out() {
  fzf_exec_from_to mv "" . ~/outbox
}
function fzf_copy_out() {
  fzf_exec_from_to cp "-R" . ~/outbox
}
alias fmv=fzf_move
alias fcp=fzf_copy
alias fmvin=fzf_move_in
alias fcpin=fzf_copy_in
alias fmvout=fzf_move_out
alias fcpout=fzf_copy_out

# History searching stuff
export HISTORY_SUBSTRING_SEARCH_FUZZY=1
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
export HISTORY_SUBSTRING_SEARCH_FUZZY=1
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey '^[[A' up-line-or-beginning-search # Up
bindkey '^[[B' down-line-or-beginning-search # Down
bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down

################################################################################
# PLUGIN MANAGER
################################################################################

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

################################################################################
# PLUGINS
################################################################################

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk

setopt promptsubst
PS1="❯ " # provide a simple prompt till the theme loads

zinit wait lucid light-mode for \
    OMZL::git.zsh \
    atload"unalias grv" \
    OMZP::git

zinit wait lucid light-mode for \
    OMZP::colored-man-pages \
    OMZP::fancy-ctrl-z \
    OMZP::history \
    OMZP::autojump \
    OMZP::aws \
    OMZP::nvm \
    OMZP::yarn \
    OMZP::docker/_docker \
    zsh-users/zsh-history-substring-search \
    atload" bindkey '^P' history-substring-search-up; bindkey '^N' history-substring-search-down; " \
    OMZP::vi-mode \
    atinit"zicompinit; zicdreplay" \
    zdharma/fast-syntax-highlighting \
    atload"_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions \
    blockf atpull'zinit creinstall -q .' \
    zsh-users/zsh-completions

zinit wait'!0' lucid light-mode for \
    pick"async.zsh" src"pure.zsh" \
    sindresorhus/pure
