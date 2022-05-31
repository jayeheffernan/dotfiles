################################################################################
# EXPORTS
################################################################################

export HOMEBREW_NO_AUTO_UPDATE=1

# twilio autocomplete setup
TWILIO_AC_ZSH_SETUP_PATH=/Users/jaye.heffernan/.twilio-cli/autocomplete/zsh_setup && test -f $TWILIO_AC_ZSH_SETUP_PATH && source $TWILIO_AC_ZSH_SETUP_PATH;

BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

export DIRENV_LOG_FORMAT=''
eval "$(direnv hook zsh)"

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/jaye.heffernan/.scripts:/Users/jaye.heffernan/Library/Python/3.7/bin:/Users/jaye.heffernan/.cargo/bin"

export RIPGREP_CONFIG_PATH=~/.ripgreprc
source ~/.config/base16-fzf/bash/base16-material.config
export EDITOR='nvim'

export DIRSTACKSIZE=12
setopt autopushd pushdminus pushdsilent pushdtohome

export ANDROID_HOME=/Users/jaye.heffernan/Library/Android/sdk
export ANDROID_SDK_ROOT=/Users/jaye.heffernan/Library/Android/sdk
export ANDROID_AVD_HOME=/Users/jaye.heffernan/.android/avd

# History searching stuff
export HISTORY_SUBSTRING_SEARCH_FUZZY=1
HISTSIZE=10000000
SAVEHIST=10000000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
# Don't save history if command is preceded by space
setopt HIST_IGNORE_SPACE
# Write the history file in the ":start:elapsed;command" format.
setopt EXTENDED_HISTORY
# Write to the history file immediately, not when the shell exits.
setopt INC_APPEND_HISTORY

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
export HISTORY_SUBSTRING_SEARCH_FUZZY=1
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey '^[[A' up-line-or-beginning-search # Up
bindkey '^[[B' down-line-or-beginning-search # Down
bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down

FZF_DEFAULT_PREVIEW='if [ -d {1} ]; then
                      exa -alh --color=always --git {1}
                  else
                      bat --color=always --line-range :500 {1}
                  fi'

export FZF_DEFAULT_COMMAND="fd --no-ignore --hidden --type f --follow --ignore-file ~/.ignore ''"
export FZF_DEFAULT_OPTS="
--preview='""$FZF_DEFAULT_PREVIEW""'
--preview-window=:hidden
--bind '?:toggle-preview'
--bind 'ctrl-a:select-all'
--bind 'ctrl-d:deselect-all'
--bind 'ctrl-e:execute(vim {+} < /dev/tty > /dev/tty)'
--bind 'ctrl-y:execute(echo {+} | pbcopy)'
"
export FZF_CTRL_T_COMMAND='fd --no-ignore --hidden --follow --ignore-file ~/.ignore ""'
export FZF_ALT_C_COMMAND='fd --no-ignore --hidden --follow --ignore-file ~/.ignore --type d ""'

# Use fd  instead of the default find command for listing path candidates.
# The first argument to the function ($1) is the base path to start traversal
_fzf_compgen_path() {
    fd --no-ignore --hidden --follow --ignore-file ~/.ignore '' "$1"
}
_fzf_compgen_dir() {
    fd --no-ignore --hidden --follow --ignore-file ~/.ignore --type d '' "$1"
}

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
PS1="❯ " # provide a simple prompt til the theme loads

zinit wait lucid light-mode for \
    OMZL::git.zsh

bindkey '^P' history-substring-search-up; bindkey '^N' history-substring-search-down; bindkey '^R' fzf-history-widget
zinit wait lucid light-mode for \
    OMZP::colored-man-pages \
    OMZP::fancy-ctrl-z \
    OMZP::history \
    OMZP::autojump \
    OMZP::aws \
    OMZP::yarn \
    zsh-users/zsh-history-substring-search \
    OMZP::fzf \
    atload" bindkey '^R' fzf-history-widget" \
    OMZP::docker/_docker \
    OMZP::vi-mode \
    atinit"zicompinit; zicdreplay" \
    atload" bindkey '^P' history-substring-search-up; bindkey '^N' history-substring-search-down; bindkey '^R' fzf-history-widget" \
    zdharma/fast-syntax-highlighting \
    atload"_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions \
    blockf atpull'zinit creinstall -q .' \
    zsh-users/zsh-completions

zinit wait'!0' lucid light-mode for \
    pick"async.zsh" src"pure.zsh" \
    sindresorhus/pure

################################################################################
# ALIASES
################################################################################

alias vim='nvim'

# Vim unmerged Git files
alias vimm='vim $(git diff --name-status --diff-filter=U)'

# Typos
alias gi="git"
alias g="git"
alias suod=sudo
alias sduo=sudo

alias mux=tmuxinator
export DISABLE_AUTO_TITLE=true

alias ls='exa'                                                         # ls
alias l='exa -lbF --git'                                               # list, size, type, git
alias ll='exa -lbGF --git'                                             # long list
alias llm='exa -lbGF --git --sort=modified'                            # long list, modified date sort
alias la='exa -lbhHigUmuSa --time-style=long-iso --git --color-scale'  # all list
alias lx='exa -lbhHigUmuSa@ --time-style=long-iso --git --color-scale' # all + extended list

alias y='yarn'

# Docker alias and options
export COMPOSE_HTTP_TIMEOUT=300
alias d="docker"
alias dc="docker-compose"
alias dp="sh -c 'docker ps -a --format "'"table {{.Names}}\t{{.Command}}\t{{.Status}}"'" | tail -n +2 | sort'"
alias dr="docker restart"
alias dcr="docker-compose restart"

function ffmweb() {
    RES="$1"
    FILE="$2"
    ffmpeg -i "$FILE" -vcodec h264 -acodec aac -strict -2 -vf "scale=-1:$RES" -an "$FILE.$RES.mp4"
}

function ffmweba() {
    RES="$1"
    FILE="$2"
    ffmpeg -i "$FILE" -vcodec h264 -acodec aac -strict -2 -vf "scale=-1:$RES" "$FILE.$RES.mp4"
}

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

# Test common things
test-it() {
if [ -x test ]; then
    ./test
elif [ -f Cargo.toml ]; then
    cargo test
elif [ -f package.json ]; then
    if [ ! -d node_modules ]; then
        npm install
    fi
    npm test
else
    echo can\'t build;
    return 1;
fi
}
alias t=test-it

# Regular cd with fallback to autojump
function change_dir() {
    DIR="$1"

    # No argument? Autojump to tmux session name
    if [ -z "$DIR" ]
    then
        # Add main for project's ./main worktree
        j "$(tmux display-message -p '#S')" main
        return 0
    fi

    # Try to change to the directory
    cd "$DIR" 2> /dev/null

    # If cd fails, then autojump instead
    if [ $? != "0" ]
    then
        j "$@"
    fi
}
alias cd=change_dir

# Vim scratch buffers
alias dt='date +"%Y-%m-%dT%H:%M:%S%Z"'
function vim_scratch() {
  local EXT="$1"
  if [ -z "$EXT" ]; then
    vim ~/.scratch/"$(dt).scratch.txt"
  else
    vim ~/.scratch/"$(dt).scratch.$EXT"
  fi
}
function vim_scratch_latest() {
  local F
  local EXT="$1"
  if [ -z "$EXT" ]; then
    F="$(ls ~/.scratch | sort -r | head -n 1)"
  else
    F="$(ls ~/.scratch/*."$EXT" | sort -r | head -n 1)"
  fi

  if [ -f "$F" ]; then
    vim "$F"
  else
    echo "file not found" 1>&2
    return 1
  fi
}
alias vims=vim_scratch
alias vimsl=vim_scratch_latest

alias copy=pbcopy
alias paste=pbpaste

function copyappend () {
    {
        paste
        cat
    } | copy
}

function copyprepend () {
    {
        cat
        paste
    } | copy
}


# Check what's listening on different ports
function ports() {
  PORT="$1"
  if [ -z "$PORT" ]; then
    sudo lsof -nP -iTCP -sTCP:LISTEN
  else
    sudo lsof -nP -iTCP:"$PORT" -sTCP:LISTEN
  fi
}

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
alias mvf=fzf_move
alias cpf=fzf_copy
alias mvin=fzf_move_in
alias cpin=fzf_copy_in
alias mvout=fzf_move_out
alias cpout=fzf_copy_out

function git_rebase_interactive_n() {
  local N="$1"
  git rebase --interactive HEAD~"$N"
}

function git_branch() {
  git branch --color=always --sort=-committerdate "$@"
}

function fzf_git_branch() {
  # confirm we're in a repo
  git rev-parse HEAD > /dev/null 2>&1 || return

  {
    git_branch;
    git_branch --remote;
  } |
      grep -v HEAD |
      fzf --ansi --no-multi --preview-window right:50% \
          --preview 'git log -n 50 --color=always --oneline --no-decorate $(sed "s/.* //" <<< {})' |
      sed "s/.* //"
}

function fzf_git_checkout() {
    branch=$(fzf_git_branch)
    if [[ -z "$branch" ]]; then
        # echo "No branch selected."
        return
    fi

    local_version=$(git branch --list "$branch")

    if [[ -z "$local_version" ]]; then
        # Branch does not exist locally, probs selected a remote branch
        git checkout --track "$branch"
    else
        git checkout "$branch"
    fi
}

fzf_git_preview() {
      fzf --ansi \
          --multi \
          --preview 'if (git ls-files --error-unmatch {2} &>/dev/null); then
                         git diff --color=always {2}
                     else
                         bat --color=always --line-range :500 {2}
                     fi'
}

fzf_git_status_selections() {
  local filter="$1"
  local selections=$(git status --porcelain "${@:2}" | grep -e "$filter" | fzf_git_preview)
  local root="$(git rev-parse --show-toplevel)"
  if [[ -n $selections ]]; then
      echo "$selections" | cut -c 4- | sed -e 's,^,'"$root"'/,' 
  fi
}

fzf_git_add() {
    local selections=$(fzf_git_status_selections '' "$@")
    if [[ -n $selections ]]; then
        echo "$selections" | xargs git add --verbose 
    fi
}

fzf_git_add_intent() {
    local selections=$(fzf_git_status_selections '' "$@")
    if [[ -n $selections ]]; then
        echo "$selections" | xargs git add --intent-to-add --verbose
    fi
}

fzf_git_add_patch() {
    local selections=$(fzf_git_status_selections '' "$@")
    if [[ -n $selections ]]; then
        echo "$selections" | xargs -o git add --patch --verbose
    fi
}

fzf_git_unstage() {
    local selections=$(fzf_git_status_selections '^[AMD]' "$@")
    if [[ -n $selections ]]; then
        echo "$selections" | xargs git restore --staged
    fi
}

fzf_git_add_patch_redo() {
    local selections=$(fzf_git_status_selections '^[AMD]' "$@")
    if [[ -n $selections ]]; then
        echo "$selections" | xargs git restore --staged
        echo "$selections" | xargs -o git add --patch --verbose 
    fi
}

fzf_git_log() {
    local selections=$(
      git ll --color=always "$@" |
        fzf --ansi --no-sort --no-height \
            --preview "echo {} | grep -o '[a-f0-9]\{7\}' | head -1 |
                       xargs -I@ sh -c 'git show --color=always @'"
      )
    if [[ -n $selections ]]; then
        local commits=$(echo "$selections" | sed 's/^[* |]*//' | cut -d' ' -f1)
        echo "$commits" | xargs git show "$commits"
    fi
}

fzf_git_log_pickaxe() {
     if [[ $# == 0 ]]; then
         echo 'Error: search term was not provided.'
         return
     fi
     local selections=$(
       git log --oneline --color=always -S "$@" |
         fzf --ansi --no-sort --no-height \
             --preview "git show --color=always {1}"
       )
     if [[ -n $selections ]]; then
         local commits=$(echo "$selections" | cut -d' ' -f1)
         echo "$commits" | xargs git show "$commits"
     fi
 }

fzf_git_log_pickaxe_re() {
    fzf_git_log_pickaxe "$@" --pickaxe-regex
}

fzf_github_pr_select() {
    # TODO why does the preview window not show by default? Have to press "?"
    # to toggle it
    local selection=$(
      GH_FORCE_TTY='100%' gh pr list | grep --extended-regexp '#\d' |
         fzf --no-sort --no-multi --ansi \
             --preview-window right:50% \
             --preview "GH_FORCE_TTY='100%' gh pr view {+1}"
      )
    if [[ -n $selection ]]; then
        local pr=$(echo "$selection" | sed 's/^[* |]*//' | cut -d' ' -f1)
        echo "$pr"
    fi
}

fzf_github_pr_checkout() {
    local pr=$(fzf_github_pr_select)
    if [[ -n $pr ]]; then
        gh pr checkout "$pr"
    fi
}

# Git Fuzzy aliases (git combined with fzf)
alias gfl='fzf_git_log'
alias gfa='fzf_git_add'
alias gfan='fzf_git_add_intent'
alias gfap='fzf_git_add_patch'
alias gfapr='fzf_git_add_patch_redo'
alias gfrs='fzf_git_unstage'
alias gflp='fzf_git_log_pickaxe'
alias gflpr='fzf_git_log_pickaxe_re'
alias gfco='fzf_git_checkout'

alias ghfpr='fzf_github_pr_select'
alias ghfco='fzf_github_pr_checkout'

fzf_cd() {
    local selection=$(fd --no-ignore --hidden --follow --ignore-file ~/.ignore '' --type d "${1-.}" | fzf)
    if [[ -n $selection ]]; then
        cd "$selection"
    fi
}
alias cdf=fzf_cd
alias c=fzf_cd

alias gdo='git d "origin/$(git branch --show-current)" "$(git branch --show-current)"'
alias gpushup='git push --set-upstream origin "$(git branch --show-current)"'
alias gri=git_rebase_interactive_n

alias dh='dirs -v'
alias o=popd

alias focus='osascript -e '"'"'tell application "Alacritty" to activate'"'"
alias f=focus

exerrs() {
    smug start exercism track=rust exercise="$1"
}

alias exerrss='exercism submit src/lib.rs Cargo.toml **/*.rs **/Cargo.toml'
alias exerrssl='exercism submit src/lib.rs Cargo.toml Cargo.lock **/*.rs **/Cargo.toml'

alias pt=papertrail

# pspg: a pager for tabular data. 16 = "simple" theme
export PSPG='--style=16 --no-mouse --on-sigint-exit'
