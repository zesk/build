#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Depends: colors.sh text.sh
#
# Docs: o ./documentation/source/tools/pipeline.md
# Test: o ./test/tools/pipeline-tests.sh

###############################################################################
#
# ░█▀█░▀█▀░█▀█░█▀▀░█░░░▀█▀░█▀█░█▀▀
# ░█▀▀░░█░░█▀▀░█▀▀░█░░░░█░░█░█░█▀▀
# ░▀░░░▀▀▀░▀░░░▀▀▀░▀▀▀░▀▀▀░▀░▀░▀▀▀
#
#------------------------------------------------------------------------------

# Summary: Output debugging information when the build fails
#
# Outputs debugging information after build fails:
#
# - last 50 lines in build log
# - Failed message
# - last 3 lines in build log
#
# Usage: buildFailed logFile
# Argument: logFile - File. Required. The most recent log from the current script.
# Argument: message - String. Optional. Any additional message to output.
#
# Example:     quietLog="$(buildQuietLog "$me")"
# Example:     if ! ./bin/deploy.sh >>"$quietLog"; then
# Example:         decorate error "Deploy failed"
# Example:         buildFailed "$quietLog"
# Example:     fi
# Return Code: 1 - Always fails
# Output: stdout
buildFailed() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0

  local quietLog="${1-}" && shift

  local failBar
  failBar="$(lineFill "*")"
  statusMessage --last decorate error "$failBar"
  bigText "Failed" | decorate error | decorate wrap "" " " | decorate wrap --fill "*" ""
  # shellcheck disable=SC2094
  statusMessage --last decorate error "$failBar"

  showLines=$(catchReturn "$handler" buildEnvironmentGet BUILD_DEBUG_LINES) || return $?

  isUnsignedInteger "$showLines" || showLines=$(($(consoleRows) - 16)) || showLines=40
  # shellcheck disable=SC2094
  dumpPipe --lines "$showLines" --tail "$(basename "$quietLog")" "$@" <"$quietLog"
  throwEnvironment "$handler" "Failed:" "$@" || return $?
}
_buildFailed() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# IDENTICAL versionSort 48

# Summary: Sort versions in the format v0.0.0
#
# Sorts semantic versions prefixed with a `v` character; intended to be used as a pipe.
#
# vXXX.XXX.XXX
#
# for sort - -k 1.c,1 - the `c` is the 1-based character index, so 2 means skip the 1st character
#
# Odd you can't globally flip sort order with -r - that only works with non-keyed entries I assume
#
# Argument: -r | --reverse - Reverse the sort order (optional)
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Example:    git tag | grep -e '^v[0-9.]*$' | versionSort
# Requires: throwArgument sort usageDocument
versionSort() {
  local handler="_${FUNCNAME[0]}"

  local reverse=""

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    -r | --reverse)
      reverse="r"
      ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done
  sort -t . -k "1.2,1n$reverse" -k "2,2n$reverse" -k "3,3n$reverse"
}
_versionSort() {
  # Fix SC2120
  ! false || versionSort --help
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Get the current IP address of a host
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Environment: IP_URL_FILTER - String. Optional. Filter for JSON to get IP - if blank returns remote contents directly.
ipLookup() {
  local handler="_${FUNCNAME[0]}"

  [ $# -eq 0 ] || __help --only "$handler" "$@" || return "$(convertValue $? 1 0)"
  local url jqFilter
  if ! packageWhich curl curl; then
    throwEnvironment "$handler" "Requires curl to operate" || return $?
  fi
  url=$(catchReturn "$handler" buildEnvironmentGet IP_URL) || return $?
  [ -n "$url" ] || throwEnvironment "$handler" "$(decorate value "IP_URL") is required for $(decorate code "${handler#_}")" || return $?
  jqFilter=$(catchReturn "$handler" buildEnvironmentGet IP_URL_FILTER) || return $?
  urlValid "$url" || throwEnvironment "$handler" "URL $(decorate error "$url") is not a valid URL" || return $?
  local pp=(cat)
  [ -z "$jqFilter" ] || pp=(jq "$jqFilter")
  catchEnvironment "$handler" curl -s "$url" | "${pp[@]}" || return $?
}
_ipLookup() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# For security one should update keys every N days
#
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
# Summary: Test whether the key needs to be updated
# Usage: {fn} [ --name name ] keyDate upToDateDays
# Argument: keyDate - Required. Date. Formatted like `YYYY-MM-DD`. Truncated at 10 characters as well.
# Argument: --name name - Optional. Name of the expiring item for error messages.
# Argument: upToDateDays - Required. Integer. Days that key expires after `keyDate`.
# Example:     if !isUpToDate "$AWS_ACCESS_KEY_DATE" 90; then
# Example:       bigText Failed, update key and reset date
# Example:       exit 99
# Example:     fi
#
isUpToDate() {
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
    --name)
      shift || :
      name="$1"
      ;;
    *)
      if [ -z "$keyDate" ]; then
        keyDate=$(usageArgumentString "$handler" "keyDate" "$argument") || return $?
      elif [ -z "$upToDateDays" ]; then
        upToDateDays=$(usageArgumentInteger "$handler" "upToDateDays" "$argument") || return $?
      else
        # _IDENTICAL_ argumentUnknownHandler 1
        throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      fi
      ;;
    esac
    shift || throwArgument "shift $argument" || return $?
  done
  [ -n "$keyDate" ] || throwArgument "$handler" "missing keyDate" || return $?
  [ -n "$upToDateDays" ] || upToDateDays=90

  keyDate="${keyDate:0:10}"
  [ -z "$name" ] || name="$name "

  local todayTimestamp
  todayTimestamp=$(dateToTimestamp "$(todayDate)") || throwEnvironment "$handler" "Unable to generate todayDate" || return $?

  local keyTimestamp maxDays

  keyTimestamp=$(dateToTimestamp "$keyDate") || throwArgument "$handler" "Invalid date $keyDate" || return $?
  isInteger "$upToDateDays" || throwArgument "$handler" "upToDateDays is not an integer ($upToDateDays)" || return $?

  maxDays=366
  [ "$upToDateDays" -le "$maxDays" ] || throwArgument "$handler" "isUpToDate $keyDate $upToDateDays - values not allowed greater than $maxDays" || return $?
  [ "$upToDateDays" -ge 0 ] || throwArgument "$handler" "isUpToDate $keyDate $upToDateDays - negative values not allowed" || return $?

  local expireDate
  local accessKeyTimestamp=$((keyTimestamp + ((23 * 60) + 59) * 60))
  local expireTimestamp=$((accessKeyTimestamp + 86400 * upToDateDays))
  expireDate=$(dateFromTimestamp "$expireTimestamp" '%A, %B %d, %Y %R')
  local deltaDays=$(((todayTimestamp - accessKeyTimestamp) / 86400))
  local daysAgo=$((deltaDays - upToDateDays))
  if [ "$todayTimestamp" -gt "$expireTimestamp" ]; then
    local label timeText
    label=$(printf "%s %s\n" "$(decorate error "${name}expired on ")" "$(decorate red "$keyDate")")
    case "$daysAgo" in
    0) timeText="Today" ;;
    1) timeText="Yesterday" ;;
    *) timeText="$(pluralWord $daysAgo day) ago" ;;
    esac
    labeledBigText --prefix "$(decorate reset --)" --top --tween "$(decorate red --)" "$label" "EXPIRED $timeText"
    return 1
  fi
  daysAgo=$((-daysAgo))
  if [ $daysAgo -lt 14 ]; then
    labeledBigText --prefix "$(decorate reset --)" --top --tween "$(decorate orange --)" "${name}expires on $(decorate code "$expireDate"), in " "$daysAgo $(plural $daysAgo day days)"
  elif [ $daysAgo -lt 30 ]; then
    # decorate info "keyDate $keyDate"
    # decorate info "accessKeyTimestamp $accessKeyTimestamp"
    # decorate info "expireDate $expireDate"
    printf "%s %s %s %s\n" \
      "$(decorate warning "${name}expires on")" \
      "$(decorate red "$expireDate")" \
      "$(decorate warning ", in")" \
      "$(decorate magenta "$(pluralWord $daysAgo day)")"
    return 0
  fi
  return 0
}
_isUpToDate() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
