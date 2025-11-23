#!/bin/bash

# Validate cluster path argument
if [ -z "$1" ]; then
    echo "Error: Cluster path required"
    echo "Usage: $0 <cluster-path>"
    echo "Example: $0 docs/strategy/affinity_maps/clusters/cluster_1"
    exit 1
fi

./agent/dsp "
- Discover $1/
- Examine $1/prompt-implementation.md
- Identify relevant ADRs from docs/ADRs/:
 - API patterns from docs/ADRs/api/
 - Data management from docs/ADRs/data/
 - Infrastructure decisions from docs/ADRs/infrastructure/
 - Security policies from docs/ADRs/security/
 - Service-specific from docs/ADRs/backend/ and docs/ADRs/frontend/
- Review existing database schemas in `realpath ./services/`
- Implementation Phase (Full Auto-Implementation - Unattended Mode)
 - Build working MVP prototype following specification-first development
 - Implement microservices architecture (only services required for this cluster's features)
 - Follow documented API contracts (OpenAPI/AsyncAPI/gRPC specifications)
 - Adhere to state machines and runtime sequences
 - Implement error handling per Error_Handling.md specifications
 - Ensure compliance with security and data architecture ADRs
- Execute existing Gherkin scenarios from $1/feature-definitions/gherkin-scenarios/*.feature
- Document implementation decisions in `realpath ./docs/ADRs/autopilot/`/ following ADR template (keep it brief).

I will review and test the implementation after completion.
"
git ls-files --others --exclude-standard | grep '\.md$' | xargs rm

# Extract just the cluster folder name from the path
CLUSTER_NAME=$(basename "$1")

rm -rf ./docs/strategy/affinity_maps/clusters/$CLUSTER_NAME
echo "✓ Finished processing cluster: $CLUSTER_NAME"
