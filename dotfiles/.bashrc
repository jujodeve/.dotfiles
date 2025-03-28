#
# ~/.bashrc
#

test -s ~/.alias && . ~/.alias || true

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export EDITOR=nvim
export VISUAL=nvim
export PATH=$PATH:~/.local/bin
export GOPATH=~/go

alias ls='ls --color=auto'
alias grep='grep --color=auto'

alias exa='exa --icons'
alias la='exa -lha'
alias l=la
alias ll='exa -l'
alias ls=exa
alias lt='exa --tree'
alias gitroot='cd $(git rev-parse --show-toplevel)'
alias gr='gitroot'

### camara negocio
alias camara=/mnt/jtx-data/scripts/camara.sh

### arch-config
alias cdc='cd ~/workspace/arch-config'

### alias helix
alias vim=nvim
alias vi=nvim

function _update_ps1() {
    PS1="$($GOPATH/bin/powerline-go -error $? -jobs $(jobs -p | wc -l))"

    # Uncomment the following line to automatically clear errors after showing
    # them once. This not only clears the error for powerline-go, but also for
    # everything else you run in that shell. Don't enable this if you're not
    # sure this is what you want.

    #set "?"
}

if [ "$TERM" != "linux" ] && [ -f "$GOPATH/bin/powerline-go" ]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

fastfetch
