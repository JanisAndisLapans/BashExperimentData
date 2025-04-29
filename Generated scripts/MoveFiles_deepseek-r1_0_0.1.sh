#!/bin/bash
set -eo pipefail

source_dir="$1"
dest_dir="$2"
shift 2
flags=("$@")

swap_directories() {
    local temp_dir
    temp_dir=$(mktemp -d)
    shopt -s dotglob
    mv -- "$source_dir"/* "$temp_dir/" 2>/dev/null || true
    mv -- "$dest_dir"/* "$source_dir/" 2>/dev/null || true
    mv -- "$temp_dir"/* "$dest_dir/" 2>/dev/null || true
    shopt -u dotglob
    rmdir "$temp_dir" 2>/dev/null || true
}

handle_sw() {
    if [[ " ${flags[@]} " =~ " --sw " ]]; then
        swap_directories
        exit 0
    fi
}

handle_dd() {
    if [[ " ${flags[@]} " =~ " --dd " ]]; then
        find "$dest_dir" -mindepth 1 -delete 2>/dev/null || true
    fi
}

setup_rsync_opts() {
    rsync_opts="-a"
    if [[ " ${flags[@]} " =~ " --dk " ]]; then
        rsync_opts+=" --ignore-existing"
    fi
}

handle_normal_operation() {
    setup_rsync_opts
    
    if [[ " ${flags[@]} " =~ " --sd " ]]; then
        rsync $rsync_opts --progress "$source_dir"/ "$dest_dir/"
        find "$source_dir" -mindepth 1 -delete 2>/dev/null || true
    else
        rsync $rsync_opts --progress "$source_dir"/ "$dest_dir/"
    fi
}

main() {
    handle_sw
    handle_dd
    handle_normal_operation
}

main