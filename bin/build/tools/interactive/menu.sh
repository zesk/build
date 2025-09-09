#!/usr/bin/env bash
#
# confirmMenu implementation
#
# Copyright &copy; 2025 Market Acumen, Inc.

__confirmMenu() {
  local handler="$1" && shift
  local default="" message="" timeout="" extras="" attempts=-1 allowed=() resultFile=""

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --prompt)
      shift
      extras=$(usageArgumentString "$handler" "$argument" "${1-}") || return $?
      extras=" $(decorate subtle "$extras") "
      ;;
    --result)
      shift
      resultFile=$(usageArgumentFile "$handler" "$argument" "${1-}") || return $?
      ;;
    --attempts)
      shift
      attempts=$(usageArgumentPositiveInteger "$handler" "$argument" "${1-}") || return $?
      ;;
    --timeout)
      shift
      timeout=$(usageArgumentPositiveInteger "$handler" "$argument" "${1-}") || return $?
      ;;
    --choice)
      shift
      allowed+=("$(usageArgumentString "$handler" "$argument" "${1-}")") || return $?
      ;;
    --default)
      shift
      default="$(usageArgumentString "$handler" "$argument" "${1-}")" || return $?
      ;;
    -*)
      # _IDENTICAL_ argumentUnknownHandler 1
      __throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    *)
      message="$*"
      break
      ;;
    esac
    shift
  done

  [ "${#allowed[@]}" -gt 0 ] || __throwArgument "$handler" "Need at least one --choice" || return $?
  [ -z "$default" ] || inArray "$default" "${allowed[@]}" || __throwArgument "$handler" "Default $default is not in menu: ${allowed[*]}" || return $?
  [ -n "$resultFile" ] || __throwArgument "$handler" "No --result given" || return $?

  local exitCode=0 value="" defaultOk=false

  while __interactiveCountdownReadCharacter "$handler" "$timeout" "$attempts" "$extras" "$message" __confirmMenuValidate "$resultFile" "${allowed[@]}" || exitCode=$?; do
    case "$exitCode" in
    0)
      return $exitCode
      ;;
    2 | 10)
      value="TIMEOUT"
      defaultOk=true
      exitCode=$(returnCode timeout)
      break
      ;;
    1 | 11)
      value="ATTEMPTS"
      defaultOk=true
      exitCode=$(returnCode interrupt)
      break
      ;;
    *)
      value="UNKNOWN: $exitCode"
      break
      ;;
    esac
    exitCode=0
  done
  if $defaultOk && [ -n "$default" ]; then
    value="$default"
    exitCode=0
  fi
  printf "%s\n" "$value" >"$resultFile"
  return $exitCode
}

__confirmMenuValidate() {
  local value="$1" result="$2" && shift 2
  if inArray "$value" "$@"; then
    printf "%s\n" "$value" >"$result"
    return 0
  fi
  return 1
}
