#!/bin/bash

# Clean doesn't usually need env vars, but we keep the structure consistent
if [ "$DRY_RUN" = true ]; then
  echo "flutter clean $@"
else
  echo "Cleaning project..."
  flutter clean "$@"
fi
