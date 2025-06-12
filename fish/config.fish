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
    set -x GOOGLE_API_KEY AIzaSyBcwwM3Hsbj-QH9nwcpw3r7DiU_6BAHn5c
    set -x ANTHROPIC_API_KEY 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

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

    alias gs 'git status'
    alias ga 'git add'
    alias gc 'git commit'
    alias gcz 'git cz'
    alias gp 'git push'
    alias gl 'git pull'
    alias gd 'git diff'
    alias gb 'git branch'
    alias gco 'git checkout'
    alias glg 'git log --oneline --graph'
    alias gr 'git reset'
    alias gf 'git fetch'
    alias gm 'git merge'
end

eval (tmuxifier init - fish)
# Set up fzf key bindings
fzf --fish | source

source ~/.config/fish/zoxide.fish
starship init fish | source

__auto_git_fetch
