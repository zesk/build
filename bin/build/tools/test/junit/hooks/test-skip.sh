#!/usr/bin/env bash
#
# jUnit
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
# Hook: test-start

# shellcheck source=/dev/null
"${BASH_SOURCE[0]%/*}/test-stop.sh" "$@"
