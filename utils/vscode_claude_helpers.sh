#!/bin/bash

# General-purpose function to find a file and return its absolute path
# Usage: find_file_path "filename"
# Returns: absolute path to the first matching file, or empty string if not found
find_file_path() {
    local filename="$1"
    local result=$(find "$(pwd)" -name "$filename" -type f 2>/dev/null | head -n 1)
    echo "$result"
}

# Function to build ADR file references dynamically
build_adr_references() {
    local adrs_path="${1:-./docs/ADRs/}"
    local adr_files=""

    if [ -d "$adrs_path" ]; then
        while IFS= read -r adr; do
            # Count lines in the file
            local line_count=$(wc -l < "$adr" 2>/dev/null || echo 0)
            # Only include files with 180 lines or fewer
            if [ "$line_count" -le 180 ]; then
                adr_files="$adr_files@$adr"$'\n'
            fi
        done < <(find "$adrs_path" -type f -name "*.md" 2>/dev/null)
    fi

    echo "$adr_files"
}
