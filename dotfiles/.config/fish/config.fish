#
# config.fish
#

if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -g -x EDITOR nvim
set -g -x VISUAL nvim
set -g -x SYSTEMD_EDITOR nvim
set -g -x PATH $PATH:~/.local/bin:~/.scripts
set -g -x GOPATH ~/go

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

### arch-config
alias cdc 'cd ~/.dotfiles'

### neovim helix
alias vim nvim
alias vi nvim

### zed
alias zed zeditor

### jotix-install
alias jotix-install ~/.dotfiles/jotix-install.sh

### dotfiles-install
alias dotfiles-install ~/.dotfiles/dotfiles-install.sh

### other aliases
alias google_drive_upload "rclone copy ~/Documents jujodeve:"
alias gdu google_drive_upload
alias activate-venv 'source venv/bin/activate.fish'

### enable vi mode
fish_vi_key_bindings

fastfetch
