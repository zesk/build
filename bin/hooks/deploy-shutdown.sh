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
# IDENTICAL __tools 18
# Usage: {fn} [ relative [ command ... ] ]
# Load build tools and run command
# Argument: relative - Required. Directory. Path to application root.
# Argument: command ... - Optional. Callable. A command to run and optional arguments.
__tools() {
  local relative="${1:-".."}"
  local source="${BASH_SOURCE[0]}" internalError=253
  local here="${source%/*}"
  local tools="$here/$relative/bin/build"
  [ -d "$tools" ] || _return $internalError "$tools is not a directory" || return $?
  tools="$tools/tools.sh"
  [ -x "$tools" ] || _return $internalError "$tools not executable" "$@" || return $?
  # shellcheck source=/dev/null
  source "$tools" || _return $internalError source "$tools" "$@" || return $?
  shift
  [ $# -eq 0 ] && return 0
  "$@" || return $?
}

# IDENTICAL _return 16
# Usage: {fn} [ exitCode [ message ... ] ]
# Argument: exitCode - Optional. Integer. Exit code to return. Default is 1.
# Argument: message ... - Optional. String. Message to output to stderr.
# Exit Code: exitCode
_return() {
  local r="${1-:1}" && shift
  _integer "$r" || _return 2 "${FUNCNAME[0]} non-integer $r" "$@" || return $?
  printf "[%d] ❌ %s\n" "$r" "${*-§}" 1>&2 || : && return "$r"
}

# Is this an unsigned integer?
# Usage: {fn} value
# Exit Code: 0 - if value is an unsigned integer
# Exit Code: 1 - if value is not an unsigned integer
_integer() { case "${1#+}" in '' | *[!0-9]*) return 1 ;; esac }
# END of IDENTICAL _return

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
___hookDeployShutdown() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__tools ../.. __hookDeployShutdown "$@"
