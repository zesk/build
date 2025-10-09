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
  local handler="_${FUNCNAME[0]}"
  local home testCode

  __help "$handler" "${1-}" || return 0

  home=$(catchReturn "$handler" buildHome) || return $?

  for testCode in tools flags _assert assert mock junit; do
    testCode="$home/bin/build/tools/test/$testCode.sh"
    # shellcheck source=/dev/null
    source "$testCode" || throwEnvironment "$handler" "source $testCode" || return $?
  done
  catchEnvironment "$handler" isFunction testSuite || return $?

  [ $# -ne 0 ] || return 0
  isCallable "$1" || throwArgument "$handler" "$1 is not callable" || return $?
  catchEnvironment "$handler" "$@" || return $?
}
_testTools() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Dumps output as hex
# Depends: xxd
# apt-get: xxd
# stdin: binary
# stdout: formatted output set to ideal `consoleColumns`
dumpBinary() {
  local handler="_${FUNCNAME[0]}"

  local symbol="🔅" vanishFiles=() showBytes="" endBinary=tail names=()

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --vanish)
      shift
      vanishFiles+=("$(usageArgumentFile "$handler" "$argument" "${1-}")") || return $?
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
        showBytes=$(usageArgumentUnsignedInteger "$handler" "bytes" "$1") || return $?
      fi
      ;;
    *)
      names+=("$argument")
      break
      ;;
    esac
    shift || throwArgument "$handler" shift || return $?
  done

  local item
  if [ "${#vanishFiles[@]}" -gt 0 ]; then
    for item in "${vanishFiles[@]}"; do
      local name
      name=$(decorate file "$(basename "$item")" "$item")
      # Recursion - only when --vanish is a parameter
      catchEnvironment "$handler" dumpBinary --size "$showBytes" "${names[@]}" "$name" <"$item" || return $?
      catchEnvironment "$handler" rm -rf "$item" || return $?
    done
    return 0
  fi
  item=$(fileTemporaryName "$handler") || return $?
  catchEnvironment "$handler" cat >"$item" || return $?

  local name="" nLines nBytes
  [ ${#names[@]} -eq 0 ] || name=$(decorate info "${names[*]}: ")
  nLines=$(($(fileLineCount "$item") + 0))
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
    catchEnvironment "$handler" rm -rf "$item" || return $?
    return 0
  fi

  local endPreprocess=(cat)
  if [ -n "$showBytes" ]; then
    endPreprocess=("$endBinary" --bytes="$showBytes")
  fi
  catchEnvironment "$handler" "${endPreprocess[@]}" <"$item" | catchEnvironment "$handler" dumpHex | decorate code | decorate wrap "$symbol " || returnClean $? "$item" || return $?
  catchEnvironment "$handler" rm -rf "$item" || return $?
  return 0
}
_dumpBinary() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
