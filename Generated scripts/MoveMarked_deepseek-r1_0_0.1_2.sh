mkdir -p /etc/movedDocs || exit 1
find /etc/docs -type f -name '*.docx.found' -print0 | while IFS= read -r -d '' found_file; do
    docx_file="${found_file%.found}"
    if [[ -f "$docx_file" ]]; then
        relative_path="${found_file#/etc/docs/}"
        target_dir="/etc/movedDocs/${relative_path%/*}"
        if mkdir -p "$target_dir"; then
            if mv -v -- "$found_file" "$docx_file" "$target_dir/"; then
                echo "Moved: $found_file and $docx_file to $target_dir"
            else
                echo "Error moving files: $found_file and $docx_file" >&2
            fi
        else
            echo "Error creating directory: $target_dir" >&2
        fi
    else
        echo "No matching .docx for: $found_file" >&2
    fi
done