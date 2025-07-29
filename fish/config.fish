if status is-interactive
    set -U fish_greeting ""
    set -x VISUAL nvim
    set -x EDITOR nvim

    set -x FZF_DEFAULT_COMMAND "fd --type f"
    set -x FZF_DEFAULT_OPTS "--style full --preview 'bat --color=always {}'"
    set fzf_preview_dir_cmd eza --all --color=always
    set fzf_fd_opts --hidden --max-depth 5
    set fzf_directory_opts --bind "ctrl-o:execute($EDITOR {} &> /dev/tty)"

    alias t touch
    alias v "nvim"

    alias floey "tmuxifier load-session floey"
    alias owlbox "tmuxifier load-session owlbox"
    alias skill "tmuxifier load-session skill-sync"
end

starship init fish | source
fzf --fish | source
eval (tmuxifier init - fish)

fish_add_path "/home/yohansh/.local/bin"
fish_add_path "/home/yohansh/.cargo/bin"

__auto_git_fetch
