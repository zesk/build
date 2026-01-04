#!/usr/bin/env bash
#
# Run during `deployApplication` in the OLD application and is intended
# to signal the application to start shutting down for a new version to take
# its place. So any files in tge application root which for any reason need to
# be preserved should be managed here or in other hooks if needed.
# Ideally your application would consist solely of application code and no data files
# in which case it won't be an issue.
#
# This is run ON THE REMOTE SYSTEM, not in the pipeline
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

set -eou pipefail

# shellcheck source=/dev/null
if source "${BASH_SOURCE[0]%/*}/../build/tools.sh"; then

  #
  # Runs at the end of the application life (before taking down application and replacing with another)
  #
  # fn: {base}
  __hookDeployShutdown() {
    local handler="_${FUNCNAME[0]#_}"

    decorate success "${BASH_SOURCE[0]} is a no-op." || throwEnvironment "$handler" "decorate success" || return $?
    : "$@"
  }
  ___hookDeployShutdown() {
    # __IDENTICAL__ usageDocument 1
    usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
  }
  __hookDeployShutdown "$@"
fi
