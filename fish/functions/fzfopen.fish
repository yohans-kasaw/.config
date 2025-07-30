function fzfopen
    set -l selected_path (fzf)
    if test -n "$selected_path"
        if test -d "$selected_path"
            cd "$selected_path"
        else
            set -l file_dir (dirname "$selected_path")
            set -l file_name (basename "$selected_path")
            cd "$file_dir"
            nvim "$file_name"
        end
    end
end
