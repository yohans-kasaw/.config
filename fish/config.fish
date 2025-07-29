if status is-interactive
    set -U fish_greeting ""
    set -x VISUAL nvim
    set -x EDITOR nvim
    set -x FZF_DEFAULT_COMMAND "fd --type f"
    set -x FZF_DEFAULT_OPTS "--style full --preview 'bat --color=always {}'"
    set fzf_preview_dir_cmd eza --all --color=always
    set fzf_fd_opts --hidden --max-depth 5
    set fzf_directory_opts --bind "ctrl-o:execute($EDITOR {} &> /dev/tty)"

    alias r ranger
    alias t touch
    alias v "nvim"
    alias nv "neovide & disown"
    alias l "ls -a"

    alias floey "tmuxifier load-session floey"
    alias owlbox "tmuxifier load-session owlbox"
    alias skill "tmuxifier load-session skill-sync"

    alias gc "git commit -m"
    alias gd "git diff"

    function sr-mentor
      aichat -r sr-mentor "$argv" > output.md && nvim output.md
    end

    function voc-trainer
      aichat -r voc-trainer "$argv" > output.md && nvim output.md
    end

    function prompt-craft
      aichat -r prompt-craft "$argv" > output.md && nvim output.md
    end

    function cl-craft 
      aichat -r cl-craft "$argv" > output.md && nvim output.md
    end

    function explain-this 
      aichat -r explain-this "$argv" > output.md && nvim output.md
    end

    alias forge "termdown -s 30m && notify-send 'regroup'"
    alias regroup "termdown -s 5m && notify-send 'Get to work'"
end

starship init fish | source
source ~/.config/fish/zoxide.fish
fzf --fish | source
eval (tmuxifier init - fish)
__auto_git_fetch

fish_add_path "/home/yohansh/.local/bin"
fish_add_path "/home/yohansh/.cargo/bin"
