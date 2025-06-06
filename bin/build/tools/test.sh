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
  __catchEnvironment "$usage" "${endPreprocess[@]}" <"$item" | __catchEnvironment "$usage" dumpHex | decorate code | decorate wrap "$symbol " || _clean $? "$item" || return $?
  __catchEnvironment "$usage" rm -rf "$item" || return $?
  return 0
}
_dumpBinary() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
