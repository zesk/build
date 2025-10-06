#!/usr/bin/env bash
#
# Documentation
#
# Copyright &copy; 2025 Market Acumen, Inc.

__interactiveCountdown() {
  local handler="$1" && shift

  local prefix="" counter="" binary="" runner=("statusMessage" "printf" -- "%s")

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --prefix)
      shift
      prefix="$(usageArgumentEmptyString "$handler" "$argument" "${1-}")" || return $?
      ;;
    --badge)
      runner=(bigTextAt "-5" "5")
      ;;
    *)
      if [ -z "$counter" ]; then
        counter=$(usageArgumentPositiveInteger "$handler" "counter" "$1") || return $?
      else
        binary=$(usageArgumentCallable "$handler" "callable" "$1") || return $?
        break
      fi
      ;;
    esac
    shift
  done
  [ -n "$counter" ] || throwArgument "$handler" "counter is required" || return $?

  local start end now

  start=$(timingStart) || return $?
  end=$((start + counter * 1000))
  now=$start
  [ -z "$prefix" ] || prefix="$prefix "

  while [ "$now" -lt "$end" ]; do
    catchEnvironment "$handler" "${runner[@]}" "$(printf "%s%s" "$(decorate info "$prefix")" "$(decorate value " $((counter / 1000)) ")")" || return $?
    sleep 1 || throwEnvironment "$handler" "Interrupted" || return $?
    now=$(timingStart) || return $?
    counter=$((end - now))
  done
  statusMessage printf -- "%s" ""
  if [ -n "$binary" ]; then
    catchReturn "$handler" "$@" || return $?
  fi
}

# Maybe move this to its own thing if needed later
# handler: {fn} handler timeout attempts extras message parser
# Argument: handler - Function. Error handler
# Argument: timeout - UnsignedInteger|Empty. Milliseconds to time out after.
# Argument: attempts - Integer. Number ot attempts to allow.
# Argument: extras - EmptyString. Extra text to add to the prompt.
# Argument: message - EmptyString. The message to show to prompt the user.
# Argument: parser ... - Function. Function to call to check the input if it's valid and arguments to add.
# Return Code: 10 - Timeout
# Return Code: 11 - Attempts ran out
# Return Code: 0 - All good, print character
# Return Code: 1 - Error
# Return Code: 2 - Error
__interactiveCountdownReadCharacter() {
  local handler="$1" && shift
  local timeout="" rr=() extras icon="⏳" attempts prompt width=0

  if [ "$1" != "" ]; then
    rr=(-t 1)
    timeout=$(usageArgumentPositiveInteger "$handler" "timeout" "${1-}") || return $?
    width="$timeout"
    width="${#width}"
    # milliseconds
    timeout=$((timeout * 1000))
  fi
  shift

  attempts=$(usageArgumentInteger "$handler" "attempts" "${1-}") && shift || return $?

  extras="${1-}" && shift

  local value start elapsed=0 message="$1" counter=1 prefix="" timingSuffix="" && shift
  local parser="$1" && shift

  start=$(timingStart)

  # IDENTICAL __interactiveCountdownReadBooleanStatus 3
  [ "$attempts" -le 1 ] || prefix="$(decorate value "[ 🧪 $counter of $attempts ]") "
  [ "$timeout" = "" ] || timingSuffix="$(printf " %s %s" "$icon" "$(alignRight "$width" "$(((timeout - elapsed + 500) / 1000))")")"
  prompt=$(printf -- "%s%s%s%s" "$prefix" "$message" "$extras" "$timingSuffix")

  while true; do
    statusMessage printf -- ""
    while ! value=$(bashUserInput -p "$prompt" -n 1 -s "${rr[@]+"${rr[@]}"}"); do
      if [ -z "$timeout" ]; then
        return 2
      fi
      elapsed=$(($(timingStart) - start))
      if [ "$elapsed" -gt "$timeout" ]; then
        return 10
      fi
      # IDENTICAL __interactiveCountdownReadBooleanStatus 3
      [ "$attempts" -le 1 ] || prefix="$(decorate value "[ 🧪 $counter of $attempts ]") "
      [ "$timeout" = "" ] || timingSuffix="$(printf " %s %s" "$icon" "$(alignRight "$width" "$(((timeout - elapsed + 500) / 1000))")")"
      prompt=$(printf -- "%s%s%s%s" "$prefix" "$message" "$extras" "$timingSuffix")
      statusMessage printf -- ""
    done
    statusMessage printf -- ""
    if [ -n "$value" ] && "$parser" "$value" "$@"; then
      return 0
    fi
    counter=$((counter + 1))
    if [ "$attempts" -gt 0 ]; then
      if [ $counter -gt "$attempts" ]; then
        return 11
      fi
      # IDENTICAL __interactiveCountdownReadBooleanStatus 3
      [ "$attempts" -le 1 ] || prefix="$(decorate value "[ 🧪 $counter of $attempts ]") "
      [ "$timeout" = "" ] || timingSuffix="$(printf " %s %s" "$icon" "$(alignRight "$width" "$(((timeout - elapsed + 500) / 1000))")")"
      prompt=$(printf -- "%s%s%s%s" "$prefix" "$message" "$extras" "$timingSuffix")
    fi
  done
  return 1
}
