#!/usr/bin/env bash
#
# dump output for debugging or review
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Docs: ./documentation/source/tools/dump.md
# Test: ./test/tools/dump-tests.sh

#
# Usage: {fn} [ -x ]
#
# Dump the function and include stacks and the current environment
# Argument: -x - Optional. Flag. Show exported variables. (verbose)
# Requires: printf usageDocument
# BUILD_DEBUG: debuggingStack - `debuggingStack` shows arguments passed (extra) and exports (optional flag) ALWAYS
debuggingStack() {
  local usage="_${FUNCNAME[0]}"

  local index count sources=() showExports=false addMe=false

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ --help 4
    --help)
      "$usage" 0
      return $?
      ;;
    -x)
      showExports=true
      ;;
    --me)
      addMe=true
      ;;
    *)
      # _IDENTICAL_ argumentUnknown 1
      __throwArgument "$usage" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
      ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  if buildDebugEnabled debuggingStack; then
    showExports=true
    addMe=true
    printf -- "ARGS\n: %s %s\n" "${FUNCNAME[0]}" "$(decorate each quote "${__saved[@]+"${__saved[@]}"}" <&-)"
  fi

  sources=()
  count=${#FUNCNAME[@]}
  index=0
  # An array variable whose members are the line numbers in source files where each corresponding member of FUNCNAME was invoked.
  # ${BASH_LINENO[$i]} is the line number in the source file (${BASH_SOURCE[$i+1]}) where ${FUNCNAME[$i]} was called.
  #
  while [ "$index" -lt "$count" ]; do
    sources+=("${BASH_SOURCE[index + 1]-}:${BASH_LINENO[index]-"$LINENO"} - ${FUNCNAME[index]-}")
    index=$((index + 1))
  done
  if $addMe; then
    sources+=("${BASH_SOURCE[0]}:$LINENO - ${FUNCNAME[0]} (ME)")
  fi
  ! $showExports || printf -- "STACK:\n"
  __debuggingStackCodeList "${sources[@]}" || :
  if $showExports; then
    printf -- "EXPORTS:\n"
    declare -px | removeFields 2
  fi
}
_debuggingStack() {
  true || debuggingStack --help
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Internal: true
# Utility function for debuggingStack
# See: debuggingStack
# Requires: printf
__debuggingStackCodeList() {
  local tick item index
  tick='`'
  index=0
  for item in "$@"; do
    printf -- '%d. %s%s%s\n' "$(($# - index))" "$tick" "$item" "$tick"
    index=$((index + 1))
  done
}

# Dump a pipe with a title and stats
# Argument: --symbol symbol - Optional. String. Symbol to place before each line. (Blank is ok).
# Argument: --tail - Optional. Flag. Show the tail of the file and not the head when not enough can be shown.
# Argument: --head - Optional. Flag. Show the head of the file when not enough can be shown. (default)
# Argument: --lines - Optional. UnsignedInteger. Number of lines to show.
# Argument: --vanish file - Optional. UnsignedInteger. Number of lines to show.
# Argument: name - Optional. String. The item name or title of this output.
# stdin: text
# stdout: formatted text for debugging
dumpPipe() {
  local usage="_${FUNCNAME[0]}"

  local showLines="" endBinary="head" names=() symbol="🐞" vanishFiles=()

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ --help 4
    --help)
      "$usage" 0
      return $?
      ;;
    --head)
      endBinary="head"
      ;;
    --vanish)
      shift
      vanishFiles+=("$(usageArgumentFile "$usage" "$argument" "${1-}")") || return $?
      ;;
    --tail)
      endBinary="tail"
      ;;
    --symbol)
      shift || __throwArgument "$usage" "missing $argument argument" || return $?
      symbol="$1"
      ;;
    --lines)
      shift || __throwArgument "$usage" "missing $argument argument" || return $?
      showLines=$(usageArgumentUnsignedInteger "$usage" "showLines" "$1") || return $?
      ;;
    *)
      names+=("$argument")
      break
      ;;
    esac
    shift || __throwArgument "$usage" shift || return $?
  done

  if [ -z "$showLines" ]; then
    export BUILD_DEBUG_LINES
    __catchEnvironment "$usage" buildEnvironmentLoad BUILD_DEBUG_LINES || return $?
    showLines="${BUILD_DEBUG_LINES:-100}"
    isUnsignedInteger "$showLines" || _environment "BUILD_DEBUG_LINES is not an unsigned integer: $showLines" || showLines=10
  fi

  local item
  if [ "${#vanishFiles[@]}" -gt 0 ]; then
    for item in "${vanishFiles[@]}"; do
      local name
      name=$(decorate file "$(basename "$item")" "$item")
      # Recursion - only when --vanish is a parameter
      __catchEnvironment "$usage" dumpPipe "--${endBinary}" --lines "$showLines" "${names[@]+"${names[@]}"}" "$name" <"$item" || return $?
      __catchEnvironment "$usage" rm -rf "$item" || return $?
    done
    return 0
  fi
  item=$(fileTemporaryName "$usage") || return $?
  __catchEnvironment "$usage" cat >"$item" || return $?

  local name="" nLines nBytes
  [ ${#names[@]} -eq 0 ] || name=$(decorate info "${names[*]}: ") || :
  nLines=$(($(wc -l <"$item") + 0))
  nBytes=$(($(wc -c <"$item") + 0))
  [ ${#symbol} -eq 0 ] || symbol="$symbol "
  if [ $nBytes -eq 0 ]; then
    suffix=$(decorate orange "(empty)")
  elif [ "$showLines" -lt "$nLines" ]; then
    suffix="$(decorate warning "(showing $showLines $(plural "$showLines" line lines))")"
  else
    suffix="$(decorate success "(shown)")"
  fi
  # shellcheck disable=SC2015
  statusMessage --last printf -- "%s%s %s, %s %s %s" \
    "$name" \
    "$nLines" "$(plural "$nLines" line lines)" \
    "$nBytes" "$(plural "$nBytes" byte bytes)" \
    "$suffix"
  if [ $nBytes -eq 0 ]; then
    rm -rf "$item" || :
    return 0
  fi

  local decoration width
  decoration="$(decorate code "$(echoBar)")"
  width=$(consoleColumns) || __throwEnvironment "$usage" consoleColumns || return $?
  printf -- "%s\n%s\n%s\n" "$decoration" "$("$endBinary" -n "$showLines" "$item" | decorate wrap --width "$((width - 1))" --fill " " "$symbol" "$(decorate reset --)")" "$decoration"
  rm -rf "$item" || :
}
_dumpPipe() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Output a file for debugging
#
# Usage: {fn} fileName0 [ fileName1 ... ]
# stdin: text (optional)
# stdout: formatted text (optional)
dumpFile() {
  local usage="_${FUNCNAME[0]}"
  local files=() dumpArgs=()

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ --help 4
    --help)
      "$usage" 0
      return $?
      ;;
    --symbol)
      shift || __throwArgument "$usage" "shift $argument" || return $?
      dumpArgs+=("$argument" "$1")
      ;;
    --lines)
      shift || __throwArgument "$usage" "missing $argument argument" || return $?
      dumpArgs+=("--lines" "$1")
      ;;
    *)
      [ -f "$argument" ] || __throwArgument "$usage" "$argument is not a item" || return $?
      files+=("$argument")
      __throwArgument "$usage" "unknown argument: $argument" || return $?
      ;;
    esac
    shift || __throwArgument "$usage" shift || return $?
  done

  if [ ${#files[@]} -eq 0 ]; then
    __catchEnvironment "$usage" dumpPipe "${dumpArgs[@]+${dumpArgs[@]}}" "(stdin)" || return $?
  else
    for tempFile in "${files[@]}"; do
      # shellcheck disable=SC2094
      __catchEnvironment "$usage" dumpPipe "${dumpArgs[@]+${dumpArgs[@]}}" "$tempFile" <"$tempFile" || return $?
    done
  fi
}
__dumpFile() {
  local exitCode="$1" tempFile="$2"
  shift 2 || _argument "${FUNCNAME[0]} shift 2" || :
  __environment rm -rf "$tempFile" || :
  _dumpFile "$exitCode" "$@"
}
_dumpFile() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Internal dumpEnvironmentUnsafe used for both
#
# Argument: handler - Function. Required. First argument! If an environment variable matches any case-insensitive part of this string, then hide it. If nothing specified, uses a `secret` `key` and `password`. If one value is specified the list is reset to zero. To show all variables pass a blank or `-` value here.
# Argument: --secure-match matchString - String. Optional. If an environment variable matches any case-insensitive part of this string, then hide it. If nothing specified, uses a `secret` `key` and `password`. If one value is specified the list is reset to zero. To show all variables pass a blank or `-` value here.
# Argument: --maximum-length maximumLength - PositiveInteger. Optional. The maximum number of characters to output for each environment variable.
# Argument: --secure-suffix secureSuffix  - EmptyString. Optional. Suffix to display after hidden arguments.
# Argument: --skip-env environmentVariable - EnvironmentVariable. Optional. Skip this environment variable (must match exactly).
# Argument: --show-skipped - Flag. Show skipped environment variables.
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
__internalDumpEnvironment() {
  local usage="$1" && shift

  local maxLen=64 skipEnv=() name matches=() fillMatches=true secureSuffix="- HIDDEN" showSkipped=false

  while read -r name; do
    if ! inArray "$name" PATH HOME OSTYPE PWD TERM; then
      skipEnv+=("$name")
    fi
  done < <(environmentSecureVariables) || :

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ --help 4
    --help)
      "$usage" 0
      return $?
      ;;
    --show-skipped)
      showSkipped=true
      ;;
    --maximum-length)
      shift
      maxLen=$(usageArgumentPositiveInteger "$usage" "$argument" "${1-}") || return $?
      ;;
    --skip-env)
      shift
      skipEnv+=("$(usageArgumentEnvironmentVariable "$usage" "$argument" "${1-}")") || return $?
      ;;
    --secure-match)
      shift
      case "${1-}" in
      "" | "-" | "--")
        matches=()
        fillMatches=false
        ;;
      *)
        matches+=("${1-}")
        ;;
      esac
      ;;
    --secure-suffix)
      shift
      secureSuffix="${1-}"
      ;;
    *)
      # _IDENTICAL_ argumentUnknown 1
      __throwArgument "$usage" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
      ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  if "$fillMatches" && [ ${#matches[@]} -eq 0 ]; then
    matches=(key secret password)
  fi

  local secures=() regulars=() blanks=() skipped=()

  while read -r name; do
    if [ ${#skipEnv[@]} -gt 0 ] && inArray "$name" "${skipEnv[@]}"; then
      skipped+=("$name")
      continue
    fi
    local value="${!name-}"
    if [ ${#matches[@]} -gt 0 ] && stringContainsInsensitive "$name" "${matches[@]}"; then
      secures+=("$name")
    else
      if [ -n "$value" ]; then
        regulars+=("$name")
      else
        blanks+=("$name")
      fi
    fi
  done < <(environmentVariables | sort -u)

  [ ${#regulars[@]} -eq 0 ] || for name in "${regulars[@]}"; do
    local value="${!name-}"
    local len=${#value}
    [ "$len" -lt "$maxLen" ] || value="${value:0:$maxLen} ... $(decorate green "$len $(plural "$len" "character" "characters")")"
    decorate pair "$name" "$(newlineHide "$value" "$(decorate green "␤")")"
  done
  [ ${#blanks[@]} -eq 0 ] || decorate pair "[BLANK VARIABLES]" "$(decorate each code "${blanks[@]}")"
  ! $showSkipped || [ ${#skipped[@]} -eq 0 ] || decorate pair "[SKIPPED VARIABLES]" "$(decorate each code "${skipped[@]}")"
  [ ${#secures[@]} -eq 0 ] || for name in "${secures[@]}"; do
    local value="${!name-}"
    local len=${#value}
    decorate pair "$name" "$(decorate red "$len $(plural "$len" "character" "characters") $secureSuffix")"
  done
}

# Output the environment but try to hide secure value
#
# Argument: --maximum-length maximumLength - PositiveInteger. Optional. The maximum number of characters to output for each environment variable.
# Argument: --skip-env environmentVariable - EnvironmentVariable. Optional. Skip this environment variable (must match exactly).
# Argument: --show-skipped - Flag. Show skipped environment variables.
# Argument: --secure-match matchString - String. Optional. If an environment variable matches any case-insensitive part of this string, then hide it. If nothing specified, uses a `secret` `key` and `password`. If one value is specified the list is reset to zero. To show all variables pass a blank or `-` value here.
# Argument: --secure-suffix secureSuffix  - EmptyString. Optional. Suffix to display after hidden arguments.
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
dumpEnvironment() {
  local usage="_${FUNCNAME[0]}"
  __internalDumpEnvironment "$usage" "$@" || return $?
}
_dumpEnvironment() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Output the environment shamelessly (not secure, not recommended)
#
# Argument: --maximum-length maximumLength - PositiveInteger. Optional. The maximum number of characters to output for each environment variable.
# Argument: --skip-env environmentVariable - EnvironmentVariable. Optional. Skip this environment variable (must match exactly).
# Argument: --show-skipped - Flag. Show skipped environment variables.
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
dumpEnvironmentUnsafe() {
  local usage="_${FUNCNAME[0]}" argument
  [ $# -eq 0 ] || for argument in "--secure-match" "--secure-suffix"; do
    ! inArray "$argument" "$@" || __throwArgument "$usage" "Unknown $argument (did you mean dumpEnvironment?)" || return $?
  done
  # Disable the secure features by putting them at the end
  __internalDumpEnvironment "$usage" "$@" --secure-match - --secure-suffix ""
}
_dumpEnvironmentUnsafe() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Print the load averages
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
dumpLoadAverages() {
  local usage="_${FUNCNAME[0]}"

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ --help 4
    --help)
      "$usage" 0
      return $?
      ;;
    *)
      # _IDENTICAL_ argumentUnknown 1
      __throwArgument "$usage" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
      ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  local averages=()
  IFS=$'\n' read -d '' -r -a averages < <(__catchEnvironment "$usage" loadAverage) || :
  __catchEnvironment "$usage" decorate pair "Load averages:" "$(decorate each code "${averages[@]+"${averages[@]}"}")" || return $?
}
_dumpLoadAverages() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Output to hex
# Argument: --size size - Integer. Output at most size bytes of data.
dumpHex() {
  local usage="_${FUNCNAME[0]}"

  local size="" arguments=()
  local runner=(od -w32 -A n -t xz -v)
  local runner=(od -t xCc)

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ --help 4
    --help)
      "$usage" 0
      return $?
      ;;
    --size)
      shift
      size=$(usageArgumentPositiveInteger "$usage" "$argument" "${1-}") || return $?
      runner+=("-N" "$size")
      ;;
    *)
      arguments+=("$argument")
      ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  whichExists od || __throwEnvironment "$usage" "od required to be installed" || return $?

  if [ "${#arguments[@]}" -eq 0 ]; then
    "${runner[@]}"
  else
    local argument
    for argument in "${arguments[@]}"; do
      "${runner[@]}" <<<"$argument"
    done
  fi
}
_dumpHex() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
