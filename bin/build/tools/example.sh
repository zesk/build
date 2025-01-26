#!/usr/bin/env bash
#
# Example code and patterns
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Docs: ./docs/_templates/tools/example.md
# Test: ./test/tools/example-tests.sh

# Current Code Cleaning:
#
# - use `a || b || c || return $?` format when possible
# - Any code unwrap functions add a `_` to function beginning (see `deployment.sh` for example)

_usageFunction() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# IDENTICAL __source 19
# Usage: {fn} source relativeHome  [ command ... ] ]
# Load a source file and run a command
# Argument: source - Required. File. Path to source relative to application root..
# Argument: relativeHome - Required. Directory. Path to application root.
# Argument: command ... - Optional. Callable. A command to run and optional arguments.
# Requires: _return
# Security: source
__source() {
  local me="${BASH_SOURCE[0]}" e=253
  local here="${me%/*}" a=()
  local source="$here/${2:-".."}/${1-}" && shift 2 || _return $e "missing source" || return $?
  [ -d "${source%/*}" ] || _return $e "${source%/*} is not a directory" || return $?
  [ -f "$source" ] && [ -x "$source" ] || _return $e "$source not an executable file" "$@" || return $?
  while [ $# -gt 0 ]; do a+=("$1") && shift; done
  # shellcheck source=/dev/null
  source "$source" || _return $e source "$source" "$@" || return $?
  [ ${#a[@]} -gt 0 ] || return 0
  "${a[@]}" || return $?
}

# IDENTICAL __tools 8
# Usage: {fn} [ relativeHome [ command ... ] ]
# Load build tools and run command
# Argument: relativeHome - Required. Directory. Path to application root.
# Argument: command ... - Optional. Callable. A command to run and optional arguments.
# Requires: __source _return
__tools() {
  __source bin/build/tools.sh "$@"
}

# IDENTICAL _return 25
# Usage: {fn} [ exitCode [ message ... ] ]
# Argument: exitCode - Optional. Integer. Exit code to return. Default is 1.
# Argument: message ... - Optional. String. Message to output to stderr.
# Exit Code: exitCode
# Requires: isUnsignedInteger printf _return
_return() {
  local r="${1-:1}" && shift
  isUnsignedInteger "$r" || _return 2 "${FUNCNAME[1]-none}:${BASH_LINENO[1]-} -> ${FUNCNAME[0]} non-integer $r" "$@" || return $?
  printf -- "[%d] ❌ %s\n" "$r" "${*-§}" 1>&2 || : && return "$r"
}

# Test if an argument is an unsigned integer
# Source: https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash
# Credits: F. Hauri - Give Up GitHub (isnum_Case)
# Original: is_uint
# Usage: {fn} argument ...
# Exit Code: 0 - if it is an unsigned integer
# Exit Code: 1 - if it is not an unsigned integer
# Requires: _return
isUnsignedInteger() {
  [ $# -eq 1 ] || _return 2 "Single argument only: $*" || return $?
  case "${1#+}" in '' | *[!0-9]*) return 1 ;; esac
}

# <-- END of IDENTICAL _return

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
  local name="" easyFlag=false width=50 target=""

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count: $(decorate each code "${__saved[@]}")" || return $?
    case "$argument" in
      # _IDENTICAL_ --help 4
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
        path="$(usageArgumentDirectory "$usage" "$argument" "${1-}")" || return $?
        ;;
      --target)
        shift
        target="$(usageArgumentFileDirectory "$usage" "$argument" "${1-}")" || return $?
        ;;
      *)
        # _IDENTICAL_ argumentUnknown 1
        __throwArgument "$usage" "unknown #$__index/$__count: $argument $(decorate each code "${__saved[@]}")" || return $?
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift || __throwArgument "$usage" "missing #$__index/$__count: $argument $(decorate each code "${__saved[@]}")" || return $?
  done

  local start

  # IDENTICAL startBeginTiming 1
  start=$(__catchEnvironment "$usage" beginTiming) || return $?


  # Load MANPATH environment
  export MANPATH
  __catchEnvironment "$usage" buildEnvironmentLoad MANPATH || return $?

  ! $easyFlag || __catchEnvironment "$usage" consoleNameValue "$width" "$name: Easy mode enabled" || return $?
  ! $easyFlag || __catchEnvironment "$usage" consoleNameValue "path" "$path" || return $?
  ! $easyFlag || __catchEnvironment "$usage" consoleNameValue "target" "$target" || return $?

  # Trouble debugging

  whichExists library-which-should-be-there || __throwEnvironment "$usage" "missing thing" || return $?

  # DEBUG LINE
  printf -- "%s:%s %s\n" "$(decorate code "${BASH_SOURCE[0]}")" "$(decorate magenta "$LINENO")" "$(decorate each code "$@")" # DEBUG LINE
  reportTiming "$start" "Completed in"
}
_exampleFunction() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__tools ../.. exampleFunction "$@"

#
# How to load arguments until -- found
#
__testFunction() {
  local exceptions=()

  # Load variables until "--" is found
  while [ $# -gt 0 ]; do [ "$1" = "--" ] && shift && break || exceptions+=("$1") && shift; done
  printf "%s\n" "${exceptions[@]+"${exceptions[@]}"}"
}

# Post-commit hook code

#
# The `git-post-commit` hook will be installed as a `git` post-commit hook in your project and will
# overwrite any existing `post-commit` hook.
#
# Merges `main` and `staging` and pushes to `origin`
#
# fn: {base}
__hookGitPostCommit() {
  local usage="_${FUNCNAME[0]}"

  # _IDENTICAL_ argument-case-header-blank 4
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    case "$argument" in
      # _IDENTICAL_ --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      *)
        # _IDENTICAL_ argumentUnknown 1
        __throwArgument "$usage" "unknown #$__index/$__count: $argument $(decorate each code "${__saved[@]}")" || return $?
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift || __throwArgument "$usage" "missing #$__index/$__count: $argument $(decorate each code "${__saved[@]}")" || return $?
  done

  reportTiming "$start" "Completed in"
  __catchEnvironment "$usage" gitInstallHook post-commit || return $?

  __catchEnvironment "$usage" gitMainly || return $?
  __catchEnvironment "$usage" git push origin || return $?
}
___hookGitPostCommit() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# __tools ../.. __hookGitPostCommit "$@"
