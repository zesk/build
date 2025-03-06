#!/usr/bin/env bash
#
# test.sh
#
# Test support functions
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

#
# Load test tools and make `testSuite` function available
#
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: binary - Optional. Callable. Run this program after loading test tools.
# Argument: ... - Optional. Arguments for binary.
#
testTools() {
  local usage="_${FUNCNAME[0]}"
  local home testCode

  __help "$usage" "$@" || return 0

  home=$(__catchEnvironment "$usage" buildHome) || return $?

  for testCode in tools _assert assert mock; do
    testCode="$home/bin/build/tools/test/$testCode.sh"
    # shellcheck source=/dev/null
    source "$testCode" || __throwEnvironment "$usage" "source $testCode" || return $?
  done
  __catchEnvironment "$usage" isFunction testSuite || return $?

  [ $# -ne 0 ] || return 0
  isCallable "$1" || __throwArgument "$usage" "$1 is not callable" || return $?
  __environment "$@" || return $?
}
_testTools() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Dumps output as hex
# Depends: xxd
# apt-get: xxd
# stdin: binary
# stdout: formatted output set to ideal `consoleColumns`
dumpBinary() {
  local usage="_${FUNCNAME[0]}"

  local symbol="🔅" vanishFiles=() showBytes="" endBinary=tail names=()

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
      --vanish)
        shift
        vanishFiles+=("$(usageArgumentFile "$usage" "$argument" "${1-}")") || return $?
        ;;
      --head)
        endBinary="head"
        ;;
      --tail)
        endBinary="tail"
        ;;
      --symbol)
        shift
        symbol="$1"
        ;;
      --bytes)
        shift
        # Allow BLANK
        if [ -n "$1" ]; then
          showBytes=$(usageArgumentUnsignedInteger "$usage" "bytes" "$1") || return $?
        fi
        ;;
      *)
        names+=("$argument")
        break
        ;;
    esac
    shift || __throwArgument "$usage" shift || return $?
  done

  local columns
  # Is this installed by default?
  __catchEnvironment "$usage" muzzle packageWhich xxd xxd || return $?
  columns=$(__catchEnvironment "$usage" consoleColumns) || return $?

  local item
  if [ "${#vanishFiles[@]}" -gt 0 ]; then
    for item in "${vanishFiles[@]}"; do
      local name
      name=$(decorate file "$(basename "$item")" "$item")
      # Recursion - only when --vanish is a parameter
      __catchEnvironment "$usage" dumpBinary --size "$showBytes" "${names[@]}" "$name" <"$item" || return $?
      __catchEnvironment "$usage" rm -rf "$item" || return $?
    done
    return 0
  fi
  item=$(fileTemporaryName "$usage") || return $?
  __catchEnvironment "$usage" cat >"$item" || return $?

  local name="" nLines nBytes
  [ ${#names[@]} -eq 0 ] || name=$(decorate info "${names[*]}: ")
  nLines=$(($(wc -l <"$item") + 0))
  nBytes=$(($(wc -c <"$item") + 0))
  [ ${#symbol} -eq 0 ] || symbol="$symbol "
  if [ $nBytes -eq 0 ]; then
    suffix=$(decorate orange "(empty)")
  elif [ -n "$showBytes" ] && [ "$showBytes" -lt "$nBytes" ]; then
    suffix="$(decorate warning "(showing $showBytes $(plural "$showBytes" byte bytes))")"
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
    __catchEnvironment "$usage" rm -rf "$item" || return $?
    return 0
  fi

  local endPreprocess=(cat)
  if [ -n "$showBytes" ]; then
    endPreprocess=("$endBinary" --bytes="$showBytes")
  fi
  __catchEnvironment "$usage" "${endPreprocess[@]}" <"$item" | __catchEnvironment "$usage" xxd -c "$((columns / 4))" | wrapLines "$symbol $(decorate code)" "$(decorate reset)" || _clean $? "$item" || return $?
  __catchEnvironment "$usage" rm -rf "$item" || return $?
  return 0
}
_dumpBinary() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
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
  printf -- "%s\n%s\n%s\n" "$decoration" "$("$endBinary" -n "$showLines" "$item" | wrapLines --width "$((width - 1))" --fill " " "$symbol" "$(decorate reset)")" "$decoration"
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
