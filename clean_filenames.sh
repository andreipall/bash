#!/usr/bin/env bash

# Usage:
#   ./clean_filenames.sh /path/to/directory
# If no directory is provided, current directory is used.

TARGET_DIR="${1:-.}"

# Define invalid characters to remove
# Example removes: \ / : * ? " < > | and control characters
INVALID_CHARS='[\\/:*?"<>|]'

# Process deepest paths first to avoid rename conflicts
find "$TARGET_DIR" -depth -print0 | while IFS= read -r -d '' item; do
    dir="$(dirname "$item")"
    base="$(basename "$item")"

    # Remove invalid characters
    cleaned="$(echo "$base" | sed -E "s/$INVALID_CHARS//g")"

    # Skip if unchanged
    if [[ "$base" != "$cleaned" && -n "$cleaned" ]]; then
        new_path="$dir/$cleaned"

        # Avoid overwriting existing files
        if [[ -e "$new_path" ]]; then
            echo "Skipping (target exists): $new_path"
        else
            echo "Renaming:"
            echo "  $item"
            echo "  -> $new_path"
            mv -i -- "$item" "$new_path"
        fi
    fi
done