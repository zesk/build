#!/usr/bin/env bash
#
# utilities.sh
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Test: o test/tools/utilities-tests.sh
# Docs: o docs/_templates/tools/utilities.md
#
# Tools which do not fit anywhere else
#

# Usage: {fn} [ count | variable ] ...
# Argument: count - Optional. Integer. Sets the value for any following named variables to this value.
# Argument: variable - Optional. String. Variable to change or increment.
# Argument: --reset - Optional. Flag. Reset all counters to zero.
#
# Set or increment a process-wide incrementor. If no numeric value is supplied the default is to increment the current value and output it.
# New values are set to 0 by default so will output `1` upon first usage.
# If no variable name is supplied it uses the default variable name `default`.
#
# Variable names can contain alphanumeric characters, underscore, or dash.
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
# Depends: buildCacheDirectory
# See: buildCacheDirectory
# shellcheck disable=SC2120
incrementor() {
  local this="${FUNCNAME[0]}"
  local usage="_$this"
  local argument cacheDirectory
  local name value persistence counterFile

  cacheDirectory=$(__usageEnvironment "$usage" buildCacheDirectory "$this/$$") || return $?
  persistence="$(__usageEnvironment "$usage" requireDirectory "$cacheDirectory")" || return $?
  name=""
  value=""
  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __failArgument "$usage" "blank #$__index/$__count: $(decorate each code "${__saved[@]}")" || return $?
    case "$argument" in
      # _IDENTICAL_ --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --reset)
        rm -rf "$persistence" || :
        return 0
        ;;
      *[^-_a-zA-Z0-9]*)
        __failArgument "$usage" "Invalid argument or variable name: $argument" || return $?
        ;;
      *)
        if isInteger "$argument"; then
          if [ -n "$name" ]; then
            __incrementor "$persistence/$name" "$value"
            name=
          fi
          value="$argument"
        else
          if [ -n "$name" ]; then
            __incrementor "$persistence/$name" "$value"
          fi
          name="$argument"
          [ -n "$name" ] || name=default
        fi
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift || __failArgument "$usage" "missing #$__index/$__count: $argument $(decorate each code "${__saved[@]}")" || return $?
  done
  [ -n "$name" ] || name=default
  __incrementor "$persistence/$name" "$value"
}
_incrementor() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: {fn} counterFile value
# When value is non-blank - write it to the counter file
# When value is blank - load it (if it exists), increment it, and then write it to the counter file
__incrementor() {
  local counterFile="$1" value="${2-}"
  if [ -z "$value" ]; then
    if [ -f "$counterFile" ]; then
      value="$(head -n 1 "$counterFile")"
    fi
    if ! isInteger "$value"; then
      value=0
    fi
    value=$((value + 1))
  fi
  printf -- "%d\n" "$value" | tee "$counterFile"
}

# Single reader, multiple writers
# Usage: {fn} [ --mode mode ] namedPipe [ --writer line | readerExecutable ... ]
pipeRunner() {
  local usage="_${FUNCNAME[0]}"

  local binary="" namedPipe="" mode="0700"

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __failArgument "$usage" "blank #$__index/$__count: $(decorate each code "${__saved[@]}")" || return $?
    case "$argument" in
      # _IDENTICAL_ --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --mode)
        shift
        mode=$(usageArgumentString "$usage" "mode" "${1-}") || return $?
        ;;
      --writer)
        [ -z "$namedPipe" ] || __failArgument "$usage" "No namedPipe supplied" || return $?
        [ -p "$namedPipe" ] || __failEnvironment "$usage" "$namedPipe not a named pipe" || return $?
        __usageEnvironment "$usage" printf "%s\n" "$*" >"$namedPipe" || return $?
        ;;
      *)
        if [ -n "$namedPipe" ]; then
          binary="$(usageArgumentCallable "$usage" "readerExecutable" "$argument")" || return $?
          break
        else
          namedPipe=$(usageArgumentFileDirectory "$usage" "namedPipe" "$argument") || return $?
        fi
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift || __failArgument "$usage" "missing #$__index/$__count: $argument $(decorate each code "${__saved[@]}")" || return $?
  done
  [ -n "$namedPipe" ] || __failArgument "$usage" "No namedPipe supplied" || return $?
  [ ! -p "$namedPipe" ] || __failEnvironment "$usage" "$namedPipe already exists ($binary)" || return $?
  __usageEnvironment "$usage" mkfifo -m "$mode" "$namedPipe" || return $?
  # shellcheck disable=SC2064
  trap "rm -f \"$(quoteBashString "$namedPipe")\" 2>/dev/null 1>&2" EXIT INT HUP || :
  while read -r line; do
    if [ -n "$line" ]; then
      __execute "$@" "$line" || break
    fi
  done <"$namedPipe"
  rm -f "$namedPipe" || :
}
_pipeRunner() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
