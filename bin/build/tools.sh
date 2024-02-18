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

loadTools() {
  local toolsFiles=()
  local toolFile here
  #
  # Ordering matters!
  #

  if ! here="$(dirname "${BASH_SOURCE[0]}")"; then
    printf "%s\n" "dirname failed" 1>&2
    return 1
  fi

  toolsFiles=()

  # Core stuff
  toolsFiles+=(debug type text date url colors sed assert hook pipeline deploy deployment apt os log decoration usage console security test version vendor)

  # More complex tools
  toolsFiles+=(security markdown documentation "documentation/index" "documentation/see" interactive identical)

  # Technology Integration
  toolsFiles+=(aws docker ssh npm prettier php install terraform)

  # Code
  toolsFiles+=(bitbucket git)

  for toolFile in "${toolsFiles[@]}"; do
    # shellcheck source=/dev/null
    . "$here/tools/$toolFile.sh" || :
  done

  if [ "$(basename "${0##-}")" = "$(basename "${BASH_SOURCE[0]}")" ] && [ $# -gt 0 ]; then
    # Only require when running as a shell command
    set -eou pipefail
    # Run remaining command line arguments
    "$@"
  fi
}

loadTools "$@"
