#!/usr/bin/env bash
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
# Depends: colors.sh text.sh
#
# Docs: o ./documentation/source/tools/decorate.md
# Test: o ./test/tools/decorate-tests.sh

# fn: decorate expired
# Summary: Utility to display key expiration
# For security one should update keys every ... number of days.
#
# f.k.a. `is``UpToDate`
# This value would be better encrypted and tied to the key itself so developers
# can not just update the value to avoid the security issue.
#
# This tool checks the value and checks if it is `upToDateDays` of today; if not this fails.
#
# It will also fail if:
#
# - `upToDateDays` is less than zero or greater than 366
# - `keyDate` is empty or has an invalid value
#
# Otherwise, the tool *may* output a message to the console warning of pending days, and returns exit code 0 if the `keyDate` has not exceeded the number of days.
#
# Outputs a big text message as it gets closer.
#
# Summary: Test whether the key needs to be updated
# Argument: keyDate - Date. Required. Formatted like `YYYY-MM-DD`. Truncated at 10 characters as well.
# Argument: upToDateDays - Integer. Required. Days that key expires after `keyDate`.
# Argument: --name name - String. Optional. Name of the expiring item for error messages.
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Example:     if !decorate expired "$AWS_ACCESS_KEY_DATE" 90; then
# Example:       decorate big Failed, update key and reset date
# Example:       exit 99
# Example:     fi
# See: dateWithinDays
__decorateExtensionExpired() {
  local handler="_${FUNCNAME[0]}"

  local name="Key" keyDate="" upToDateDays=""
  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --name) shift || name=$(validate "$handler" EmptyString "$argument" "${1-}") || return $? ;;
    *)
      if [ -z "$keyDate" ]; then
        keyDate=$(validate "$handler" Date "keyDate" "$argument") || return $?
      elif [ -z "$upToDateDays" ]; then
        upToDateDays=$(validate "$handler" UnsignedInteger "upToDateDays" "$argument") || return $?
      else
        # _IDENTICAL_ argumentUnknownHandler 1
        throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      fi
      ;;
    esac
    shift
  done
  [ -n "$keyDate" ] || throwArgument "$handler" "missing keyDate" || return $?
  [ -n "$upToDateDays" ] || upToDateDays=90
  [ -z "$name" ] || name="$name "

  local tempResults && tempResults=$(fileTemporaryName "$handler") || return $?
  local withinDays=0 && dateWithinDays "$keyDate" "$upToDateDays" >"$tempResults" || withinDays=$?
  [ "$withinDays" -le 1 ] || returnClean "$withinDays" "$tempResults" || return "$withinDays"
  local expireDays expireTimestamp && read -r expireDays expireTimestamp <"$tempResults" || :
  catchReturn "$handler" rm -rf "$tempResults" || return $?
  if ! isInteger "$expireDays"; then
    throwArgument "$handler" "Unable to compute expire days: \"$keyDate\" \"$upToDateDays\" $expireDays $expireTimestamp " || return $?
  fi
  local absDays=$expireDays && [ "$expireDays" -gt 0 ] || absDays=$((-expireDays))
  local timePastSuffix=" ago" timeText && timeText="$(timingDuration --stop day "$((absDays * 24 * 60 * 60 * 1000))")"
  case "$expireDays" in 0) timeText="Today" && timePastSuffix="" ;; "-1") timeText="Yesterday" && timePastSuffix="" ;; esac
  if [ $withinDays -ne 0 ]; then
    local label && label=$(printf "%s %s\n" "$(decorate error "${name}expired on ")" "$(decorate red "$keyDate")")
    labeledBigText --prefix "$(decorate reset --)" --top --tween "$(decorate red --)" "$label" "EXPIRED $timeText$timePastSuffix"
    return 1
  fi

  local expireDate && expireDate=$(dateFromTimestamp "$expireTimestamp" '%A, %B %d, %Y %R')
  local header && header="$(decorate warning "${name}expires on")"
  if [ "$expireDays" -lt 14 ]; then
    local reset && reset=$(decorate reset --)
    labeledBigText --prefix "$reset" --top --tween "$(decorate orange --)" "$header $(decorate code "$expireDate"), in " "$timeText"
  elif [ "$expireDays" -lt 30 ]; then
    # decorate info "keyDate $keyDate"
    # decorate info "accessKeyTimestamp $accessKeyTimestamp"
    # decorate info "expireDate $expireDate"
    printf "%s %s %s %s\n" \
      "$(decorate warning "${name}expires on")" \
      "$(decorate red "$expireDate")" \
      "$(decorate warning ", in")" \
      "$(decorate magenta "$timeText")"
    return 0
  fi
  return 0

  #  local todayTimestamp
  #  todayTimestamp=$(dateToTimestamp "$(dateToday)") || throwEnvironment "$handler" "Unable to generate dateToday" || return $?
  #
  #  local keyTimestamp maxDays
  #
  #  keyTimestamp=$(dateToTimestamp "$keyDate") || throwArgument "$handler" "Invalid date $keyDate" || return $?
  #  isInteger "$upToDateDays" || throwArgument "$handler" "upToDateDays is not an integer ($upToDateDays)" || return $?
  #
  #  maxDays=366
  #  [ "$upToDateDays" -le "$maxDays" ] || throwArgument "$handler" "decorate expired $keyDate $upToDateDays - values not allowed greater than $maxDays" || return $?
  #  [ "$upToDateDays" -ge 0 ] || throwArgument "$handler" "decorate expired $keyDate $upToDateDays - negative values not allowed" || return $?
  #
  #  local expireDate
  #  local accessKeyTimestamp=$((keyTimestamp + ((23 * 60) + 59) * 60))
  #  local expireTimestamp=$((accessKeyTimestamp + 86400 * upToDateDays))
  #  expireDate=$(dateFromTimestamp "$expireTimestamp" '%A, %B %d, %Y %R')
  #  local deltaDays=$(((todayTimestamp - accessKeyTimestamp) / 86400))
  #  local expireDays=$((deltaDays - upToDateDays))
  #  if [ "$todayTimestamp" -gt "$expireTimestamp" ]; then
  #    local label timeText
  #    label=$(printf "%s %s\n" "$(decorate error "${name}expired on ")" "$(decorate red "$keyDate")")
  #    case "$expireDays" in
  #    0) timeText="Today" ;;
  #    1) timeText="Yesterday" ;;
  #    *) timeText="$(localePluralWord $expireDays day) ago" ;;
  #    esac
  #    labeledBigText --prefix "$(decorate reset --)" --top --tween "$(decorate red --)" "$label" "EXPIRED $timeText"
  #    return 1
  #  fi
  #  expireDays=$((-expireDays))
  #
}
___decorateExtensionExpired() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
