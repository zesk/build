#!/usr/bin/env bash
#
# Run during `deployApplication` in the OLD application and is intended
# to signal the application to start shutting down for a new version to take
# its place. So any files in tge appliation root which for any reason need to
# be preserved should be managed here or in other hooks if needed.
# Ideally your application would consist solely of application code and no data files
# in which case it won't be an issue.
#
# This is run ON THE REMOTE SYSTEM, not in the pipeline
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
set -eou pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/../.."

# shellcheck source=/dev/null
. ./bin/build/tools.sh

# Deployment "start" script
#
# fn: {base}
# Exit code: 0 - This SHOULD exit successfully always
# Example: - Move directories to make deployment final

set -eou pipefail

# Usage: {fn} {title} [ items ... ]
_fail() {
  exec 1>&2 && printf 'FAIL: %s\n' "$@"
  return 42 # The meaning of life
}

#
# Runs at the end of the application life (before taking down application and replacing with another)
#
# fn: {base}
__hookDeployShutdown() {
  local usage="_${FUNCNAME[0]#_}"

  # shellcheck source=/dev/null
  source "$(dirname "${BASH_SOURCE[0]}")/../../bin/build/tools.sh" || _fail tools.sh || return $?

  consoleSuccess "${BASH_SOURCE[0]} is a no-op." || __failEnvironment "$usage" "consoleSuccess" || return $?
  : "$@"
}
_hookDeployShutdown() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__hookDeployShutdown "$@"
