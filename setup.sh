#!/bin/bash
set -euo pipefail

if ! command -v brew &>/dev/null; then
    echo "Homebrew not found. Install it from https://brew.sh"
    exit 1
fi

brew install fzf ripgrep bat eza zoxide jq python@3.13 vim

git submodule update --init --recursive

echo "Done. Restart your shell or run: source ~/.zshrc"
