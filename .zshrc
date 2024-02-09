eval "$(/opt/homebrew/bin/brew shellenv)"

# History settings

if [[ ! -d ~/.zsh_eternal_history ]]; then
  mkdir -p -m 700 ~/.zsh_eternal_history
fi

HISTTIMEFORMAT="[%F %T] "

#setopt APPEND_HISTORY
setopt EXTENDED_HISTORY

setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE

HISTFILESIZE=1000000000
HISTSIZE=1000000000
#HISTFILE="~/.zsh_eternal_history/.zsh_eternal_history_"`date +%Y_%V`
# following should be turned off, if sharing history via setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY

# colored ls
export CLICOLOR=1
# Aliases
alias lt='ls -latrh'
alias lc='ls -ltrp -c -h'
alias brewski='brew update && sleep 10 && brew upgrade --greedy ;brew cleanup -s; brew doctor'
alias brew_update='brew update && for name in $(brew outdated --greedy --cask --json=v2 | jq --raw-output ".casks[].name");do APP=$(brew info --json=v2 $name | jq --raw-output ".casks[].name[]");COUNT=$(ps ux | grep "$APP" | grep -v grep | wc -l);[[ $COUNT -ne 0 ]] && APPS+=(${APP});done;brewski;for APP in $APPS;do open -a "${APP}";done'
alias k='kubectl'
# Show some system info (like linuxlogo)
archey --logo-style retro
# Show birthdays
echo

~/bin/birthday -f /Users/jvhaarst/Dropbox/code/birthday/birthday/birthdays | sed $'s| in | in \t|' |column -s $'\t' -t 

# Prompt
#https://scriptingosx.com/2019/07/moving-to-zsh-06-customizing-the-zsh-prompt/

PROMPT='%(?.%F{green}√.%F{red}?%?)%f %n@%m:%~ %# '
# Git info on right
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '%F{240}(%b)%r%f'
zstyle ':vcs_info:*' enable git

# completion
if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
    autoload -Uz compinit
    compinit
fi

PATH=$PATH:${HOME}/bin
# Iterm 2
#source ~/.iterm2_shell_integration.zsh
# krew
export PATH="${PATH}:${HOME}/.krew/bin"
## wireguard fix
#export PATH="${PATH}:/opt/homebrew/bin"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/jvhaarst/opt/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/jvhaarst/opt/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/jvhaarst/opt/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/jvhaarst/opt/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# oh my posh
#eval "$(oh-my-posh --init --shell zsh --config "$(brew --prefix oh-my-posh)/themes/agnoster.omp.json")"

#cargo  path
PATH=$PATH:/Users/jvhaarst/.cargo/bin

#PATH="${PATH}:${HOME}/.krew/bin"
PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"


export PICO_SDK_PATH="/Users/jvhaarst/Google Drive/code/pico/pico-sdk"
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

export GIT_COMMITTER_NAME="Jan van Haarst"
export GIT_AUTHOR_NAME="Jan van Haarst"
export GIT_COMMITTER_EMAIL="jan.vanhaarst@wur.nl"
export GIT_AUTHOR_EMAIL="jan.vanhaarst@wur.nl"
