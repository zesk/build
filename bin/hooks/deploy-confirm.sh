#!/usr/bin/env bash
#
# Run during bin/build/pipeline/php-deploy.sh
#
# Run in the pipeline, used to check smoke test on remote systems: did our deployment work?
#
# If not, fail and it will undo it.
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL _return 8
# Usage: {fn} _return [ exitCode [ message ... ] ]
# Exit Code: exitCode or 1 if nothing passed
_return() {
  local code="${1-1}"
  shift
  printf "%s ❌ (%d)\n" "${*-§}" "$code" 1>&2
  return "$code"
}

# IDENTICAL __tools 12
# Load tools.sh and run command
__tools() {
  local relative="$1"
  local source="${BASH_SOURCE[0]}"
  local here="${source%/*}"
  shift && set -eou pipefail
  local tools="$here/$relative/bin/build/tools.sh"
  [ -x "$tools" ] || _return 97 "$tools not executable" "$@" || return $?
  # shellcheck source=/dev/null
  source "$tools" || _return 42 source "$tools" "$@" || return $?
  "$@" || return $?
}

#
# fn: {base}
# Summary: Deployment confirmation script
#
# Exit code: 0 - Continue with deployment
# Exit code: Non-zero - Any non-zero exit code will run `deploy-revert` hook on all systems and cancel deployment
# should do wahtever is required to ensure that.
#
# Example: - Enable a health endpoint which returns version number and ensure all servers return the same version number (which was just updated)
# Example: - Check the home page for a version number
# Example: - Check for a known artifact (build sha) in the server somehow
# Example: - etc.
__hookDeployConfirm() {
  ! buildDebugEnabled || consoleSuccess "${BASH_SOURCE[0]} is a noop and should be replaced with live smoke tests"
}

__tools ../.. __hookDeployConfirm
