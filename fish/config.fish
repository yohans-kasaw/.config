if status is-interactive
    set -U fish_greeting ""
    set -x VISUAL nvim
    set -x EDITOR nvim

    if not set -q GEMINI_API_KEY
        # set -gx OPENCODE_API_KEY (keyring get opencode_api_key default)
        # set -gx GEMINI_API_KEY (keyring get gemini_api_key default)
        # set -gx GOOGLE_GENERATIVE_AI_API_KEY $GEMINI_API_KEY
        set -gx DEEPSEEK_API_KEY (keyring get DEEPSEEK_API_KEY default)
        # set -gx OPENROUTER_API_KEY (keyring get DEEPSEEK_API_KEY default)
    end

    if status is-interactive
        set -gx SSH_AUTH_SOCK $XDG_RUNTIME_DIR/ssh-agent.socket
    end

    # start ups
    set_python_venv
    starship init fish | source
    zoxide init fish | source
    ta

end

fish_add_path "/home/yohansh/.local/bin"
fish_add_path "/home/yohansh/.cargo/bin"
fish_add_path "/home/yohansh/go/bin"
