#!/usr/bin/env bash
#
# Shell tools
#
# Usage: # shellcheck source=/dev/null
# Usage: . ./bin/build/tools.sh
# Depends: -
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# documentTemplate: ./docs/_templates/__function.md
#

errorEnvironment=1

loadTools() {
  local toolsFiles
  local toolFile here
  export BUILD_HOME

  if ! here=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd); then
    printf "%s\n" "dirname failed" 1>&2
    return "$errorEnvironment"
  fi

  # shellcheck source=/dev/null
  if ! source "$here/env/BUILD_HOME.sh"; then
    printf "%s\n" "Loading BUILD_HOME.sh failed" 1>&2
    return "$errorEnvironment"
  fi

  #
  # Ordering matters!
  #
  toolsFiles=()

  # Strange quoting for Assert is to hide it from findUncaughtAssertions

  # Core stuff
  toolsFiles+=(_sugar sugar debug type process os text date float url _colors colors sed "ass""ert" hook utilities self)
  toolsFiles+=(pipeline deploy deployment apt log decoration usage console security test version vendor)

  # More complex tools
  toolsFiles+=(security markdown documentation "documentation/index" "documentation/see" interactive identical)

  # Technology Integration
  toolsFiles+=(aws web docker ssh npm prettier php install terraform)

  # Code
  toolsFiles+=(bitbucket git github)

  for toolFile in "${toolsFiles[@]}"; do
    # shellcheck source=/dev/null
    if ! source "$here/tools/$toolFile.sh"; then
      printf "%s\n" "Loading $toolFile.sh failed" 1>&2
      return "$errorEnvironment"
    fi
  done
  # shellcheck source=/dev/null
  if [ "$(basename "${0##-}")" = "$(basename "${BASH_SOURCE[0]}")" ] && [ $# -gt 0 ]; then
    # Only require when running as a shell command
    set -eou pipefail
    # Run remaining command line arguments
    BUILD_HOME="$BUILD_HOME" "$@"
  fi
}

loadTools "$@"
