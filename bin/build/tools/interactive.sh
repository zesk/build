#!/usr/bin/env bash
#
# Interactivity
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Depends: text.sh colors.sh
# bin: test echo printf
# Docs: o ./docs/_templates/tools/interactive.md
# Test: o ./test/tools/interactive-tests.sh

####################################################################################################
####################################################################################################
#
# ▄▄▄                                      █
# ▀█▀       ▐▌                       ▐▌    ▀
#  █  ▐▙██▖▐███  ▟█▙  █▟█▌ ▟██▖ ▟██▖▐███  ██  ▐▙ ▟▌ ▟█▙
#  █  ▐▛ ▐▌ ▐▌  ▐▙▄▟▌ █▘   ▘▄▟▌▐▛  ▘ ▐▌    █   █ █ ▐▙▄▟▌
#  █  ▐▌ ▐▌ ▐▌  ▐▛▀▀▘ █   ▗█▀▜▌▐▌    ▐▌    █   ▜▄▛ ▐▛▀▀▘
# ▄█▄ ▐▌ ▐▌ ▐▙▄ ▝█▄▄▌ █   ▐▙▄█▌▝█▄▄▌ ▐▙▄ ▗▄█▄▖ ▐█▌ ▝█▄▄▌
# ▀▀▀ ▝▘ ▝▘  ▀▀  ▝▀▀  ▀    ▀▀▝▘ ▝▀▀   ▀▀ ▝▀▀▀▘  ▀   ▝▀▀
#
####################################################################################################
####################################################################################################

# Pause for user input
pause() {
  local prompt="${1-"PAUSE > "}"
  statusMessage printf -- "%s" "$prompt"
  read -n 1 -s -r prompt </dev/tty
}

####################################################################################################
####################################################################################################
#  ▜▘   ▐              ▐  ▗                         ▐
#  ▐ ▛▀▖▜▀ ▞▀▖▙▀▖▝▀▖▞▀▖▜▀ ▄▌ ▌▞▀▖ ▞▀▘▌ ▌▛▀▖▛▀▖▞▀▖▙▀▖▜▀
#  ▐ ▌ ▌▐ ▖▛▀ ▌  ▞▀▌▌ ▖▐ ▖▐▐▐ ▛▀  ▝▀▖▌ ▌▙▄▘▙▄▘▌ ▌▌  ▐ ▖
#  ▀▘▘ ▘ ▀ ▝▀▘▘  ▝▀▘▝▀  ▀ ▀▘▘ ▝▀▘ ▀▀ ▝▀▘▌  ▌  ▝▀ ▘   ▀
####################################################################################################
####################################################################################################

#
# Usage: _copyFileEscalated displaySource source destination verb
#
_copyFileEscalated() {
  decorate reset
  printf "\n%s -> %s: %s\n\n" "$(decorate green "$1")" "$(decorate red "$3")" "$(decorate bold-red "$4")"
  if confirmYesNo --yes "$(printf "%s: %s\n(%s/%s - default %s)? " \
    "$(decorate bold Copy privileged file to)" \
    "$(decorate code "$3")" \
    "$(decorate red Yes)" \
    "$(decorate green No)" "$(decorate red Yes)")"; then
    __execute cp "$2" "$3" || return $?
    return $?
  fi
  printf "%s \"%s\"\n" "$(decorate error "Used declined update of")" "$(decorate red "$3")" 1>&2
  _argument || return $?
}

#
# Usage: {fn} displaySource source destination verb
#
# Copy a file with no privilege escalation
#
_copyFileRegular() {
  local displaySource="$1" source="$2" destination="$3" verb="$4"
  decorate reset || _copyFilePrompt "OVERRIDE $displaySource" "$destination" "$verb" || :
  __execute cp "$source" "$destination" || return $?
}

_copyFilePrompt() {
  local source="$1" destination="$2" verb="$3"
  printf "%s -> %s %s\n" "$(decorate green "$source")" "$(decorate red "$destination")" "$(decorate cyan "$verb")"
}

# Usage: {fn} source destination verb
# Argument: displaySource - Source path
# Argument: displayDestination - Destination path
# Argument: verb - Descriptive verb of what's up
_copyFileShow() {
  _copyFilePrompt "$@"
  wrapLines "$(decorate code)" "$(decorate reset)"
}

#
# Show a new file which will be added
#
# Usage: {fn} displaySource source destination
# Argument: displaySource - Source path to show
# Argument: source - Actual source path
# Argument: destination - Destination path
_copyFileShowNew() {
  local displaySource="$1" source="$2" destination="$3"
  local lines
  head -10 "$source" | _copyFileShow "$displaySource" "$destination" "Created"
  lines=$(($(wc -l <"$source") + 0))
  decorate info "$(printf "%d %s total" "$lines" "$(plural "$lines" line lines)")"
}

####################################################################################################
####################################################################################################

# Copy file from source to destination
#
# Supports mapping the file using the current environment, or escalated privileges.
# Usage: {fn} [ --map ] [ --escalate ] source destination
# Argument: --map - Flag. Optional. Map environment values into file before copying.
# Argument: --escalate - Flag. Optional. The file is a privilege escalation and needs visual confirmation. Requires root privileges.
# Argument: source - File. Required. Source path
# Argument: destination - File. Required. Destination path
# Exit Code: 0 - Success
# Exit Code: 1 - Failed
copyFile() {
  local usage="_${FUNCNAME[0]}"

  local mapFlag=false copyFunction="_copyFileRegular" owner="" mode="" source="" destination=""

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
      --map)
        mapFlag=true
        ;;
      --escalate)
        copyFunction=_copyFileEscalated
        ;;
      --owner)
        shift
        usageArgumentString "$usage" "$argument" "${1-}" || return $?
        owner="$1"
        ;;
      --mode)
        shift
        usageArgumentString "$usage" "$argument" "${1-}" || return $?
        mode="$1"
        ;;
      *)
        local source destination actualSource verb prefix
        source="$1"
        [ -f "$source" ] || __throwEnvironment "$usage" "source \"$source\" does not exist" || return $?
        shift
        destination=$(usageArgumentFileDirectory _argument "destination" "${1-}") || return $?
        shift
        [ $# -eq 0 ] || __catchArgument "$usage" "unknown argument $1" || return $?
        if $mapFlag; then
          actualSource=$(mktemp)
          if ! mapEnvironment <"$source" >"$actualSource"; then
            rm "$actualSource" || :
            __catchEnvironment "$usage" "Failed to mapEnvironment $source" || return $?
          fi
          verb=" (mapped)"
        else
          actualSource="$source"
          verb=""
        fi
        if [ -f "$destination" ]; then
          if ! diff -q "$actualSource" "$destination" >/dev/null; then
            prefix="$(decorate subtle "$(basename "$source")"): "
            _copyFilePrompt "$source" "$destination" "Changes" || :
            diff "$actualSource" "$destination" | sed '1d' | wrapLines "$prefix$(decorate code)" "$(decorate reset)" || :
            verb="File changed${verb}"
          else
            return 0
          fi
        else
          _copyFileShowNew "$source" "$actualSource" "$destination" || :
          verb="File created${verb}"
        fi
        "$copyFunction" "$source" "$actualSource" "$destination" "$verb"
        exitCode=$?
        if [ $exitCode -eq 0 ] && [ -n "$owner" ]; then
          __catchEnvironment "$usage" chown "$owner" "$destination" || exitCode=$?
        fi
        if [ $exitCode -eq 0 ] && [ -n "$mode" ]; then
          __catchEnvironment "$usage" chmod "$mode" "$destination" || exitCode=$?
        fi
        if $mapFlag; then
          rm "$actualSource" || :
        fi
        return $exitCode
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done
  __throwArgument "$usage" "Missing source" || return $?
}
_copyFile() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Check whether copying a file would change it
# This function does not modify the source or destination.
# Usage: {fn} [ --map ] source destination
# Argument: --map - Flag. Optional. Map environment values into file before copying.
# Argument: source - File. Required. Source path
# Argument: destination - File. Required. Destination path
# Exit Code: 0 - Something would change
# Exit Code: 1 - Nothing would change
copyFileWouldChange() {
  local usage="_${FUNCNAME[0]}"

  local mapFlag=false source=""
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
      --map)
        mapFlag=true
        ;;
      *)
        if [ -z "$source" ]; then
          source=$(usageArgumentFile "$usage" "source" "$1") || return $?
        else
          local actualSource destination

          destination=$(usageArgumentFileDirectory "$usage" "destination" "$1") || return $?
          shift
          if [ $# -gt 0 ]; then
            # _IDENTICAL_ argumentUnknown 1
            __throwArgument "$usage" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
          fi
          if [ ! -f "$destination" ]; then
            return 0
          fi
          local exitCode=1
          if $mapFlag; then
            actualSource=$(fileTemporaryName "$usage") || return $?
            __catchEnvironment "$usage" mapEnvironment <"$source" >"$actualSource" || _clean $? "$actualSource" || return $?
            if ! diff -q "$actualSource" "$destination" >/dev/null; then
              exitCode=0
            fi
            __catchEnvironment "$usage" rm -f "$actualSource" || return $?
          else
            actualSource="$source"
            if ! diff -q "$actualSource" "$destination" >/dev/null; then
              exitCode=0
            fi
          fi
          return "$exitCode"
        fi
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done
  __throwArgument "$usage" "Missing source" || return $?
}
_copyFileWouldChange() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: {fn} verificationCallable fileToCheck ...
# Argument: verificationCallable - Required. Callable. Call this on each file and a zero result code means passed and non-zero means fails.
# Argument: --exec binary - Optional. Callable. Run binary with files as an argument for any failed files. Only works if you pass in item names.
# Argument: --delay delaySeconds - Optional. Integer. Delay in seconds between checks in interactive mode.
# Argument: fileToCheck ... - Optional. File. Shell file to validate. May also supply file names via stdin.
# Run checks interactively until errors are all fixed.
# Not ready for prime time yet - written not tested.
interactiveManager() {
  local usage="_${FUNCNAME[0]}"

  local binary="" repairFunction"" verificationCallable="" files=() sleepDelay=15

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
      --exec)
        shift
        binary="$(usageArgumentCallable "$argument" "${1-}")" || return $?
        ;;
      --delay)
        shift
        sleepDelay=$(usageArgumentUnsignedInteger "$usage" "$argument" "${1-}") || return $?
        ;;
      --repair)
        shift
        repairFunction=$(usageArgumentCallable "$usage" "$argument" "${1-}") || return $?
        ;;
      *)
        if [ -z "$verificationCallable" ]; then
          verificationCallable=$(usageArgumentCallable "$usage" "verificationCallable" "$1") || return $?
        else
          files+=("$(usageArgumentFile "$usage" "fileToCheck" "$1")") || return $?
        fi
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  [ -n "$verificationCallable" ] || __throwArgument "$usage" "No verificationCallable" || return $?

  if [ "${#files[@]}" -eq 0 ]; then
    while read -r file; do files+=("$(usageArgumentFile "$usage" "fileToCheck (stdin)" "$1")"); done
    [ "${#files[@]}" -gt 0 ] || return 0
  fi

  [ "${#files[@]}" -gt 0 ] || __throwArgument "$usage" "No files supplied" || return $?

  # Validation complete

  local rowsAllowed output index=1 didClear=false triedRepair

  rowsAllowed=$(__catchEnvironment "$usage" consoleRows) || return $?
  rowsAllowed=$((rowsAllowed - 4))
  output=$(fileTemporaryName "$usage") || return $?
  index=1

  local file nextMessage=""
  for file in "${files[@]}"; do
    triedRepair=false
    while ! "$verificationCallable" "$file" >"$output" 2>&1; do
      didClear=true
      clear
      message="$(decorate code "$file") failed $(decorate error "$verificationCallable")"
      if ! $triedRepair && [ -n "$repairFunction" ]; then
        triedRepair=true
        if ! "$repairFunction" "$file" >"$output"; then
          message="$message ($repairFunction failed)"
        fi
        if ! "$verificationCallable" "$file" >"$output"; then
          message="$message (not repaired)"
        fi
      fi
      boxedHeading --size 1 "$message"
      dumpPipe --head --lines "$rowsAllowed" "OUTPUT" <"$output"
      if [ $index -eq "${#files[@]}" ]; then
        nextMessage=$(decorate green "(last one)")
      else
        nextMessage="$(printf -- "(%s %s)" "$(decorate subtle "next file is")" "$(decorate code "${files["$index"]}")")"
      fi
      printf "%s %s %s files %s" "$(decorate bold-green "$index")" "$(decorate subtle "of")" "$(decorate bold-blue "${#files[@]}")" "$nextMessage"
      if [ -n "$binary" ]; then
        "$binary" "$file"
      fi
      sleep "$sleepDelay" || __throwEnvironment "$usage" "Interrupt ..." || _clean $? "$output" || return $?
    done
    index=$((index + 1))
  done
  if $didClear; then
    clear
    decorate success "All files now pass:"
    printf -- "- %s\n" "${files[@]}"
  fi
}
_interactiveManager() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__interactiveApprovedFile() {
  local usage="$1" approvedHome="$2" sourceFile="$3" verb="$4" approved displayFile approvedFile approvedHome

  shift 4
  approvedFile="$approvedHome/$(__catchEnvironment "$usage" shaPipe <"$sourceFile")" || return $?
  displayFile=$(decorate file "$sourceFile")
  if [ ! -f "$approvedFile" ]; then
    if confirmYesNo "$@" "$verb $(decorate file "$sourcePath")?"; then
      approved=true
      statusMessage --last printf "%s [%s] %s" "$(decorate success "Approved")" "$(decorate file "$displayFile")" "$(decorate subtle "(will not ask in the future)")"
    else
      approved=false
    fi
    printf -- "%s\n" "$approved""$(whoami)" "$(date +%s)" "$(date -u)" "$sourceFile" >"$approvedFile" || __throwEnvironment "$usage" "Unable to write $(decorate file "$approvedFile")" || return $?
  fi
  approved=$(head -n 1 "$approvedFile")
  if ! isBoolean "$approved" && "$approved"; then
    return 1
  fi
  # Allows identical files in different projects to be approved once
  if ! grep -q "$sourceFile" <"$approvedFile"; then
    printf "%s\n" "$sourceFile" >>"$approvedFile"
  fi
  return 0
}

# Usage: {fn} usage approvedFile verb confirmYesNoArguments ...
__interactiveApproved() {
  local usage="$1" sourcePath="$2" approved displayFile approvedFile approvedHome

  shift 2 || __catchArgument "$usage" "shift" || return $?
  approvedHome=$(__catchEnvironment "$usage" buildEnvironmentGetDirectory --subdirectory ".interactiveApproved" "XDG_STATE_HOME") || return $?

  if [ -d "$sourcePath" ]; then
    local sourceFile approved=true
    while read -r sourceFile; do
      if ! __interactiveApprovedFile "$usage" "$approvedHome" "$sourceFile" "$@"; then
        approved=false
        break
      fi
    done < <(find "$sourcePath" -type f -name '*.sh' ! -path '*/.*/*')
    "$approved"
  else
    __interactiveApprovedFile "$usage" "$approvedHome" "$sourcePath" "$@"
  fi
}

# Maybe move this to its own thing if needed later
# Usage: {fn} timeout attempts extras message
__interactiveCountdownReadBoolean() {
  local usage="$1" && shift
  local timeout="" rr=() extras icon="⏳" attempts

  if [ "$1" != "" ]; then
    rr=(-t 1)
    timeout=$(usageArgumentPositiveInteger "$usage" "timeout" "${1-}") || return $?
  fi
  shift

  attempts=$(usageArgumentInteger "$usage" "attempts" "${1-}") || return $?
  shift

  extras="${1-}" && shift

  local value start now elapsed=0 message="$*" counter=1 exitCode=0 prefix="" timingSuffix=""
  start=$(__environment beginTiming) || return $?
  width="$timeout"
  width="${#width}"

  # IDENTICAL __interactiveCountdownReadBooleanStatus 3
  [ "$attempts" -le 1 ] || prefix="$(decorate value "[🧪$counter/$attempts]") "
  [ "$timeout" = "" ] || timingSuffix="$(printf " %s %s" "$icon" "$(alignRight "$width" "$((timeout - elapsed))")")"
  statusMessage printf -- "%s%s%s%s" "$prefix" "$message" "$extras" "$timingSuffix"

  exitCode=2
  while [ "$exitCode" -ge 2 ]; do
    while ! read -n 1 -s -r "${rr[@]+"${rr[@]}"}" value </dev/tty; do
      if [ -z "$timeout" ]; then
        return 2
      fi
      now=$(__environment beginTiming) || return $?
      elapsed=$((now - start))
      if [ "$elapsed" -gt "$timeout" ]; then
        return 10
      fi
      # IDENTICAL __interactiveCountdownReadBooleanStatus 3
      [ "$attempts" -le 1 ] || prefix="$(decorate value "[🧪$counter/$attempts]") "
      [ "$timeout" = "" ] || timingSuffix="$(printf " %s %s" "$icon" "$(alignRight "$width" "$((timeout - elapsed))")")"
      statusMessage printf -- "%s%s%s%s" "$prefix" "$message" "$extras" "$timingSuffix"
    done
    exitCode=0
    parseBoolean "$value" || exitCode=$?
    [ "$exitCode" -ge 2 ] || break
    counter=$((counter + 1))
    if [ "$attempts" -gt 0 ]; then
      if [ $counter -gt "$attempts" ]; then
        return 11
      fi
      # IDENTICAL __interactiveCountdownReadBooleanStatus 3
      [ "$attempts" -le 1 ] || prefix="$(decorate value "[🧪$counter/$attempts]") "
      [ "$timeout" = "" ] || timingSuffix="$(printf " %s %s" "$icon" "$(alignRight "$width" "$((timeout - elapsed))")")"
      statusMessage printf -- "%s%s%s%s" "$prefix" "$message" "$extras" "$timingSuffix"
    fi
  done
  return "$exitCode"
}

__confirmYesNo() {
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

# Read user input and return 0 if the user says yes, or non-zero if they say no
# Exit Code: 0 - Yes
# Exit Code: 1 - No
# Usage: {fn} [ --default defaultValue ] [ --yes ] [ --no ]
# Argument: --default defaultValue - Boolean. Optional. Value to return if no value given by user
# Argument: --attempts attempts - PositiveInteger. Optional. User can give us a bad response this many times before we return the default.
# Argument: --timeout seconds - PositiveInteger. Optional. Wait this long before choosing the default. If no default, default is --no.
# Argument: --yes - Boolean. Optional. Short for `--default yes`
# Argument: --no - Boolean. Optional. Short for `--default no`
# Example: Will time out after 10 seconds, regardless (user must make valid input in that time):
# Example:
# Example:     confirmYesNo --timeout 10 "Stop the timer!"
# Example:
# Example: Will time out after 10 seconds, regardless (user must make valid input in that time):
# Example:
# Example:     confirmYesNo --timeout 10 "Stop the timer!"
# Example:
confirmYesNo() {
  local usage="_${FUNCNAME[0]}"
  local default="no" message="" timeout="" extras="" attempts=-1

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
      --info)
        extras=" $(decorate subtle "Type Y or N") "
        ;;
      --attempts)
        shift
        attempts=$(usageArgumentPositiveInteger "$usage" "$argument" "${1-}") || return $?
        ;;
      --timeout)
        shift
        timeout=$(usageArgumentPositiveInteger "$usage" "$argument" "${1-}") || return $?
        ;;
      --yes) default=yes ;;
      --no) default=no ;;
      --default)
        shift
        default="$(usageArgumentString "$usage" "$argument" "${1-}")" || return $?
        parseBoolean "$default" || [ $? -ne 2 ] || __throwArgument "$usage" "Can not parse $(decorate code "$1") as a boolean" || return $?
        ;;
      *)
        message="$*"
        break
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  local exitCode=0

  while __interactiveCountdownReadBoolean "$usage" "$timeout" "$attempts" "$extras" "$message" || exitCode=$?; do
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
  __confirmYesNo "$default" "$reason" || return $?
}
_confirmYesNo() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

interactiveCountdown() {
  local usage="_${FUNCNAME[0]}"

  local prefix="" counter="" binary=""

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
      --prefix)
        # shift here never fails as [ #$ -gt 0 ]
        shift
        prefix="$(usageArgumentEmptyString "$usage" "$argument" "${1-}")" || return $?
        ;;
      *)
        if [ -z "$counter" ]; then
          counter=$(usageArgumentPositiveInteger "$usage" "counter" "$1") || return $?
        else
          binary=$(usageArgumentCallable "$usage" "callable" "$1") || return $?
          break
        fi
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done
  [ -n "$counter" ] || __throwArgument "$usage" "counter is required" || return $?

  local start end now

  start=$(__catchEnvironment "$usage" beginTiming) || return $?
  end=$((start + counter))
  now=$start
  [ -z "$prefix" ] || prefix="$prefix "

  while [ "$now" -lt "$end" ]; do
    statusMessage printf "%s%s" "$(decorate info "$prefix")" "$(decorate value " $counter ")"
    sleep 1
    now=$(__catchEnvironment "$usage" beginTiming) || return $?
    counter=$((end - now))
  done
  statusMessage printf -- "%s" ""
  if [ -n "$binary" ]; then
    __catch "$usage" "$@" || return $?
  fi
}
_interactiveCountdown() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: {fn} [ directoryOrFile ... ]
# Argument: directoryOrFile - Required. Exists. Directory or file to `source` `.sh` files found.
# Argument: --info - Optional. Flag. Show user what they should do (press a key).
# Argument: --no-info - Optional. Flag. Hide user info (what they should do ... press a key)
# Argument: --verbose - Optional. Flag. Show what is done as status messages.
# Argument: --prefix - Optional. String. Display this text before each status messages.
# Security: Loads bash files
# Loads files or a directory of `.sh` files using `source` to make the code available.
# Has security implications. Use with caution and ensure your directory is protected.
interactiveBashSource() {
  local usage="_${FUNCNAME[0]}"

  local prefix="Loading" verboseFlag=false aa=(--info) bb=(--attempts 1 --timeout 30)

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
      --info)
        aa=(--info)
        ;;
      --no-info)
        aa=()
        ;;
      --verbose)
        verboseFlag=true
        ;;
      --prefix)
        # shift here never fails as [ #$ -gt 0 ]
        shift
        prefix="$(usageArgumentString "$usage" "$argument" "${1-}")" || return $?
        ;;
      *)
        local sourcePath="$argument" verb="" approved=false
        displayPath="$(decorate file "$sourcePath")"
        if [ -f "$sourcePath" ]; then
          verb="file"
          if __interactiveApproved "$usage" "$sourcePath" "Load" "${aa[@]+"${aa[@]}"}" "${bb[@]}"; then
            ! $verboseFlag || statusMessage --last printf -- "%s %s %s" "$(decorate info "$prefix")" "$(decorate label "$verb")" "$displayPath"
            __catchEnvironment "$usage" source "$sourcePath" || return $?
            approved=true
          fi
        elif [ -d "$sourcePath" ]; then
          verb="path"
          if __interactiveApproved "$usage" "$sourcePath/" "Load path" "${aa[@]+"${aa[@]}"}" "${bb[@]}"; then
            ! $verboseFlag || statusMessage --last printf -- "%s %s %s" "$(decorate info "$prefix")" "$(decorate label "$verb")" "$displayPath"
            __catchEnvironment "$usage" bashSourcePath "$sourcePath" || return $?
            approved=true
          fi
        else
          __throwEnvironment "$usage" "Not a file or directory? $displayPath is a $(decorate value "$(betterType "$sourcePath")")" || return $?
        fi
        if $verboseFlag && ! $approved; then
          statusMessage decorate subtle "Skipping $verb $(decorate file "$sourcePath")" || :
        fi
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done
}
_interactiveBashSource() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
