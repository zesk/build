#!/usr/bin/env bash
#
# Run during bin/build/pipeline/deploy-remote-finish.sh
#
# Run ON THE REMOTE SYSTEM, not in the pipeline so assume little.
#
# Do any steps after a deployment fails to undo and restore the previous deployment on a host
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL __tools 12
# Load zesk build and run command
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

# After a deployment was successful on a host, this undos that deployment and goes back to the previous version.
#
# fn: {base}
# Summary: Deployment "undo" script
#
# Exit code: 0 - This SHOULD exit successfully always
__hookDeployRevert() {
  ! buildDebugEnabled || consoleSuccess "${BASH_SOURCE[0]} is a noop and should be replaced or deleted."
}

__hookDeployRevert "$@"
