#!/bin/bash

# Process each cluster subfolder in ./docs/strategy/affinity_maps/clusters/
CLUSTERS_DIR="./docs/strategy/affinity_maps/clusters"

# Find all cluster_* directories and process them in sorted order
for cluster_dir in $(find "${CLUSTERS_DIR}" -maxdepth 1 -type d -name "cluster_*" | sort); do
    echo "========================================="
    echo "Processing cluster: $(basename ${cluster_dir})"
    echo "========================================="

    # Run autopilot-cluster.sh with the absolute path to the cluster directory
    ./agent/src/fuel2/execution/autopilot-cluster.sh "$(realpath ${cluster_dir})"

    # Check exit status
    if [ $? -ne 0 ]; then
        echo "ERROR: Failed to process cluster: $(basename ${cluster_dir})"
        echo "Continuing with next cluster..."
    fi

    echo ""
done

echo "========================================="
echo "All clusters processed"
echo "========================================="
