################################################################################
# EXPORTS
################################################################################

export HOMEBREW_NO_AUTO_UPDATE=1

# https://github.com/antonmedv/fx/blob/master/doc/js.md
export FX_LANG=node
export NODE_PATH=`npm root -g`

# twilio autocomplete setup
TWILIO_AC_ZSH_SETUP_PATH=/Users/jaye.heffernan/.twilio-cli/autocomplete/zsh_setup && test -f $TWILIO_AC_ZSH_SETUP_PATH && source $TWILIO_AC_ZSH_SETUP_PATH;

export DIRENV_LOG_FORMAT=''

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$HOME/.builds/bin:$PATH:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/.scripts/bin:$HOME/Library/Python/3.7/bin:$HOME/.cargo/bin"

source ~/.secrets.zshrc

export RIPGREP_CONFIG_PATH=~/.ripgreprc
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
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey '^[[A' up-line-or-beginning-search # Up
bindkey '^[[B' down-line-or-beginning-search # Down
bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down

export BAT_THEME="Catppuccin-mocha"
FZF_DEFAULT_PREVIEW='if [ -d {1} ]; then
                      exa -alh --color=always --git {1}
                  else
                      bat --color=always --line-range :500 {1}
                  fi'

export FZF_DEFAULT_COMMAND="fd --no-ignore --hidden --type f --follow --ignore-file ~/.ignore ''"
export FZF_DEFAULT_OPTS="
--preview='""$FZF_DEFAULT_PREVIEW""'
--preview-window=right:50%
--layout=reverse
--bind 'ctrl-j:next-history'
--bind 'ctrl-k:prev-history'
--bind 'ctrl-n:down'
--bind 'ctrl-p:up'
--bind 'ctrl-h:toggle-preview'
--bind 'ctrl-a:select-all'
--bind 'ctrl-d:deselect-all'
--bind 'ctrl-e:execute(vim {+} < /dev/tty > /dev/tty)'
--bind 'ctrl-y:execute(echo {+} | pbcopy)'
--bind 'tab:toggle-out'
--bind 'shift-tab:toggle-in'
--history /tmp/fzf.history.txt
--color=bg+:#313244,bg:#000000,spinner:#f5e0dc,hl:#f38ba8
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8
" # NB: color lines are catppuccin theme
export FZF_CTRL_T_COMMAND='fd --no-ignore --hidden --follow --ignore-file ~/.ignore ""'
export FZF_ALT_C_COMMAND='fd --no-ignore --hidden --follow --ignore-file ~/.ignore --type d ""'

# Syntax-highlighted preview for FZF shell-history
export FZF_CTRL_R_OPTS='--preview "echo {} | sed '"'"'s/ *[0-9][0-9]*  *//'"'"' | bat -p -l zsh --color always"'

# Define an init function and append to zvm_after_init_commands
function my_init() {
  # Put this keybinding back, after Vim-mode plugin overrides it
  bindkey '^R' fzf-history-widget
}

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

source ${ZDOTDIR:-~}/.antidote/antidote.zsh
antidote load

alias plugin_reload="antidote bundle <~/.zsh_plugins.txt >~/.zsh_plugins.zsh"

# # Force using aliases
# export ZSH_PLUGINS_ALIAS_TIPS_FORCE=1
export ZSH_PLUGINS_ALIAS_TIPS_REVEAL_TEXT="Alias expanded to: "
export ZSH_PLUGINS_ALIAS_TIPS_TEXT="YSK alias: "
# export ZSH_PLUGINS_ALIAS_TIPS_REVEAL=1

zvm_after_init_commands+=(my_init)

################################################################################
# ALIASES
################################################################################

alias vim='nvim'
alias vimdiff='nvim -d'
alias vI='nvim'

# Typos
alias gi="git"
alias g="git"
alias suod=sudo
alias sduo=sudo

export DISABLE_AUTO_TITLE=true

alias ls='exa'                                                         # ls
alias l='exa -lbF --git'                                               # list, size, type, git
alias ll='exa -lbGF --git'                                             # long list
alias llm='exa -lbGF --git --sort=modified'                            # long list, modified date sort
alias la='exa -lbhHigUmuSa --time-style=long-iso --git --color-scale'  # all list
alias lx='exa -lbhHigUmuSa@ --time-style=long-iso --git --color-scale' # all + extended list

alias mk=mkdir
alias mkp='mkdir -p'

alias y='yarn'

function ocr() {
    local image_file="$1"
    # OCR to stdout
    tesseract "$image_file" -
}

# Make background of image transparent, by flood-fill based on top-corner
# e.g. `bg_rm input.jpg output.png`
function bg_rm() {
    local image_file="$1"
    local output_file="$2"
    # https://stackoverflow.com/a/44542839
    local color=$( convert "$image_file" -format "%[pixel:p{0,0}]" info:- )
    convert "$image_file" -alpha off -bordercolor "$color" -border 1 \
        \( +clone -fuzz 30% -fill none -floodfill +0+0 "$color" \
           -alpha extract -geometry 200% -blur 0x0.5 \
           -morphology erode square:1 -geometry 50% \) \
        -compose CopyOpacity -composite -shave 1 "$output_file"
}

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
alias vimb=vimbig

function strip_sql_semicolon() {
  cat \
    | tac \
    | awk 'NF {p=1} p' \
    | awk 'NR == 1 {sub(/;\s*$/, ""); print} NR != 1 {print}' \
    | tac
}

function psql_json() {
  local F="$1"
  rm -f '/tmp/psql_json.out'

  cat <(echo '\\t') \
    <(echo '\\a') \
    <(echo 'select json_agg(t) FROM (') \
    <(cat "$F" | strip_sql_semicolon) \
    <(echo ') t') \
    | psql \
    > '/tmp/psql_json.out'

  # Filter for actual JSON lines
  cat '/tmp/psql_json.out' \
    | awk '/^[[]/ { json_started = 1 } json_started { print }' \
    | jq --sort-keys '' \
    > '/tmp/psql_json.json'

  cat '/tmp/psql_json.json'
}

function psql_diff() {
  local A="$1"
  local B="$2"
  rm -f '/tmp/psql_diff.a.json' '/tmp/psql_diff.b.json'
  psql_json "$A" > '/tmp/psql_diff.a.json'
  psql_json "$B" > '/tmp/psql_diff.b.json'
  vimdiff '/tmp/psql_diff.a.json' '/tmp/psql_diff.b.json'
}

alias sqldiff=psql_diff

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
alias ghf='fzf_github_pr_checkout'

prf() {
  echo -n "./.scratch/prs/$(git rev-parse --abbrev-ref HEAD).md"
}
alias vimpr='vim "$(prf)"'
alias catpr='cat "$(prf)"'

fzf_cd() {
    local selection=$(fd --no-ignore --hidden --follow --ignore-file ~/.ignore '' --type d "${1-.}" | fzf)
    if [[ -n $selection ]]; then
        cd "$selection"
    fi
}
alias cdf=fzf_cd
alias c=fzf_cd

alias gdo='git d "origin/$(git branch --show-current)" "$(git branch --show-current)"'
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
alias cdz="cd ~/.vimwiki/notes"
alias   z="cd ~/.vimwiki/notes"

alias v="vim ."

set_wallpaper() {
  osascript -e 'tell application "System Events" to tell every desktop to set picture to "/Users/jaye.heffernan/.wallpaper.png"'
}

# pspg: a pager for tabular data. 16 = "simple" theme
export PSPG='--style=16 --no-mouse --on-sigint-exit'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
