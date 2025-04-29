for file in archive.*; do
  case "$file" in
    *.zip) unzip "$file" ;;
    *.gz) tar -xvf "$file" ;;
    *.bz2) tar -xvf "$file" ;;
    *.xz) tar -xvf "$file" ;;
    *.lzma) tar --lzma -xvf "$file" ;;
    *.7z) 7z x "$file" ;;
    *.tar) tar -xvf "$file" ;;
    *) echo "Unknown archive type: $file" ;;
  esac
done