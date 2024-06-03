#!/usr/bin/env bash
#
# Syntactic sugar
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Depends: nothing
#
# Docs: contextOpen ./docs/_templates/tools/sugar.md
# Test: contextOpen ./test/tools/sugar-tests.sh

# Run `command`, handle failure with `usage` with `code` and `command` as error
# Usage: {fn} code usage command ...
# Argument: code - Required. Integer. Exit code to return
# Argument: usage - Required. String. Failure command, passed remaining arguments and error code.
# Argument: command - Required. String. Command to run.
__usage() {
  local code usage command
  # shellcheck disable=SC2016
  code="${1-0}" && shift && usage="${1}" && shift && command="${1?}" && shift && "$command" "$@" || "$usage" "$code" "$command$(printf ' "%s"' "$@") failed" || return $?
}

# Run `command`, upon failure run `usage` with an environment error
# Usage: {fn} usage command ...
# Argument: usage - Required. String. Failure command
# Argument: command - Required. Command to run.
__usageEnvironment() {
  __usage 1 "$@"
}

# Run `command`, upon failure run `usage` with an argument error
# Usage: {fn} usage command ...
# Argument: usage - Required. String. Failure command
# Argument: command - Required. Command to run.
__usageArgument() {
  __usage 2 "$@"
}

# Run `usage` with an environment error
# Usage: {fn} usage ...
__failEnvironment() {
  local usage
  usage="$1" && shift && "$usage" 1 "$@"
  return $?
}

# Run `usage` with an argument error
# Usage: {fn} usage ...
__failArgument() {
  local usage
  usage="$1" && shift && "$usage" 2 "$@"
  return $?
}

# Run `usage` with an environment error
# Usage: {fn} usage quietLog message ...
__usageEnvironmentQuiet() {
  local usage quietLog
  usage="$1" && shift && quietLog="$1" && shift || __failArgument "$usage" "missing quietLog" || return $?
  "$@" >>"$quietLog" 2>&1 || __failEnvironment "$usage" "$@" || return $?
}

# Logs all deprecated functions to application root in a file called `.deprecated`
# Usage: {fn} command ...
# Argument: function - Required. String. Function which is deprecated.
# Example:     {fn} "${FUNCNAME[0]}"
_deprecated() {
  printf "DEPRECATED: %s" "$@" 1>&2
  printf -- "$(date "+%F %T"),%s\n" "$@" >>"$(dirname "$(dirname "$(dirname "${BASH_SOURCE[0]}")")")/.deprecated"
}
