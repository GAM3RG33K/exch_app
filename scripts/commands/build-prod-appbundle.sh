#!/bin/bash

"$SCRIPT_DIR/exch" build appbundle --env=prod --release "$@"
