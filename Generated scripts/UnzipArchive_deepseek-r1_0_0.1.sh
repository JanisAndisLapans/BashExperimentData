shopt -s nullglob
for file in archive.*; do
    case "$file" in
        *.tar.gz|*.tgz)  tar xzf "$file" ;;
        *.tar.bz2|*.tbz2) tar xjf "$file" ;;
        *.tar.xz) tar xJf "$file" ;;
        *.zip) unzip "$file" ;;
        *.rar) unrar x "$file" ;;
        *.7z) 7z x "$file" ;;
        *.tar) tar xf "$file" ;;
        *) echo "Skipping unsupported file: $file" ;;
    esac
done
shopt -u nullglob