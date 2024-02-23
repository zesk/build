#!/usr/bin/env bash
#
# Copyright &copy; 2024, Market Acumen, Inc.
#
# Wrapper for awsIPAccess
#
"$(dirname "${BASH_SOURCE[0]}" || exit 1)/../tools.sh" awsIPAccess "$@"
