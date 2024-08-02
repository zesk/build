#!/bin/bash
#
# cannon.sh
#
# Replace all occurrences of one string with another in a directory of files.
#
# Use caution!
#
# See: cannon
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

set -x
"$(dirname "${BASH_SOURCE[0]}")/tools.sh" cannon "$@"
