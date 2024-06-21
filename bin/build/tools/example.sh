#!/usr/bin/env bash
#
# Example code and patterns
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Depends: colors.sh pipeline.sh
#
# Docs: o ./docs/_templates/tools/example.md
# Test: o ./test/tools/example-tests.sh

# Current Code Cleaning:
#
# - Migrating to `_sugar` and `__usageArgument` model
# - Removing all errorArgument and errorEnvironment globals when found
# - use `a || b || c || return $?` format when possible
# - Any code unwrap functions add a `_` to function beginning (see `deployment.sh` for example)

# IDENTICAL __loader 11
set -eou pipefail
# Load zesk build and run command
__loader() {
  # shellcheck source=/dev/null
  if source "$(dirname "${BASH_SOURCE[0]}")/../../bin/build/tools.sh"; then
    "$@" || return $?
  else
    exec 1>&2 && printf 'FAIL: %s\n' "$@"
    return 42 # The meaning of life
  fi
}

#
# Usage: {fn}
# Argument: --help - Optional. Flag. This help.
# Argument: --easy - Optional. Flag. Easy mode.
# Argument: --target target - Optional. File to create. Directory must exist.
# Argument: --path path - Optional. Directory
# This is a sample function with example code and patterns used in Zesk Build.
#
exampleFunction() {
  local usage="_${FUNCNAME[0]}"
  local argument
  local name easyFlag width

  width=50
  name=
  easyFlag=false
  target=
  path=
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __failArgument "$usage" "blank argument" || return $?
    case "$argument" in
      --help)
        "$usage" 0
        return $?
        ;;
      --easy)
        easyFlag=true
        ;;
      --name)
        shift || __failArgument "$usage" "missing $(consoleLabel "$argument") argument" || return $?
        [ -n "$1" ] || __failArgument "$usage" "Blank $argument argument" || return $?
        name="$1"
        ;;
      --path)
        shift || __failArgument "$usage" "missing $(consoleLabel "$argument") argument" || return $?
        path=$(usageArgumentDirectory "$usage" "path" "$1") || return $?
        ;;
      --target)
        shift || __failArgument "$usage" "missing $(consoleLabel "$argument") argument" || return $?
        target=$(usageArgumentFileDirectory "$usage" "target" "$1") || return $?
        ;;
      *)
        __failArgument "$usage" "unknown argument: $(consoleValue "$argument")" || return $?
        ;;
    esac
    shift || __failArgument "$usage" "shift argument $(consoleLabel "$argument")" || return $?
  done

  # Load MANPATH environment
  export MANPATH
  __usageEnvironment "$usage" buildEnvironmentLoad MANPATH || return $?

  ! $easyFlag || __usageEnvironment consoleNameValue "$width" "$name: Easy mode enabled" || return $?
  ! $easyFlag || __usageEnvironment consoleNameValue "path" "$path" || return $?
  ! $easyFlag || __usageEnvironment consoleNameValue "target" "$target" || return $?

  # Trouble debugging

  #
  # Add ` || _environment "$(debuggingStack)"` to any chain to debug details
  #
  which library-which-should-be-there || __failEnvironment "$usage" "missing thing" || _environment "$(debuggingStack)" || return $?
}
_exampleFunction() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__loader exampleFunction "$@"



#
# The `git-post-commit` hook will be installed as a `git` post-commit hook in your project and will
# overwrite any existing `post-commit` hook.
#
# Merges `main` and `staging` and pushes to `origin`
#
# fn: {base}
__hookGitPostCommit() {
  # Example of a reverse usage
  local usage="${FUNCNAME[0]#_}"

  __usageEnvironment "$usage" gitInstallHook post-commit || return $?

  __usageEnvironment "$usage" gitMainly || return $?
  __usageEnvironment "$usage" git push origin || return $?
}
_hookGitPostCommit() {
  # IDENTICAL reverseUsageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "_${FUNCNAME[0]}" "$@"
}

# __loader __hookGitPostCommit "$@"
