#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Function to display usage
usage() {
    echo "Usage: $0 [OPTIONS] source_directory destination_directory"
    echo ""
    echo "Options:"
    echo "  --sc         Copy from source (default operation)"
    echo "  --sd         Move from source (delete from source after copying)"
    echo "  --dr         Replace files with the same name in destination (default)"
    echo "  --dk         Keep existing files in destination (do not overwrite)"
    echo "  --dd         Delete all existing files in destination before operation"
    echo "  --sw         Swap contents of source and destination directories"
    echo "  -h, --help   Display this help message"
    exit 1
}

# Parse options using getopt
PARSED_OPTIONS=$(getopt -o h --long sc,sd,dr,dk,dd,sw,help -- "$@")
if [[ $? -ne 0 ]]; then
    usage
fi

eval set -- "$PARSED_OPTIONS"

# Initialize flags
COPY=false
MOVE=false
REPLACE=false
KEEP=false
DELETE_DEST=false
SWAP=false

# Process options
while true; do
    case "$1" in
        --sc)
            COPY=true
            shift
            ;;
        --sd)
            MOVE=true
            shift
            ;;
        --dr)
            REPLACE=true
            shift
            ;;
        --dk)
            KEEP=true
            shift
            ;;
        --dd)
            DELETE_DEST=true
            shift
            ;;
        --sw)
            SWAP=true
            shift
            ;;
        -h|--help)
            usage
            ;;
        --)
            shift
            break
            ;;
        *)
            echo "Unknown option: $1"
            usage
            ;;
    esac
done

# Check for source and destination directories
if [ "$SWAP" = false ]; then
    if [ "$#" -ne 2 ]; then
        echo "Error: Source and destination directories are required."
        usage
    fi

    SOURCE="$1"
    DESTINATION="$2"

    if [ ! -d "$SOURCE" ]; then
        echo "Error: Source directory '$SOURCE' does not exist."
        exit 1
    fi

    if [ ! -d "$DESTINATION" ]; then
        echo "Error: Destination directory '$DESTINATION' does not exist."
        exit 1
    fi
else
    if [ "$#" -ne 2 ]; then
        echo "Error: Source and destination directories are required for swapping."
        usage
    fi

    SOURCE="$1"
    DESTINATION="$2"

    if [ ! -d "$SOURCE" ]; then
        echo "Error: Source directory '$SOURCE' does not exist."
        exit 1
    fi

    if [ ! -d "$DESTINATION" ]; then
        echo "Error: Destination directory '$DESTINATION' does not exist."
        exit 1
    fi
fi

# Perform swap if --sw is specified
if [ "$SWAP" = true ]; then
    TEMP="/tmp/swap_temp_$$"
    mkdir -p "$TEMP"
    mv "$SOURCE"/* "$TEMP/"
    mv "$DESTINATION"/* "$SOURCE/"
    mv "$TEMP"/* "$DESTINATION/"
    rmdir "$TEMP"
    echo "Swapped contents of '$SOURCE' and '$DESTINATION'."
    exit 0
fi

# Determine operation mode
if [ "$MOVE" = true ]; then
    OPERATION="move"
else
    OPERATION="copy"
    COPY=true
fi

# Handle destination overwrite options
if [ "$DELETE_DEST" = true ]; then
    echo "Deleting all contents in destination directory '$DESTINATION'."
    rm -rf "$DESTINATION"/*
elif [ "$KEEP" = true ]; then
    OVERWRITE_OPTION="-n"
elif [ "$REPLACE" = true ] || [ "$MOVE" = true ] || [ "$COPY" = true ]; then
    OVERWRITE_OPTION="-f"
else
    OVERWRITE_OPTION="-f"
fi

# Perform copy or move
if [ "$OPERATION" = "copy" ]; then
    echo "Copying from '$SOURCE' to '$DESTINATION' with options: $OVERWRITE_OPTION"
    cp -a $OVERWRITE_OPTION "$SOURCE"/. "$DESTINATION"/
elif [ "$OPERATION" = "move" ]; then
    echo "Moving from '$SOURCE' to '$DESTINATION' with options: $OVERWRITE_OPTION"
    mv "$SOURCE"/. "$DESTINATION"/
fi

echo "Operation completed successfully."