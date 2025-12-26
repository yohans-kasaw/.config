if status is-interactive
    set -U fish_greeting ""
    set -x PAGER nvimpager
    set -x VISUAL nvim
    set -x EDITOR nvim

    set -gx FZF_DEFAULT_COMMAND  "fd --follow --exclude .git --exclude ~/.config/fd/fzfcd-ignore-rules . $HOME"
    set -x FZF_DEFAULT_OPTS "--tiebreak=index --style full --smart-case --preview 'bat --color=always {}'"
    set fzf_preview_dir_cmd eza --all --color=always
    set fzf_fd_opts --hidden --max-depth 5
    set fzf_directory_opts --bind "ctrl-o:execute($EDITOR {} &> /dev/tty)"
    set -x KUBECONFIG '~/.kube/config/k3s.yaml'


    fzf --fish | source
    fish_vi_key_bindings
    bind -M insert \ef 'fzfopen'
    bind -M default \ef 'fzfopen'

    alias t touch
    alias v "nvim"

    alias floey "tmuxifier load-session floey"
    alias t_fr "tmuxifier load-session t_fr"
    alias t_fota "tmuxifier load-session t_fota"
    alias libam "tmuxifier load-session libam"

    __auto_git_fetch
    starship init fish | source

    eval (~/.tmuxifier/bin/tmuxifier init - fish)

    zoxide init fish | source
end

fish_add_path "~/.tmuxifier/bin"
fish_add_path "/home/yohansh/.local/bin"
fish_add_path "/home/yohansh/.cargo/bin"
fish_add_path "/home/yohansh/go/bin"
