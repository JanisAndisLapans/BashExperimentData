for file in archive.*; do
  case "$file" in
    *.zip) unzip "$file" ;;
    *.gz) gunzip "$file" ;;
    *.bz2) bunzip2 "$file" ;;
    *.xz) unxz "$file" ;;
    *.lzma) unlzma "$file" ;;
    *.7z) 7z x "$file" ;;
    *.tar) tar -xf "$file" ;;
    *.tar.gz) tar -xzf "$file" ;;
    *.tar.bz2) tar -xjf "$file" ;;
    *.tar.xz) tar -xJf "$file" ;;
    *.tar.lzma) tar --lzma -xf "$file" ;;
    *) echo "Unknown archive type: $file" ;;
  esac
done