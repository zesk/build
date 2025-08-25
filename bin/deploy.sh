#!/usr/bin/env bash
#
# Deploy Zesk Build
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# shellcheck source=/dev/null
source "${BASH_SOURCE[0]%/*}/tools.sh" && __buildDeploy "$@"
