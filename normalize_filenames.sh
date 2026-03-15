#!/usr/bin/env bash

DIR="${1:-.}"

find "$DIR" -depth -print0 | while IFS= read -r -d '' file
do
    dir=$(dirname "$file")
    name=$(basename "$file")

    # Convert to ASCII
    newname=$(printf "%s" "$name" | iconv -f UTF-8 -t ASCII//TRANSLIT)

    if [[ "$name" != "$newname" ]]; then
        newpath="$dir/$newname"

        if [[ -e "$newpath" ]]; then
            echo "Skipping (exists): $newpath"
        else
            echo "Renaming:"
            echo "  $file"
            echo "  -> $newpath"
            mv -i -- "$file" "$newpath"
        fi
    fi
done