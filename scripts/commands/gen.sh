#!/bin/bash

# Check if we are in dry-run mode
if [ "$DRY_RUN" = true ]; then
  echo "dart run build_runner build --delete-conflicting-outputs $@"
else
  echo "Running build_runner..."
  dart run build_runner build --delete-conflicting-outputs "$@"
fi
