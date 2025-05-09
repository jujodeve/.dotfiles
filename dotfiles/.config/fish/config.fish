#
# config.fish
#

if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -g -x EDITOR nvim
set -g -x VISUAL nvim
set -g -x SYSTEMD_EDITOR nvim
set -g -x GOPATH ~/go

## PATH
fish_add_path -g /home/jotix/.scripts

### exa/ls aliases
alias ls 'ls --color=auto'
alias grep 'grep --color=auto'
alias exa 'exa --icons'
alias la 'exa -lha'
alias l la
alias ll 'exa -l'
alias ls exa
alias lt 'exa --tree'

### bat alias
alias cat bat

### git root folder
alias gitroot 'cd $(git rev-parse --show-toplevel)'
alias gr gitroot

### cd dotfiles
alias cdc 'cd ~/.dotfiles'

### neovim
alias vim nvim
alias vi nvim

### zed
alias zed zeditor

### other aliases
alias google_drive_upload "rclone copy ~/Documents jujodeve:"
alias gdu google_drive_upload
alias activate-venv 'source venv/bin/activate.fish'

### enable vi mode
fish_vi_key_bindings

fastfetch
