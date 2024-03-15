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

errorEnvironment=1
errorArgument=2

# Run `command` and fail with `code` by running `fail`
# Usage: {fn} code fail command ...
# Argument: code - Required. Integer. Exit code to return
# Argument: fail - Required. String. Failure command
__usage() {
  local code fail
  code="${1-0}" && shift && fail="${1}" && shift && "$@" || "$fail" "$code" "$* failed" || return $?
}

# Run `command`, upon failure run `fail` with an environment error
# Usage: {fn} fail command ...
# Argument: fail - Required. String. Failure command
# Argument: command - Required. Command to run.
__usageEnvironment() {
  __usage "$errorEnvironment" "$@"
}

# Run `command`, upon failure run `fail` with an argument error
# Usage: {fn} fail command ...
# Argument: fail - Required. String. Failure command
# Argument: command - Required. Command to run.
__usageArgument() {
  __usage "$errorArgument" "$@"
}

# Run `fail` with an environment error
# Usage: {fn} fail ...
__failEnvironment() {
  local fail
  fail="$1" && shift && "$fail" "$errorEnvironment" "$@"
  return $errorEnvironment
}

# Run `fail` with an argument error
# Usage: {fn} fail ...
__failArgument() {
  local fail
  fail="$1" && shift && "$fail" "$errorArgument" "$@"
  return $errorArgument
}

# Usage: {fn} command ...
# Argument: function - Required. String. Function which is deprecated.
# Example:     {fn} "${FUNCNAME[0]}"
_deprecated() {
  printf "DEPRECATED: %s" "$@" 1>&2
  printf "%s" "$@" >>"$(dirname "$(dirname "$(dirname "${BASH_SOURCE[0]}")")")/._deprecated"
}
