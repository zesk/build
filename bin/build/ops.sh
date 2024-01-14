#!/usr/bin/env bash
#
# Shell colors
#
# Usage: source ./bin/build/tools.sh
#
# Depends: -
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

opsDir="$(dirname "${BASH_SOURCE[0]}")/ops"

# shellcheck source=/dev/null
. "$(dirname "${BASH_SOURCE[0]}")/tools.sh"

# shellcheck source=/dev/null
. "$opsDir/daemontools.sh"
