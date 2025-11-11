#!/bin/bash
source ./agent/utils/vscode_claude_helpers.sh

adrs_path="$(realpath ./docs/ADRs/)"
adr_files=$(build_adr_references "$adrs_path")

# Find and use absolute path for Architecture_Overview.md
architecture_overview=$(find_file_path "Architecture_Overview.md")

# Loop through each service in ./services/
services_dir="./services"

if [ ! -d "$services_dir" ]; then
    echo "Error: Services directory '$services_dir' does not exist"
    exit 1
fi

echo "=================================================="
echo "Processing services in $services_dir"
echo "=================================================="
echo ""

for service_path in "$services_dir"/*; do
    if [ -d "$service_path" ]; then
        service_name=$(basename "$service_path")

        echo "=================================================="
        echo "Processing service: $service_name"
        echo "=================================================="

        claude --dangerously-skip-permissions "
$adr_files
@${architecture_overview}
Service: $service_name
Service Path: $service_path

Find document which specify programming language and library/framework in Technical-Requirements.md for this service"

        echo ""
        echo "Completed processing: $service_name"
        echo ""
    fi
done

echo "=================================================="
echo "All services processed"
echo "=================================================="
