#!/usr/bin/env bash
#
# Operations tools
#
# Usage: # shellcheck source=/dev/null
# Usage: . ./bin/build/ops.sh
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# documentTemplate: ./docs/_templates/__function.md
#

loadTools() {
  local errorEnvironment=1
  local toolsFiles=(daemontools sysvinit)
  local toolFile here

  if ! here="$(dirname "${BASH_SOURCE[0]}")"; then
    printf "%s\n" "dirname failed" 1>&2
    return "$errorEnvironment"
  fi
  # shellcheck source=/dev/null
  if ! source "$here/tools.sh"; then
    printf "%s\n" "tools.sh failed" 1>&2
    return "$errorEnvironment"
  fi
  for toolFile in "${toolsFiles[@]}"; do
    # shellcheck source=/dev/null
    source "$here/ops/$toolFile.sh" || :
  done
  if [ "$(basename "${0##-}")" = "$(basename "${BASH_SOURCE[0]}")" ] && [ $# -gt 0 ]; then
    # Only require when running as a shell command
    set -eou pipefail
    # Run remaining command line arguments
    "$@"
  fi
}

loadTools "$@"
