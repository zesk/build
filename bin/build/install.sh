#!/usr/bin/env bash
#
# Install tools
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# documentTemplate: ./docs/_templates/__function.md
#
set -eou pipefail
here=$(dirname "${BASH_SOURCE[0]}")
"$here/install/webApplication.sh" "$@"
