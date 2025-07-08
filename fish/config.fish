if status is-interactive
    set -U fish_greeting ""
    set -x VISUAL nvim
    set -x EDITOR nvim
    set -x FZF_DEFAULT_COMMAND "fd --type f"
    set -x FZF_DEFAULT_OPTS "--preview 'bat --color=always {}'"
    set -a PATH /home/yohansh/.cargo/bin
    set fzf_preview_dir_cmd eza --all --color=always
    set fzf_fd_opts --hidden --max-depth 5
    set fzf_directory_opts --bind "ctrl-o:execute($EDITOR {} &> /dev/tty)"

    set -x OPENROUTER_API_KEY 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

    alias r ranger
    alias g git
    alias t ts-node 
    alias n node 
    alias t touch
    alias r "rescan & rofi-wifi-menu.sh"
    alias rescan "nmcli device wifi rescan"
    alias fr "python ~/projects/focus_read/main.py"
    alias v "nvim"
    alias nv "neovide & disown"
    alias l "ls -a"
    alias floey "tmuxifier load-session floey"
    alias owlbox "tmuxifier load-session owlbox"
    alias skill "tmuxifier load-session skill-sync"
    alias tn "python /home/yohansh/.config/fish/scripts/take_note.py"
    alias gdnv 'neovide $(git diff main --name-only) & disown'

    alias vd 'DELTA_FEATURES=+side-by-side git diff'
end

eval (tmuxifier init - fish)
# Set up fzf key bindings
fzf --fish | source

source ~/.config/fish/zoxide.fish
starship init fish | source

__auto_git_fetch
