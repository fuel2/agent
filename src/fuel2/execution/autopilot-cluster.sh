#!/bin/bash

# Validate cluster path argument
if [ -z "$1" ]; then
    echo "Error: Cluster path required"
    echo "Usage: $0 <cluster-path>"
    echo "Example: $0 docs/strategy/affinity_maps/clusters/cluster_1"
    exit 1
fi

mkdir -p \
 ./infrastructure/

./agent/dsp "
- Discover $1/
- Examine $1/prompt-implementation.md
- Identify relevant ADRs from docs/ADRs/:
 - API patterns from docs/ADRs/api/
 - Data management from docs/ADRs/data/
 - Infrastructure decisions from docs/ADRs/infrastructure/
 - Security policies from docs/ADRs/security/
 - Service-specific from docs/ADRs/backend/ and docs/ADRs/frontend/
- Review existing infrastructure in `realpath ./infrastructure/`
- Review existing database schemas in `realpath ./services/`
- Analyze Required Services:
 - Examine all feature specifications in $1/feature-definitions/
 - Review API specifications (OpenAPI/AsyncAPI/gRPC) to identify service endpoints
 - Review runtime sequences and state machines to understand service interactions
 - Review user stories and use cases to determine service responsibilities
 - Cross-reference with docs/system-topology/service-catalog/ for service definitions
 - Create a list of ONLY the services required for this cluster's features
 - Verify service dependencies and integration points
 - Check existing services in `realpath ./services/` to avoid duplication
- Implementation Phase (Full Auto-Implementation - Unattended Mode)
 - Build working MVP prototype following specification-first development
 - Implement microservices architecture (ONLY services identified in analysis phase)
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
