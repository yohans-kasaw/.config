function dd
    set -l query (string join + $argv)
    w3m "https://duckduckgo.com/?q=$query"
end
