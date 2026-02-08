#!/usr/bin/env bash
#
# utilities.sh
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
# Test: o test/tools/utilities-tests.sh
# Docs: o docs/_templates/tools/utilities.md
#
# Tools which do not fit anywhere else
#

# Argument: count - Integer. Optional. Sets the value for any following named variables to this value.
# Argument: variable - String. Optional. Variable to change or increment.
# Argument: --path cacheDirectory - Directory. Optional. Use this directory path as the state directory.
# Argument: --reset - Flag. Optional. Reset all counters to zero.
# Argument: --separator - String. Optional. When dumping all variables use this as the separator between name and value. (Default is space: `"  "`)
# Argument: --line - String. Optional. When dumping all variables use this as the separator between values. (Default is newline: `$'\n'`)
#
# Set or increment a incrementor state based on a state directory. If no numeric value is supplied the default is to increment the current value and output it.
# New values are set to 0 by default so will output `1` upon first handler.
# If no variable name is supplied it uses the default variable name `default`.
#
# Variable names can contain alphanumeric characters, underscore, or dash.
#
# The special count `?` is used to query variables directly by name without modifying them.
# Passing `?` on the command line without any name arguments will output all incrementors active using the `--separator` and `--line` markers.
#
# Sets `default` incrementor to 1 and outputs `1`
#
#     {fn} 1
#
# Increments the `kitty` counter and outputs `1` on first call and `n + 1` for each subsequent call.
#
#     {fn} kitty
#
# Sets `kitty` incrementor to 2 and outputs `2`
#
#     {fn} 2 kitty
#
# Dumps the current incrementors:
#
#     {fn} ?
#     default 1
#     kitty 2
#
# The default cache `--path` is placed within the `buildCacheDirectory`.
#
# Depends: buildCacheDirectory
# See: buildCacheDirectory
# shellcheck disable=SC2120
incrementor() {
  local handler="_${FUNCNAME[0]}"
  local cacheDirectory="" counterFile=""
  local separator=" " name="" value="" nextValue="" newline=$'\n' showMarker="?"

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --path) shift && cacheDirectory=$(validate "$handler" Directory "$argument" "${1-}") || return $? ;;
    --separator) shift && separator="$(validate "$handler" String "$argument" "${1-}")" || return $? ;;
    --line) shift && newline="$(validate "$handler" String "$argument" "${1-}")" || return $? ;;
    --reset)
      __incrementorCache false
      [ ! -d "$cacheDirectory" ] || catchReturn "$handler" rm -rf "$cacheDirectory" || return $?
      return 0
      ;;
    "$showMarker")
      shift
      if [ $# -gt 0 ]; then
        while [ $# -gt 0 ]; do
          nextValue=""
          counterFile="$cacheDirectory/$1"
          __incrementorGet
          printf -- "%d%s" "$nextValue" "$newline"
          shift
        done
      else
        __incrementorCache false
        if [ -d "$cacheDirectory" ]; then
          while read -r name; do
            counterFile="$cacheDirectory/$name"
            __incrementorGet
            printf "%s%s%d%s" "$name" "$separator" "$nextValue" "$newline"
          done < <(find "$cacheDirectory" -type f -exec basename {} \; | sort)
        fi
      fi
      return 0
      ;;
    *[^-_a-zA-Z0-9]*)
      throwArgument "$handler" "Invalid argument or variable name: $argument" || return $?
      ;;
    *)
      __incrementorCache
      if isInteger "$argument"; then
        if [ -n "$name" ]; then
          counterFile="$cacheDirectory/$name"
          __incrementor
          name=
        fi
        value="$argument"
      else
        if [ -n "$name" ]; then
          counterFile="$cacheDirectory/$name"
          __incrementor
        fi
        name="$argument"
        [ -n "$name" ] || name=default
      fi
      ;;
    esac
    shift
  done

  [ -n "$name" ] || name=default
  __incrementorCache
  counterFile="$cacheDirectory/$name"
  __incrementor
}
_incrementor() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Local: handler
# Local: cacheDirectory
__incrementorCache() {
  local create="${1-true}"
  if [ -z "$cacheDirectory" ]; then
    cacheDirectory="$(catchReturn "$handler" buildCacheDirectory)/incrementor/$$" || return $?
    if $create; then
      cacheDirectory="$(catchReturn "$handler" directoryRequire "$cacheDirectory")" || return $?
    fi
  fi
}

# Argument: counterFile - File. Required. File to store our value.
# Argument: value - EmptyString. Optional. The value to store.
# stdout: Integer
# When value is non-blank - write it to the counter file
# When value is blank - load it (if it exists), increment it, and then write it to the counter file. First run writes `0`.
# Local: value
# Local: counterFile
# Local: newline
__incrementor() {
  local nextValue="$value"
  if [ -z "$nextValue" ]; then
    __incrementorBump
  fi
  printf -- "%d%s" "$nextValue" "$newline" | tee "$counterFile"
}

# Local: nextValue
# Local: counterFile
__incrementorBump() {
  __incrementorGet "$counterFile"
  nextValue=$((nextValue + 1))
}

# Argument: counterFile - File. Required. File to store our value.
# stdout: Integer
# When value is non-blank - write it to the counter file
# When value is blank - load it (if it exists), increment it, and then write it to the counter file. First run writes `0`.
# Local: nextValue
# Local: counterFile
__incrementorGet() {
  if [ -f "$counterFile" ]; then
    nextValue="$(head -n 1 "$counterFile")"
  fi
  isInteger "$nextValue" || nextValue=0
}

# Single reader, multiple writers
# Attempt at having docker communicate back to the outside world.
# Argument: --mode mode - String. Optional.
# Argument: namedPipe
# Argument: --writer line ... - When encountered all additional arguments are written to the runner.
# Argument: readerExecutable ... - Callable. Optional.
pipeRunner() {
  local handler="_${FUNCNAME[0]}"

  local binary="" namedPipe="" mode="0700"

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --mode) shift && mode=$(validate "$handler" String "mode" "${1-}") || return $? ;;
    --writer)
      [ -z "$namedPipe" ] || throwArgument "$handler" "No namedPipe supplied" || return $?
      [ -p "$namedPipe" ] || throwEnvironment "$handler" "$namedPipe not a named pipe" || return $?
      shift && catchEnvironment "$handler" printf "%s\n" "$*" >"$namedPipe" || return $?
      ;;
    *)
      if [ -n "$namedPipe" ]; then
        binary="$(validate "$handler" Callable "readerExecutable" "$argument")" || return $?
        break
      else
        namedPipe=$(validate "$handler" FileDirectory "namedPipe" "$argument") || return $?
      fi
      ;;
    esac
    shift
  done
  [ -n "$namedPipe" ] || throwArgument "$handler" "No namedPipe supplied" || return $?
  [ ! -p "$namedPipe" ] || throwEnvironment "$handler" "$namedPipe already exists ($binary)" || return $?
  catchEnvironment "$handler" mkfifo -m "$mode" "$namedPipe" || return $?
  # shellcheck disable=SC2064
  trap "rm -f \"$(quoteBashString "$namedPipe")\" 2>/dev/null 1>&2" EXIT INT HUP || :
  while read -r line; do
    if [ -n "$line" ]; then
      execute "$@" "$line" || break
    fi
  done <"$namedPipe"
  rm -f "$namedPipe" || :
}
_pipeRunner() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
