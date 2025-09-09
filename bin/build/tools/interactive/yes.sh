#!/usr/bin/env bash
#
# confirmYesNo implementation
#
# Copyright &copy; 2025 Market Acumen, Inc.

__confirmYesNo() {
  local handler="$1" && shift
  local default="no" message="" timeout="" extras="" attempts=-1

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # _IDENTICAL_ handlerHandler 1
    --handler) shift && handler=$(usageArgumentFunction "$handler" "$argument" "${1-}") || return $? ;;
    --info)
      extras=" $(decorate subtle "Type Y or N") "
      ;;
    --attempts)
      shift
      attempts=$(usageArgumentPositiveInteger "$handler" "$argument" "${1-}") || return $?
      ;;
    --timeout)
      shift
      timeout=$(usageArgumentPositiveInteger "$handler" "$argument" "${1-}") || return $?
      ;;
    --yes) default=yes ;;
    --no) default=no ;;
    --default)
      shift
      default="$(usageArgumentString "$handler" "$argument" "${1-}")" || return $?
      parseBoolean "$default" || [ $? -ne 2 ] || __throwArgument "$handler" "Can not parse $(decorate code "$1") as a boolean" || return $?
      ;;
    *)
      message="$*"
      break
      ;;
    esac
    shift
  done

  local exitCode=0

  while __interactiveCountdownReadBoolean "$handler" "$timeout" "$attempts" "$extras" "$message" || exitCode=$?; do
    case "$exitCode" in
    0 | 1)
      __confirmYesNo "$((exitCode - 1))"
      return $exitCode
      ;;
    2 | 10)
      reason="TIMEOUT"
      break
      ;;
    11)
      reason="ATTEMPTS"
      break
      ;;
    *)
      reason="UNKNOWN: $exitCode"
      break
      ;;
    esac
    exitCode=0
  done
  ___confirmYesNo "$default" "$reason" || return $?
}
___confirmYesNo() {
  local prefix="${2-}" exitCode=0

  [ -z "$prefix" ] || prefix="$(decorate error "$prefix") "

  parseBoolean "${1-}" || exitCode=$?
  case "$exitCode" in
  0) statusMessage printf -- "%s%s" "$prefix" "$(decorate success "Yes") $exitCode" ;;
  1) statusMessage printf -- "%s%s" "$prefix" "$(decorate warning "[ ** NO ** ]") $exitCode" ;;
  *) return 2 ;;
  esac
  return "$exitCode"
}
