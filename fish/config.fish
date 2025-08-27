if status is-interactive
    set -U fish_greeting ""
    set -x VISUAL nvim
    set -x EDITOR nvim

    set -gx FZF_DEFAULT_COMMAND  "fd --follow --exclude .git --exclude ~/.config/fd/fzfcd-ignore-rules . $HOME"
    set -x FZF_DEFAULT_OPTS "--tiebreak=index --style full --smart-case --preview 'bat --color=always {}'"
    set fzf_preview_dir_cmd eza --all --color=always
    set fzf_fd_opts --hidden --max-depth 5
    set fzf_directory_opts --bind "ctrl-o:execute($EDITOR {} &> /dev/tty)"
    fzf --fish | source
    fish_vi_key_bindings
    bind -M insert \ef 'fzfopen'
    bind -M default \ef 'fzfopen'

    alias t touch
    alias v "nvim"

    alias floey "tmuxifier load-session floey"
    alias focus "pomodoro start --duration 30 --wait && kitty @ focus-window"
    alias regroup "pomodoro break 5 --wait && kitty @ focus-window"

    __auto_git_fetch
    starship init fish | source

    eval (~/.tmuxifier/bin/tmuxifier init - fish)

    zoxide init fish | source
end

fish_add_path "~/.tmuxifier/bin"
fish_add_path "/home/yohansh/.local/bin"
fish_add_path "/home/yohansh/.cargo/bin"
fish_add_path "/home/yohansh/go/bin"
