#!/bin/bash

set -euo pipefail

# Verify operating system.
if [[ "$(uname -s)" != "Darwin" ]]; then
  echo "This script requires macOS." >&2
  exit 1
fi

# Ensure Apple Command Line Tools are installed.
if ! xcode-select -p >/dev/null 2>&1; then
  echo "Installing Xcode Command Line Tools..."
  xcode-select --install
  echo "Complete the installation, then rerun this script."
  exit 0
fi

echo "Prerequisites verified."
