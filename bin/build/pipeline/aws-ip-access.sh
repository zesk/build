#!/usr/bin/env bash
#
# Copyright &copy; 2024, Market Acumen, Inc.
#
# Wrapper for awsIPAccess
#
set -eou pipefail

"$(dirname "${BASH_SOURCE[0]}" || exit 1)/../tools.sh" awsIPAccess "$@"
