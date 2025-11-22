#!bash

claude -p /clear
claude --dangerously-skip-permissions "
Discover `tree ./docs/ADRs/`
$1"
