for file in archive.*; do
  case "${file##*.}" in
    zip) unzip "$file" ;;
    tar) tar -xvf "$file" ;;
    gz)  tar -xzvf "$file" ;;
    bz2) tar -xjvf "$file" ;;
    xz)  tar -xJvf "$file" ;;
    7z)  7z x "$file" ;;
    rar) unrar x "$file" ;;
    *) echo "Unsupported archive type: $file" ;;
  esac
done