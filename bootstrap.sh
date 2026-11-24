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

#Ensure Homebrew is installed.
BREW_BIN="/opt/homebrew/bin/brew"
if [[ ! -x "$BREW_BIN" ]]; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "Homebrew is already installed."
fi

# Initialize Homebrew for tjis shell.
eval "$("$BREW_BIN" shellenv)"


echo "Prerequisites verified."
brew --version
