#!/bin/bash

# Check if we are in dry-run mode
if [ "$DRY_RUN" = true ]; then
  echo "flutter run $DART_DEFINES $@"
else
  echo "Running with environment: $ENV"
  # We use eval to correctly handle quotes in DART_DEFINES
  eval "flutter run $DART_DEFINES $@"
fi
