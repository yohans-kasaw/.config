if status is-interactive
    set -U fish_greeting ""
    set -x VISUAL nvim
    set -x EDITOR nvim

    set -gx FZF_DEFAULT_COMMAND  "fd --follow --exclude .git --exclude ~/.config/fd/fzfcd-ignore-rules . $HOME"

    set -x FZF_DEFAULT_OPTS "--tiebreak=index --style full --smart-case --preview 'bat --color=always {}'"
    set fzf_preview_dir_cmd eza --all --color=always
    set fzf_fd_opts --hidden --max-depth 5
    set fzf_directory_opts --bind "ctrl-o:execute($EDITOR {} &> /dev/tty)"


    alias t touch
    alias v "nvim"

    alias floey "tmuxifier load-session floey"
    alias owlbox "tmuxifier load-session owlbox"
    alias skill "tmuxifier load-session skill-sync"

    fzf --fish | source

    fish_vi_key_bindings

    __auto_git_fetch
    starship init fish | source
    eval (tmuxifier init - fish)

    bind -M insert \ef 'fzfopen'
    bind -M default \ef 'fzfopen'

    zoxide init fish | source
end

fish_add_path "/home/yohansh/.local/bin"
fish_add_path "/home/yohansh/.cargo/bin"
