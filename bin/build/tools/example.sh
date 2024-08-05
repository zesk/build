#!/usr/bin/env bash
#
# Example code and patterns
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Docs: o ./docs/_templates/tools/example.md
# Test: o ./test/tools/example-tests.sh

# Current Code Cleaning:
#
# - Migrating to `_sugar` and `__usageArgument` model
# - Removing all errorArgument and errorEnvironment globals when found
# - use `a || b || c || return $?` format when possible
# - Any code unwrap functions add a `_` to function beginning (see `deployment.sh` for example)

# IDENTICAL __tools 17
# Usage: {fn} [ relative [ command ... ] ]
# Load build tools and run command
# Argument: relative - Required. Directory. Path to application root.
# Argument: command ... - Optional. Callable. A command to run and optional arguments.
__tools() {
  local source="${BASH_SOURCE[0]}" e=253
  local here="${source%/*}"
  local tools="$here/${1:-".."}/bin/build"
  [ -d "$tools" ] || _return $e "$tools is not a directory" || return $?
  tools="$tools/tools.sh"
  [ -x "$tools" ] || _return $e "$tools not executable" "$@" || return $?
  # shellcheck source=/dev/null
  source "$tools" || _return $e source "$tools" "$@" || return $?
  shift
  [ $# -eq 0 ] && return 0
  "$@" || return $?
}

# IDENTICAL _return 19
# Usage: {fn} [ exitCode [ message ... ] ]
# Argument: exitCode - Optional. Integer. Exit code to return. Default is 1.
# Argument: message ... - Optional. String. Message to output to stderr.
# Exit Code: exitCode
_return() {
  local r="${1-:1}" && shift
  _integer "$r" || _return 2 "${FUNCNAME[1]-none}:${BASH_LINENO[1]-} -> ${FUNCNAME[0]} non-integer $r" "$@" || return $?
  printf "[%d] ❌ %s\n" "$r" "${*-§}" 1>&2 || : && return "$r"
}

# Is this an unsigned integer?
# Usage: {fn} value
# Exit Code: 0 - if value is an unsigned integer
# Exit Code: 1 - if value is not an unsigned integer
_integer() {
  case "${1#+}" in '' | *[!0-9]*) return 1 ;; esac
}

# END of IDENTICAL _return

#
# Usage: {fn}
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: --easy - Optional. Flag. Easy mode.
# Argument: binary - Required. String. The binary to look for.
# Argument: remoteUrl - Required. URL. Remote URL.
# Argument: --target target - Optional. File. File to create. File must exist.
# Argument: --path path - Optional. Directory. Directory of path of thing.
# Argument: --title title - Optional. String. Title of the thing.
# Argument: --name name - Optional. String. Name of the thing.
# Argument: --url url - Optional. URL. URL to download.
# Argument: --callable callable - Optional. Callable. Function to call when url is downloaded.
# This is a sample function with example code and patterns used in Zesk Build.
#
exampleFunction() {
  local usage="_${FUNCNAME[0]}"
  local argument nArguments argumentIndex
  local name easyFlag width

  width=50
  name=
  easyFlag=false
  target=
  path=
  nArguments=$#
  while [ $# -gt 0 ]; do
    argumentIndex=$((nArguments - $# + 1))
    argument="$(usageArgumentString "$usage" "argument #$argumentIndex" "$1")" || return $?
    case "$argument" in
      # IDENTICAL --help 4
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
        name="$(usageArgumentString "$usage" "$argument" "${1-}")" || return $?
        ;;
      --path)
        shift
        path="$(usageArgumentDirectory "$usage" "path" "${1-}")" || return $?
        ;;
      --target)
        shift
        target="$(usageArgumentFileDirectory "$usage" "target" "${1-}")" || return $?
        ;;
      # IDENTICAL argumentUnknown 3
      *)
        __failArgument "$usage" "unknown argument #$argumentIndex: $argument" || return $?
        ;;
    esac
    shift || __failArgument "$usage" "missing argument #$argumentIndex: $argument" || return $?
  done

  # Load MANPATH environment
  export MANPATH
  __usageEnvironment "$usage" buildEnvironmentLoad MANPATH || return $?

  ! $easyFlag || __usageEnvironment "$usage" consoleNameValue "$width" "$name: Easy mode enabled" || return $?
  ! $easyFlag || __usageEnvironment "$usage" consoleNameValue "path" "$path" || return $?
  ! $easyFlag || __usageEnvironment "$usage" consoleNameValue "target" "$target" || return $?

  # Trouble debugging

  #
  # Add ` || _environment "$(debuggingStack)"` to any chain to debug details
  #
  which library-which-should-be-there || __failEnvironment "$usage" "missing thing" || _environment "$(debuggingStack)" || return $?
}
_exampleFunction() {
  # IDENTICAL usageDocument 1
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
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# __tools ../.. __hookGitPostCommit "$@"

# (assert[A-Za-z]+) ([^-])
# $1 --line "\$LINENO" $2
