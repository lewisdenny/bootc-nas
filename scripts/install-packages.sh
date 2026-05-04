#!/usr/bin/env bash
# install-packages.sh — Install NAS packages from packages.txt
# Strips comments, blank lines, and inline annotations before passing to dnf.
set -euo pipefail

PACKAGES_FILE="${1:-/tmp/packages.txt}"

if [[ ! -f "$PACKAGES_FILE" ]]; then
  echo "ERROR: Package list not found: $PACKAGES_FILE" >&2
  exit 1
fi

# Parse package names: strip comments, trim whitespace, take first field
PACKAGES=$(sed 's/#.*//' "$PACKAGES_FILE" | awk 'NF {print $1}')
COUNT=$(echo "$PACKAGES" | wc -l)

echo "=== Installing $COUNT packages ==="
echo "$PACKAGES" | tr '\n' ' '
echo ""
echo ""

dnf install -y $PACKAGES
dnf clean all

echo ""
echo "=== Package installation complete ==="
rm -f "$PACKAGES_FILE"
