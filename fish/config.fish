if status is-interactive
    set -U fish_greeting ""
    set -x PAGER nvimpager
    set -x VISUAL nvim
    set -x EDITOR nvim
    set -x OLLAMA_KEEP_ALIVE 0
    set -x PAGER vimpager

    if not set -q GEMINI_API_KEY
        set -gx OPENCODE_API_KEY (keyring get opencode_api_key default)
        set -gx GEMINI_API_KEY (keyring get gemini_api_key default)
        set -gx GOOGLE_GENERATIVE_AI_API_KEY $GEMINI_API_KEY
        set -gx DEEPSEEK_API_KEY (keyring get DEEPSEEK_API_KEY default)
    end

    set -gx FZF_DEFAULT_COMMAND  "fd --follow --exclude .git --exclude ~/.config/fd/fzfcd-ignore-rules . $HOME"
    set -x FZF_DEFAULT_OPTS "--tiebreak=index --style full --smart-case --preview 'bat --color=always {}'"
    set fzf_preview_dir_cmd eza --all --color=always
    set fzf_fd_opts --hidden --max-depth 5
    set fzf_directory_opts --bind "ctrl-o:execute($EDITOR {} &> /dev/tty)"

    if status is-interactive
        set -gx SSH_AUTH_SOCK $XDG_RUNTIME_DIR/ssh-agent.socket
    end

    fzf --fish | source
    fish_vi_key_bindings
    bind -M insert \ef 'fzfopen'
    bind -M default \ef 'fzfopen'

    abbr t touch
    abbr v "nvim"

    abbr glog "git log --graph --oneline --decorate -10"
    abbr gp "git push"
    abbr gpl "git pull"
    abbr gst "git status -sb"

    # __auto_git_fetch
    __python_venv
    starship init fish | source

    zoxide init fish | source

    ta

end

fish_add_path "/home/yohansh/.local/bin"
fish_add_path "/home/yohansh/.cargo/bin"
fish_add_path "/home/yohansh/go/bin"
