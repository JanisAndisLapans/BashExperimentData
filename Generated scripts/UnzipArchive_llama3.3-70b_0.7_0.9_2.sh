for file in archive.*; do
  case "$file" in
    *.tar.gz) tar -xzf "$file" ;;
    *.tar.bz2) tar -xjf "$file" ;;
    *.tar.xz) tar -xJf "$file" ;;
    *.tar.lzma) tar --lzma -xf "$file" ;;
    *.tar) tar -xf "$file" ;;
    *.gz) gunzip "$file" ;;
    *.bz2) bunzip2 "$file" ;;
    *.xz) unxz "$file" ;;
    *.lzma) unlzma "$file" ;;
    *.zip) unzip "$file" ;;
    *.7z) 7z x "$file" ;;
    *) echo "Unknown archive type: $file" ;;
  esac
done