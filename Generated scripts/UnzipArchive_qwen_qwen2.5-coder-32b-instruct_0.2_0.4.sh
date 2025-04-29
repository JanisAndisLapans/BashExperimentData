for file in archive.*; do
    case $file in
        *.zip)
            unzip "$file"
            ;;
        *.tar.gz|*.tgz)
            tar -xzvf "$file"
            ;;
        *.tar.bz2|*.tbz2)
            tar -xjvf "$file"
            ;;
        *.tar.xz)
            tar -xJvf "$file"
            ;;
        *)
            echo "Unsupported archive format: $file"
            ;;
    esac
done