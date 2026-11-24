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
if [[ "$(uname -m)" != "arm64" ]]; then
    echo "This script requires Apple Silicon." >&2
    exit 1
fi

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

# Install bootstrap dependencies.
brew install gh chezmoi

# Authenticate to GitHub if necessary
if ! gh auth status --hostname github.com >/dev/null 2>&1; then
  echo "Authenticating to GitHub..."
  gh auth login --hostname github.com --git-protocol https --web
else
  echo "Already authenticated to GitHub."
fi

# Configure Git to use GitHub CLI for credentials
gh auth setup-git --hostname github.com
