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
# Usage: dotEnvConfigure where
# Argument: where - Optional. Directory. Where to load the `.env` files.
#
# Loads `.env` which is the current project configuration file
# Also loads `.env.local` if it exists
# Generally speaking - these are NAME=value files and should be parsable by
# bash and other languages.
# See: toDockerEnv
# Summary: Load `.env` and optional `.env.local` into bash context
#
# Requires the file `.env` to exist and is loaded via bash `source` and all variables are `export`ed in the current shell context.
#
# If `.env.local` exists, it is also loaded in a similar manner.
#
# Environment: Loads `.env` and `.env.local`, use with caution on trusted content only
# Exit code: 1 - if `.env` does not exist; outputs an error
# Exit code: 0 - if files are loaded successfully
dotEnvConfigure() {
  local usage="_${FUNCNAME[0]}"
  local where dotEnv files value name

  where=
  [ $# -eq 0 ] || where=$(usageArgumentDirectory "$usage" "where" "${1-}") || return $?
  [ -n "$where" ] || where=$(__usageEnvironment "$usage" pwd) || return $?
  dotEnv="$where/.env"
  [ -f "$dotEnv" ] || __usageEnvironment "$usage" "Missing $dotEnv" || return $?
  files=("$dotEnv")
  [ ! -f "$dotEnv.local" ] || files+=("$dotEnv.local")
  for dotEnv in "${files[@]}"; do
    while read -r name; do
      value=$(__usageEnvironment "$usage" environmentValueRead "$dotEnv" "$name") || return $?
      declare -x "$name=$value"
    done < <(environmentNames <"$dotEnv")
  done
}
_dotEnvConfigure() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

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
  start=$(date +%s 2>/dev/null) || _environment date || return $?
  printf %d "$((start + 0))"
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
    prefix="$(consoleGreen "$@") "
  fi
  delta=$(($(date +%s) - start))
  printf "%s%s\n" "$prefix" "$(consoleBoldMagenta "$delta $(plural $delta second seconds)")"
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
# Example:         consoleError "Deploy failed"
# Example:         buildFailed "$quietLog"
# Example:     fi
# Exit Code: 1 - Always fails
# Output: stdout
buildFailed() {
  local quietLog="${1-}" showLines=50 failBar

  shift
  clearLine || :
  failBar="$(consoleReset)$(consoleMagenta "$(repeat 80 "❌")")"
  # shellcheck disable=SC2094
  printf -- "\n%s\n%s\n%s\n\n" \
    "$(printf -- "\n%s\n\n" "$(bigText "Failed" | wrapLines "" "    ")" | wrapLines --fill "*" "$(consoleError)" "$(consoleReset)")" \
    "$failBar" \
    "$(dumpPipe "$(basename "$quietLog")" "$@" --lines "$showLines" <"$quietLog")"
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
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Get the current IP address of the host
# Exit Code: 1 - Returns
ipLookup() {
  # Courtesy of Market Ruler, LLC thanks
  local default="https://www.conversionruler.com/showip/?json"
  if ! whichApt curl curl; then
    return 1
  fi
  curl -s "${IP_URL:-$default}"
}

applicationEnvironmentVariables() {
  cat <<EOF
BUILD_TIMESTAMP
APPLICATION_BUILD_DATE
APPLICATION_VERSION
APPLICATION_ID
APPLICATION_TAG
EOF
}

#
# Loads application environment variables, set them to their default values if needed, and outputs the list of variables set.
# Environment: BUILD_TIMESTAMP
# Environment: APPLICATION_BUILD_DATE
# Environment: APPLICATION_VERSION
# Environment: APPLICATION_ID
# Environment: APPLICATION_TAG
applicationEnvironment() {
  local hook here env
  local variables=()

  IFS=$'\n' read -d '' -r -a variables < <(applicationEnvironmentVariables) || :
  export "${variables[@]}"

  here=$(dirname "${BASH_SOURCE[0]}") || _environment "dirname ${BASH_SOURCE[0]}" || return $?

  for env in "${variables[@]}"; do
    # shellcheck source=/dev/null
    source "$here/../env/$env.sh" || _environment "source $env.sh" || return $?
  done

  if [ -z "${APPLICATION_VERSION-}" ]; then
    hook=version-current
    APPLICATION_VERSION="$(runHook "$hook")" || _environment "runHook" "$hook" || return $?
  fi
  if [ -z "${APPLICATION_ID-}" ]; then
    hook=application-id
    APPLICATION_ID="$(runHook "$hook")" || _environment "runHook" "$hook" || return $?

  fi
  if [ -z "${APPLICATION_TAG-}" ]; then
    hook=application-tag
    APPLICATION_TAG="$(runHook "$hook")" || _environment "runHook" "$hook" || return $?
  fi
  printf "%s\n" "${variables[@]}"
}

showEnvironment() {
  local start missing e requireEnvironment buildEnvironment tempEnv
  local variables=()

  IFS=$'\n' read -d '' -r -a variables < <(applicationEnvironmentVariables) || :
  export "${variables[@]}"

  #
  # e.g.
  #
  # Email: SMTP_URL MAIL_SUPPORT MAIL_FROM TESTING_EMAIL TESTING_EMAIL_IMAP
  # Database: DSN
  # Amazon: AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY
  #
  # Must be defined and non-empty to run this script

  tempEnv=$(mktemp)
  if ! applicationEnvironment >"$tempEnv"; then
    rm -f "$tempEnv" || :
    _environment applicationEnvironment || return $?
  fi
  IFS=$'\n' read -d '' -r -a requireEnvironment <"$tempEnv" || :
  rm "$tempEnv" || :
  # Will be exported to the environment file, only if defined
  while [ $# -gt 0 ]; do
    case $1 in
      --)
        shift
        break
        ;;
      *)
        requireEnvironment+=("$1")
        ;;
    esac
    shift
  done
  buildEnvironment=("$@")

  printf "%s %s %s %s%s\n" "$(consoleInfo "Application")" "$(consoleMagenta "$APPLICATION_VERSION")" "$(consoleInfo "on")" "$(consoleBoldRed "$APPLICATION_BUILD_DATE")" "$(consoleInfo "...")"
  if buildDebugEnabled; then
    consoleNameValue 40 Checksum "$APPLICATION_ID"
    consoleNameValue 40 Tag "$APPLICATION_TAG"
    consoleNameValue 40 Timestamp "$BUILD_TIMESTAMP"
  fi
  missing=()
  for e in "${requireEnvironment[@]}"; do
    if [ -z "${!e:-}" ]; then
      printf "%s %s\n" "$(consoleLabel "$(alignRight 30 "$e")"):" "$(consoleError "** No value **")" 1>&2
      missing+=("$e")
    else
      echo "$(consoleLabel "$(alignRight 30 "$e")"):" "$(consoleValue "${!e}")"
    fi
  done
  for e in "${buildEnvironment[@]+"${buildEnvironment[@]}"}"; do
    if [ -z "${!e:-}" ]; then
      printf "%s %s\n" "$(consoleLabel "$(alignRight 30 "$e")"):" "$(consoleSuccess "** Blank **")" 1>&2
    else
      echo "$(consoleLabel "$(alignRight 30 "$e")"):" "$(consoleValue "${!e}")"
    fi
  done
  [ ${#missing[@]} -eq 0 ] || _environment "Missing environment" "${missing[@]}" || return $?
}

#
# Usage: {fn} [ requireEnv1 requireEnv2 requireEnv3 ... ] [ -- optionalEnv1 optionalEnv2 ] "
# Argument: requireEnv1 - Optional. One or more environment variables which should be non-blank and included in the `.env` file.
# Argument: optionalEnv1 - Optional. One or more environment variables which are included if blank or not
# Create environment file `.env` for build.
# Environment: APPLICATION_VERSION - reserved and set to `runHook version-current` if not set already
# Environment: APPLICATION_BUILD_DATE - reserved and set to current date; format like SQL.
# Environment: APPLICATION_TAG - reserved and set to `runHook application-id`
# Environment: APPLICATION_ID - reserved and set to `runHook application-tag`
#
makeEnvironment() {
  local missing e requireEnvironment
  local usage

  usage="_${FUNCNAME[0]}"

  IFS=$'\n' read -d '' -r -a requireEnvironment < <(applicationEnvironment) || :

  if ! showEnvironment "$@" >/dev/null; then
    showEnvironment 1>&2
    __failEnvironment "$usage" "Missing values" || return $?
  fi

  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __failArgument "$usage" "blank argument" || return $?
    case "$argument" in
      --)
        shift || :
        break
        ;;
      *)
        requireEnvironment+=("$argument")
        ;;
    esac
    shift || :
  done

  #==========================================================================================
  #
  # Generate an .env artifact
  #
  for e in "${requireEnvironment[@]}" "$@"; do
    if [ -n "${!e}" ]; then
      echo "$e=\"${!e//\"/\\\"}\""
    fi
  done
}
_makeEnvironment() {
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
          __failArgument "$usage" "unknown argument $(consoleValue "$argument")" || return $?
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
    label=$(printf "%s %s\n" "$(consoleError "${name}expired on ")" "$(consoleRed "$keyDate")")
    case "$daysAgo" in
      0) timeText="Today" ;;
      1) timeText="Yesterday" ;;
      *) timeText="$daysAgo $(plural $daysAgo day days) ago" ;;
    esac
    labeledBigText --prefix "$(consoleReset)" --top --tween "$(consoleRed)" "$label" "EXPIRED $timeText"
    return 1
  fi
  daysAgo=$((-daysAgo))
  if [ $daysAgo -lt 14 ]; then
    labeledBigText --prefix "$(consoleReset)" --top --tween "$(consoleOrange)" "${name}expires on $(consoleCode "$expireDate"), in " "$daysAgo $(plural $daysAgo day days)"
  elif [ $daysAgo -lt 30 ]; then
    # consoleInfo "keyDate $keyDate"
    # consoleInfo "accessKeyTimestamp $accessKeyTimestamp"
    # consoleInfo "expireDate $expireDate"
    printf "%s %s %s %s\n" \
      "$(consoleWarning "${name}expires on")" \
      "$(consoleRed "$expireDate")" \
      "$(consoleWarning ", in")" \
      "$(consoleMagenta "$daysAgo $(plural $daysAgo day days)")"
    return 0
  fi
  return 0
}
_isUpToDate() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
