#!bash

source ./agent/utils/vscode_claude_helpers.sh
source ./agent/.env
adrs_path="$(realpath ./docs/ADRs/)"

export OPENAI_API_KEY="$CHUTES_API_TOKEN"
export OPENAI_BASE_URL="https://llm.chutes.ai/v1"
export OPENAI_MODEL="zai-org/GLM-4.6"
adr_files=$(build_adr_references "$adrs_path")
qwen -i "$adr_files
$1
- Check if healthcheck works well.
"
