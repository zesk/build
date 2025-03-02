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
# Argument: logFile - the most recent log from the current script
#
# Example:     quietLog="$(buildQuietLog "$me")"
# Example:     if ! ./bin/deploy.sh >>"$quietLog"; then
# Example:         decorate error "Deploy failed"
# Example:         buildFailed "$quietLog"
# Example:     fi
# Exit Code: 1 - Always fails
# Output: stdout
buildFailed() {
  local quietLog="${1-}" showLines=100 failBar

  shift
  failBar="$(decorate reset)$(decorate magenta "$(repeat 80 "❌")")"
  statusMessage printf -- "%s"
  bigText "Failed" | wrapLines "    " "  " | wrapLines --fill "*" "" "$(decorate error)" "$(decorate reset)"
  # shellcheck disable=SC2094
  statusMessage --last printf -- "\n%s\n%s\n" \
    "$failBar" \
    "$(dumpPipe --tail "$(basename "$quietLog")" "$@" --lines "$showLines" <"$quietLog")"
  _environment "Build failed:" "$@" || return $?
}

# IDENTICAL versionSort 51

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
# Requires: __throwArgument sort usageDocument
versionSort() {
  local usage="_${FUNCNAME[0]}"

  local reverse=""

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
      -r | --reverse)
        reverse="r"
        ;;
      *)
        # _IDENTICAL_ argumentUnknown 1
        __throwArgument "$usage" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done
  sort -t . -k "1.2,1n$reverse" -k "2,2n$reverse" -k "3,3n$reverse"
}
_versionSort() {
  # Fix SC2120
  ! false || versionSort --help
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Get the current IP address of a host
ipLookup() {
  local usage="_${FUNCNAME[0]}"

  local url jqFilter
  if ! packageWhich curl curl; then
    __throwEnvironment "$usage" "Requires curl to operate" || return $?
  fi
  url=$(__catchEnvironment "$usage" buildEnvironmentGet IP_URL) || return $?
  [ -n "$url" ] || __throwEnvironment "$usage" "$(decorate value "IP_URL") is required for $(decorate code "${usage#_}")" || return $?
  jqFilter=$(__catchEnvironment "$usage" buildEnvironmentGet IP_URL_FILTER) || return $?
  urlValid "$url" || __throwEnvironment "$usage" "URL $(decorate error "$url") is not a valid URL" || return $?
  local pp=(cat)
  [ -z "$jqFilter" ] || pp=(jq "$jqFilter")
  __catchEnvironment "$usage" curl -s "$url" | "${pp[@]}" || return $?
}
_ipLookup() {
  # _IDENTICAL_ usageDocument 1
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
  local keyDate upToDateDays=${1:-90} accessKeyTimestamp todayTimestamp
  local label deltaDays maxDays daysAgo expireTimestamp expireDate keyTimestamp
  local name argument timeText
  local usage

  usage="_${FUNCNAME[0]}"

  name=Key
  keyDate=
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __throwArgument "$usage" "blank argument" || return $?
    case "$argument" in
      --name)
        shift || :
        name="$1"
        ;;
      *)
        if [ -z "$keyDate" ]; then
          keyDate="$argument"
        elif [ -n "$upToDateDays" ]; then
          upToDateDays="$argument"
        else
          __throwArgument "$usage" "unknown argument $(decorate value "$argument")" || return $?
        fi
        ;;
    esac
    shift || __throwArgument "shift $argument" || return $?
  done
  keyDate="${keyDate:0:10}"
  [ -z "$name" ] || name="$name "
  todayTimestamp=$(dateToTimestamp "$(todayDate)") || __throwEnvironment "$usage" "Unable to generate todayDate" || return $?
  [ -n "$keyDate" ] || __throwArgument "$usage" "missing keyDate" || return $?

  keyTimestamp=$(dateToTimestamp "$keyDate") || __throwArgument "$usage" "Invalid date $keyDate" || return $?
  isInteger "$upToDateDays" || __throwArgument "$usage" "upToDateDays is not an integer ($upToDateDays)" || return $?

  maxDays=366
  [ "$upToDateDays" -le "$maxDays" ] || __throwArgument "$usage" "isUpToDate $keyDate $upToDateDays - values not allowed greater than $maxDays" || return $?
  [ "$upToDateDays" -ge 0 ] || __throwArgument "$usage" "isUpToDate $keyDate $upToDateDays - negative values not allowed" || return $?

  accessKeyTimestamp=$((keyTimestamp + ((23 * 60) + 59) * 60))
  expireTimestamp=$((accessKeyTimestamp + 86400 * upToDateDays))
  expireDate=$(timestampToDate "$expireTimestamp" '%A, %B %d, %Y %R')
  deltaDays=$(((todayTimestamp - accessKeyTimestamp) / 86400))
  daysAgo=$((deltaDays - upToDateDays))
  if [ "$todayTimestamp" -gt "$expireTimestamp" ]; then
    label=$(printf "%s %s\n" "$(decorate error "${name}expired on ")" "$(decorate red "$keyDate")")
    case "$daysAgo" in
      0) timeText="Today" ;;
      1) timeText="Yesterday" ;;
      *) timeText="$daysAgo $(plural $daysAgo day days) ago" ;;
    esac
    labeledBigText --prefix "$(decorate reset)" --top --tween "$(decorate red)" "$label" "EXPIRED $timeText"
    return 1
  fi
  daysAgo=$((-daysAgo))
  if [ $daysAgo -lt 14 ]; then
    labeledBigText --prefix "$(decorate reset)" --top --tween "$(decorate orange)" "${name}expires on $(decorate code "$expireDate"), in " "$daysAgo $(plural $daysAgo day days)"
  elif [ $daysAgo -lt 30 ]; then
    # decorate info "keyDate $keyDate"
    # decorate info "accessKeyTimestamp $accessKeyTimestamp"
    # decorate info "expireDate $expireDate"
    printf "%s %s %s %s\n" \
      "$(decorate warning "${name}expires on")" \
      "$(decorate red "$expireDate")" \
      "$(decorate warning ", in")" \
      "$(decorate magenta "$daysAgo $(plural $daysAgo day days)")"
    return 0
  fi
  return 0
}
_isUpToDate() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
