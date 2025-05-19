function __auto_git_fetch --on-variable PWD
    # Check if this is a git repository
    if test -d .git
        set -l fetch_head ".git/FETCH_HEAD"
        if test -f $fetch_head
            set -l last_fetch (stat -c %Y .git/FETCH_HEAD 2>/dev/null; or stat -f %m .git/FETCH_HEAD 2>/dev/null; or echo 0)
            set -l current_time (date +%s)
            set -l time_diff (math $current_time - $last_fetch)

            # If more than 30 minutes have passed
            if test $time_diff -gt 1800
                git fetch --quiet &
            end
        else
            # If FETCH_HEAD doesn't exist, do an initial fetch
            git fetch --quiet &
        end
    end
end
