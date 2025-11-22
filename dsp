#!/bin/bash

claude -p /clear
claude --dangerously-skip-permissions "Update TODOS:
- Discover `realpath ./docs/ADRs/`/$1"
