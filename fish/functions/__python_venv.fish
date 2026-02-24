function __python_venv --on-variable PWD
    if test -f .venv/bin/activate.fish
        source .venv/bin/activate.fish
        # Sync to tmux session environment
        tmux set-environment VIRTUAL_ENV "$VIRTUAL_ENV"

        # Create a temporary override for deactivate
        function deactivate --inherit-variable VIRTUAL_ENV
            functions -e deactivate
            source (status dirname)/../bin/activate.fish
            eval (functions deactivate | string replace 'deactivate' '_old_deactivate')

            _deactivate

            # Clean up tmux
            tmux set-environment -u VIRTUAL_ENV
            echo "Venv deactivated and tmux env cleared."
        end

        echo "Venv activated and synced to tmux."
    end
end
