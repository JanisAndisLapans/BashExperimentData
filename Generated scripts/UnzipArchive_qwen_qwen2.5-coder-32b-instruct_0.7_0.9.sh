for file in archive.*; do
    case $file in
        *.zip)
            unzip "$file"
            ;;
        *.tar.gz|*.tgz)
            tar -xzf "$file"
            ;;
        *.tar.bz2|*.tbz2)
            tar -xjf "$file"
            ;;
        *.tar.xz)
            tar -xJf "$file"
            ;;
        *)
            echo "Unsupported archive format: $file"
            ;;
    esac
done