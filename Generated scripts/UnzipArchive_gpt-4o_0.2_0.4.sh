for file in archive.*; do
    case "$file" in
        *.tar.bz2)   tar xjf "$file"   ;;
        *.tar.gz)    tar xzf "$file"   ;;
        *.tar.xz)    tar xJf "$file"   ;;
        *.bz2)       bunzip2 "$file"   ;;
        *.rar)       unrar x "$file"   ;;
        *.gz)        gunzip "$file"    ;;
        *.tar)       tar xf "$file"    ;;
        *.tbz2)      tar xjf "$file"   ;;
        *.tgz)       tar xzf "$file"   ;;
        *.zip)       unzip "$file"     ;;
        *.Z)         uncompress "$file";;
        *.7z)        7z x "$file"      ;;
        *.xz)        unxz "$file"      ;;
        *)           echo "Cannot extract '$file'" ;;
    esac
done