#!/bin/bash

SUB_COMMAND=$1
shift

if [ -z "$SUB_COMMAND" ]; then
  echo "Usage: ./scripts/exch build <sub-command> [args...]"
  echo "Sub-commands: apk, ios, appbundle, web, etc."
  exit 1
fi

# Check if we are in dry-run mode
if [ "$DRY_RUN" = true ]; then
  echo "flutter build $SUB_COMMAND $DART_DEFINES $@"
else
  echo "Building $SUB_COMMAND with environment: $ENV"
  eval "flutter build $SUB_COMMAND $DART_DEFINES $@"
fi
