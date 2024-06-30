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

__toolsMain() {
  local source="${BASH_SOURCE[0]}"
  local here="${source%/*}"
  local toolsFiles
  local toolFile
  export BUILD_HOME

  #
  # Ordering matters!
  #
  toolsFiles=("../env/BUILD_HOME")

  # Strange quoting for Assert is to hide it from findUncaughtAssertions
  # test quote is required to not mess up syntax coloring :|

  # Core stuff
  toolsFiles+=(_sugar sugar debug type process os text date float url _colors colors sed "ass""ert" hook utilities self)
  toolsFiles+=(pipeline deploy deploy/application deployment apt log )
  toolsFiles+=(decoration usage console security "test" version vendor)

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
      return 96
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

__toolsMain "$@"
