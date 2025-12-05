#!/bin/bash

# Check if we are in dry-run mode
if [ "$DRY_RUN" = true ]; then
  echo "flutter pub get $@"
else
  echo "Running flutter pub get..."
  flutter pub get "$@"
fi
