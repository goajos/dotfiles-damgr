#!/usr/bin/env bash
VERSION="0.26.1"
URL="https://github.com/tree-sitter/tree-sitter/releases/download/v${VERSION}/tree-sitter-linux-x64.gz"
DIR="/usr/local/bin"
curl -L "$URL" -o /tmp/tree-sitter-linux-x64.gz
gunzip -f /tmp/tree-sitter-linux-x64.gz
mv /tmp/tree-sitter-linux-x64 "${DIR}/tree-sitter"
chmod +x "${DIR}/tree-sitter"
