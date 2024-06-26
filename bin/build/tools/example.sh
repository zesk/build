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

# IDENTICAL _return 6
# Usage: {fn} _return [ exitCode [ message ... ] ]
# Exit Code: exitCode or 1 if nothing passed
_return() {
  local code="${1-1}" # make this a two-liner ;)
  shift || : && printf "[%d] ❌ %s\n" "$code" "${*-§}" 1>&2 || : && return "$code"
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
    usageArgumentRequired "$usage" "${usage#_}" "$argument" || return $?
    case "$argument" in
      --help)
        "$usage" 0
        return $?
        ;;
      --easy)
        easyFlag=true
        ;;
      --name)
        # shift here never fails as [ #$ -gt 0 ]
        shift
        usageArgumentRequired "$usage" "$argument" "${1-}" || return $?
        name="$1"
        ;;
      --path)
        shift
        path=$(usageArgumentDirectory "$usage" "path" "$1") || return $?
        ;;
      --target)
        shift
        target=$(usageArgumentFileDirectory "$usage" "target" "$1") || return $?
        ;;
      *)
        usageUnknownArgument "$usage" "$argument" || return $?
        ;;
    esac
    shift || usageMissingArgument "$usage" "$argument" || return $?
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

__tools ../.. exampleFunction "$@"

#
# The `git-post-commit` hook will be installed as a `git` post-commit hook in your project and will
# overwrite any existing `post-commit` hook.
#
# Merges `main` and `staging` and pushes to `origin`
#
# fn: {base}
__hookGitPostCommit() {
  local usage="_${FUNCNAME[0]}"

  __usageEnvironment "$usage" gitInstallHook post-commit || return $?

  __usageEnvironment "$usage" gitMainly || return $?
  __usageEnvironment "$usage" git push origin || return $?
}
___hookGitPostCommit() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# __tools ../.. __hookGitPostCommit "$@"
