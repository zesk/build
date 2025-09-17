#!/usr/bin/env bash
#
# Update .md copies
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# shellcheck source=/dev/null
source "${BASH_SOURCE[0]%/*}/tools.sh" && __updateMarkdown "$@"
