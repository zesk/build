#!/usr/bin/env bash
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Depends: colors.sh text.sh
#
# Docs: o ./docs/_templates/tools/pipeline.md
# Test: o ./test/tools/pipeline-tests.sh

###############################################################################
#
# ░█▀█░▀█▀░█▀█░█▀▀░█░░░▀█▀░█▀█░█▀▀
# ░█▀▀░░█░░█▀▀░█▀▀░█░░░░█░░█░█░█▀▀
# ░▀░░░▀▀▀░▀░░░▀▀▀░▀▀▀░▀▀▀░▀░▀░▀▀▀
#
#------------------------------------------------------------------------------

#
# Summary: Start a timer for a section of the build
#
# Outputs the offset in seconds from January 1, 1970.
#
# Usage: beginTiming
# Example:     init=$(beginTiming)
# Example:     ...
# Example:     reportTiming "$init" "Completed in"
#
beginTiming() {
  local start
  start=$(date "+%s" 2>/dev/null) || _environment date "+%s%3N" || return $?
  printf "%d" "$((start + 0))"
}

# Outputs the timing in magenta optionally prefixed by a message in green
#
# Usage: reportTiming "$startTime" outputText...
# Summary: Output the time elapsed
# Outputs a nice colorful message showing the number of seconds elapsed as well as your custom message.
# Usage: reportTiming start [ message ... ]
# Argument: start - Unix timestamp seconds of start timestamp
# Argument: message - Any additional arguments are output before the elapsed value computed
# Exit code: 0 - Exits with exit code zero
# Example:    init=$(beginTiming)
# Example:    ...
# Example:    reportTiming "$init" "Deploy completed in"
reportTiming() {
  local start prefix delta
  local usage="_${FUNCNAME[0]}"

  start="${1-}"
  __usageArgument "$usage" isInteger "$start" || return $?
  shift
  prefix=
  if [ $# -gt 0 ]; then
    prefix="$(decorate green "$@") "
  fi
  delta=$(($(beginTiming) - start))
  printf "%s%s\n" "$prefix" "$(decorate bold-magenta "$delta $(plural $delta second seconds)")"
}
_reportTiming() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

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
  local quietLog="${1-}" showLines=50 failBar

  shift
  failBar="$(decorate reset)$(decorate magenta "$(repeat 80 "❌")")"
  # shellcheck disable=SC2094
  statusMessage --last printf -- "\n%s\n%s\n%s\n" \
    "$(printf -- "\n%s\n\n" "$(bigText "Failed" | wrapLines "" "    ")" | wrapLines --fill "*" "$(decorate error)" "$(decorate reset)")" \
    "$failBar" \
    "$(dumpPipe --tail "$(basename "$quietLog")" "$@" --lines "$showLines" <"$quietLog")"
  _environment "Build failed:" "$@" || return $?
}

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
# Usage: versionSort [ -r ]
# Argument: -r - Reverse the sort order (optional)
# Example:    git tag | grep -e '^v[0-9.]*$' | versionSort
#
versionSort() {
  local r=
  local usage="_${FUNCNAME[0]}"

  if [ $# -gt 0 ]; then
    if [ "$1" = "-r" ]; then
      r=r
      shift || __failArgument "$usage" "shift failed" || return $?
    else
      __failArgument "$usage" "Unknown argument: $1" || return $?
    fi
  fi
  sort -t . -k 1.2,1n$r -k 2,2n$r -k 3,3n$r
}
_versionSort() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Get the current IP address of a host
ipLookup() {
  local usage="_${FUNCNAME[0]}"

  local url jqFilter
  if ! packageWhich curl curl; then
    __failEnvironment "$usage" "Requires curl to operate" || return $?
  fi
  url=$(__usageEnvironment "$usage" buildEnvironmentGet IP_URL) || return $?
  [ -n "$url" ] || __failEnvironment "$usage" "$(decorate value "IP_URL") is required for $(decorate code "${usage#_}")" || return $?
  jqFilter=$(__usageEnvironment "$usage" buildEnvironmentGet IP_URL_FILTER) || return $?
  urlValid "$url" || __failEnvironment "$usage" "URL $(decorate error "$url") is not a valid URL" || return $?
  local pp=(cat)
  [ -z "$jqFilter" ] || pp=(jq "$jqFilter")
  __usageEnvironment "$usage" curl -s "$url" | "${pp[@]}" || return $?
}
_ipLookup() {
  # IDENTICAL usageDocument 1
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
# Argument: keyDate - Required. Date. Formatted like `YYYY-MM-DD`
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
    [ -n "$argument" ] || __failArgument "$usage" "blank argument" || return $?
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
          __failArgument "$usage" "unknown argument $(decorate value "$argument")" || return $?
        fi
        ;;
    esac
    shift || __failArgument "shift $argument" || return $?
  done

  [ -z "$name" ] || name="$name "
  todayTimestamp=$(dateToTimestamp "$(todayDate)") || __failEnvironment "$usage" "Unable to generate todayDate" || return $?
  [ -n "$keyDate" ] || __failArgument "$usage" "missing keyDate" || return $?

  keyTimestamp=$(dateToTimestamp "$keyDate") || __failArgument "$usage" "Invalid date $keyDate" || return $?
  isInteger "$upToDateDays" || __failArgument "$usage" "upToDateDays is not an integer ($upToDateDays)" || return $?

  maxDays=366
  [ "$upToDateDays" -le "$maxDays" ] || __failArgument "$usage" "isUpToDate $keyDate $upToDateDays - values not allowed greater than $maxDays" || return $?
  [ "$upToDateDays" -ge 0 ] || __failArgument "$usage" "isUpToDate $keyDate $upToDateDays - negative values not allowed" || return $?

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
