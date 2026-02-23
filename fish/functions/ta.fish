function ta --description 'Attach to existing tmux session or create new one'
    # Check if a session exists
    if tmux has-session 2>/dev/null
        # If we are already inside tmux, don't try to nest (usually a mess)
        if set -q TMUX
            echo "Already inside a tmux session!"
        else
            tmux attach
        end
    else
        tmux new-session -s "default"
    end
end
