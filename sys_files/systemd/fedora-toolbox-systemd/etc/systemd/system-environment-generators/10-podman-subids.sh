#!/usr/bin/env bash

set -euo pipefail

# Fail soft when runtime inputs are unavailable.
if [[ ! -r /proc/1/environ ]]; then
    exit 0
fi

emit() {
    printf '%s=%s\n' "$1" "$2"
}

while IFS='=' read -r key val; do
    case "$key" in
        SUBUID_RANGE) emit SUBUID_RANGE "$val" ;;
        SUBGID_RANGE) emit SUBGID_RANGE "$val" ;;
    esac
done < <(tr '\0' '\n' </proc/1/environ)
