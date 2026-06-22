#!/usr/bin/env bash
# favico × Bitwarden — guided launcher (macOS / Linux).
cd "$(dirname "$0")" || exit 1
exec node start.mjs "$@"
