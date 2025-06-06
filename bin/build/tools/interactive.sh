#!/usr/bin/env bash
#
# Interactivity
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Depends: text.sh colors.sh
# bin: test echo printf
# Docs: o ./documentation/source/tools/interactive.md
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
  bashUserInput
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
  _copyFilePrompt "OVERRIDE $displaySource" "$destination" "$verb" || :
  __execute cp "$source" "$destination" || return $?
}

_copyFilePrompt() {
  local source="$1" destination="$2" verb="$3"
  printf "%s -> %s %s\n" "$(decorate green "$source")" "$(decorate red "$destination")" "$(decorate cyan "$verb")"
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
  _copyFilePrompt "$displaySource" "$destination" "Created"
  head -10 "$source" | decorate code
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
        if ! diff -q "$destination" "$actualSource" >/dev/null; then
          prefix="$(decorate subtle "$(basename "$source")"): "
          _copyFilePrompt "$source" "$destination" "Changes" || :
          diff "$destination" "$actualSource" | sed '1d' | decorate code | decorate wrap "$prefix"
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
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: {fn} loopCallable arguments ...
# Argument: loopCallable - Required. Callable. Call this on each file and a zero result code means passed and non-zero means fails.
# Argument: --delay delaySeconds - Optional. Integer. Delay in seconds between checks in interactive mode.
# Argument: --until exitCode - Optional. Integer. Check until exit code matches this.
# Argument: arguments ... - Optional. Arguments to loopCallable
# Run checks interactively until errors are all fixed.
loopExecute() {
  local usage="_${FUNCNAME[0]}"

  local loopCallable="" sleepDelay=10 title="" until=()

  bashDebugInterruptFile --error --interrupt

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
    --title)
      shift
      title=$(usageArgumentString "$usage" "$argument" "${1-}") || return $?
      ;;
    --until)
      shift
      until+=("$(usageArgumentUnsignedInteger "$usage" "$argument" "${1-}")") || return $?
      ;;
    --delay)
      shift
      sleepDelay=$(usageArgumentUnsignedInteger "$usage" "$argument" "${1-}") || return $?
      ;;
    *)
      if [ -z "$loopCallable" ]; then
        loopCallable=$(usageArgumentCallable "$usage" "loopCallable" "$1") || return $?
        shift
        break
      fi
      ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  [ -n "$loopCallable" ] || __throwArgument "$usage" "No loopCallable" || return $?
  [ -n "$title" ] || title="$(decorate each code "$loopCallable" "$@")"
  [ ${#until[@]} -gt 0 ] || until=("0")

  local done=false exitCode=0 outputBuffer statusLine rowCount outsideColor
  outsideColor="code"
  outputBuffer=$(fileTemporaryName "$usage") || return $?
  iterations=1
  statusLine="Running first iteration ..."
  rowCount=$(consoleRows)
  while ! $done; do
    local saveY suffix

    if [ $iterations = 1 ]; then
      clear
      suffix=$(decorate notice "(first run)")
    else
      cursorSet 1 1
      suffix=$(decorate warning "(loading)")
    fi

    __catchEnvironment "$usage" boxedHeading --outside "$outsideColor" --inside "$outsideColor" "$title $suffix" | plasterLines || return $?
    printf "%s\n" "$statusLine" | plasterLines
    IFS=$'\n' read -r -d '' _ saveY < <(cursorGet)

    local start showRows

    start=$(timingStart) || return $?
    showRows=$((rowCount - saveY))
    exitCode=0
    set +e +u +o pipefail
    if [ $iterations = 1 ]; then
      "$loopCallable" "$@" 2>&1 || exitCode=$?
    else
      "$loopCallable" "$@" >"$outputBuffer" 2>&1 || exitCode=$?
    fi

    # Compute status line
    local elapsed seconds nLines stamp
    nLines=$(($(wc -l <"$outputBuffer") + 0))
    elapsed=$(($(__catchEnvironment "$usage" timingStart) - start)) || return $?
    seconds=$(timingFormat "$elapsed")
    seconds="$seconds $(plural "$seconds" second seconds)"
    stamp=$(date "+%F %T")
    local exitString
    exitString="$(decorate value "$exitCode") $(decorate label "[$(exitString "$exitCode")]")"
    statusLine="$(decorate blue "[#$iterations]") $(decorate yellow "$stamp") $exitString, $nLines $(plural "$nLines" line lines), $seconds"
    cursorSet 1 1

    if inArray "$exitCode" "${until[@]}"; then
      __catchEnvironment "$usage" boxedHeading --outside "$outsideColor" --inside success "$title (SUCCESS)" | plasterLines || return $?
      printf "%s\n" "$statusLine" | plasterLines || return $?
      __catchEnvironment "$usage" plasterLines <"$outputBuffer" || return $?
      cursorSet 1 "$((rowCount - 1))"
      bigText "Success"
      done=true
    else
      __catchEnvironment "$usage" boxedHeading --outside "$outsideColor" --inside "$outsideColor" "$title $(decorate orange "(looping)")" || echo "EXIT CODE: $?"
      printf "%s\n" "$statusLine" | plasterLines || return $?
      (
        tail -n "$showRows" <"$outputBuffer"
        [ "$showRows" -lt "$nLines" ] || repeat "$((showRows - nLines))" "\n"
      ) | plasterLines
      elapsed=$((elapsed / 1000))
      if [ "$elapsed" -lt "$sleepDelay" ]; then
        cursorSet 1 "$((saveY - 1))"
        __catchEnvironment "$usage" interactiveCountdown --prefix "$statusLine, running $title in " "$((sleepDelay - elapsed))" || return $?
      fi
    fi
    iterations=$((iterations + 1))
    rowCount=$(consoleRows)
  done
  __catchEnvironment "$usage" rm -rf "$outputBuffer" || return $?
}
_loopExecute() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: {fn} loopCallable fileToCheck ...
# Argument: loopCallable - Required. Callable. Call this on each file and a zero result code means passed and non-zero means fails.
# Argument: --exec binary - Optional. Callable. Run binary with files as an argument for any failed files. Only works if you pass in item names.
# Argument: --delay delaySeconds - Optional. Integer. Delay in seconds between checks in interactive mode.
# Argument: fileToCheck ... - Optional. File. Shell file to validate. May also supply file names via stdin.
# Run checks interactively until errors are all fixed.
# Not ready for prime time yet - written not tested.
interactiveManager() {
  local usage="_${FUNCNAME[0]}"

  local binary="" repairFunction"" loopCallable="" files=() sleepDelay=15

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
      if [ -z "$loopCallable" ]; then
        loopCallable=$(usageArgumentCallable "$usage" "loopCallable" "$1") || return $?
      else
        files+=("$(usageArgumentFile "$usage" "fileToCheck" "$1")") || return $?
      fi
      ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  [ -n "$loopCallable" ] || __throwArgument "$usage" "No loopCallable" || return $?

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
    while ! "$loopCallable" "$file" >"$output" 2>&1; do
      didClear=true
      clear
      message="$(decorate code "$file") failed $(decorate error "$loopCallable")"
      if ! $triedRepair && [ -n "$repairFunction" ]; then
        triedRepair=true
        if ! "$repairFunction" "$file" >"$output"; then
          message="$message ($repairFunction failed)"
        fi
        if ! "$loopCallable" "$file" >"$output"; then
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
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
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

#
# Ask the user for a menu of options
#
# Exit code: interrupt - Attempts exceeded
# Exit code: timeout - Timeout
# Argument: --choice choiceCharacter - Required. String. Character to accept.
# Argument: --default default - Optional. String. Character to choose when there is a timeout or other failure.
# Argument: --result resultFile - Required. File. File to write the result to.
# Argument: --attempts attemptCount - Optional. PositiveInteger. Number of attempts to try and get valid unput from the user.
# Argument: --timeout timeoutSeconds - Optional. PositiveInteger. Number of seconds to wait for user input before stopping.
# Argument: --prompt promptString - Optional. String. String to suffix the prompt with (usually tells the user what to do)
# Argument: message - Optional. String. Display this message as the confirmation menu.
confirmMenu() {
  local usage="_${FUNCNAME[0]}"
  local default="" message="" timeout="" extras="" attempts=-1 allowed=() resultFile=""

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
    --prompt)
      shift
      extras=$(usageArgumentString "$usage" "$argument" "${1-}") || return $?
      extras=" $(decorate subtle "$extras") "
      ;;
    --result)
      shift
      resultFile=$(usageArgumentFile "$usage" "$argument" "${1-}") || return $?
      ;;
    --attempts)
      shift
      attempts=$(usageArgumentPositiveInteger "$usage" "$argument" "${1-}") || return $?
      ;;
    --timeout)
      shift
      timeout=$(usageArgumentPositiveInteger "$usage" "$argument" "${1-}") || return $?
      ;;
    --choice)
      shift
      allowed+=("$(usageArgumentString "$usage" "$argument" "${1-}")") || return $?
      ;;
    --default)
      shift
      default="$(usageArgumentString "$usage" "$argument" "${1-}")" || return $?
      ;;
    -*)
      # _IDENTICAL_ argumentUnknown 1
      __throwArgument "$usage" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
      ;;
    *)
      message="$*"
      break
      ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  [ "${#allowed[@]}" -gt 0 ] || __throwArgument "$usage" "Need at least one --choice" || return $?
  [ -z "$default" ] || inArray "$default" "${allowed[@]}" || __throwArgument "$usage" "Default $default is not in menu: ${allowed[*]}" || return $?
  [ -n "$resultFile" ] || __throwArgument "$usage" "No --result given" || return $?

  local exitCode=0 value="" defaultOk=false

  while __interactiveCountdownReadCharacter "$usage" "$timeout" "$attempts" "$extras" "$message" __confirmMenuValidate "$resultFile" "${allowed[@]}" || exitCode=$?; do
    case "$exitCode" in
    0)
      return $exitCode
      ;;
    2 | 10)
      value="TIMEOUT"
      defaultOk=true
      exitCode=$(_code timeout)
      break
      ;;
    1 | 11)
      value="ATTEMPTS"
      defaultOk=true
      exitCode=$(_code interrupt)
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
_confirmMenu() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

interactiveCountdown() {
  local usage="_${FUNCNAME[0]}"

  local prefix="" counter="" binary="" runner=("statusMessage" "printf" -- "%s")

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
      shift
      prefix="$(usageArgumentEmptyString "$usage" "$argument" "${1-}")" || return $?
      ;;
    --badge)
      runner=(bigTextAt "-5" "5")
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

  start=$(timingStart) || return $?
  end=$((start + counter * 1000))
  now=$start
  [ -z "$prefix" ] || prefix="$prefix "

  while [ "$now" -lt "$end" ]; do
    __catchEnvironment "$usage" "${runner[@]}" "$(printf "%s%s" "$(decorate info "$prefix")" "$(decorate value " $((counter / 1000)) ")")" || return $?
    sleep 1 || __throwEnvironment "$usage" "Interrupted" || return $?
    now=$(timingStart) || return $?
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
# Argument: --clear - Optional. Flag. Clear the approval status for file given.
# Argument: --prefix - Optional. String. Display this text before each status messages.
# Security: Loads bash files
# Loads files or a directory of `.sh` files using `source` to make the code available.
# Has security implications. Use with caution and ensure your directory is protected.
interactiveBashSource() {
  local usage="_${FUNCNAME[0]}"

  local prefix="Loading" verboseFlag=false aa=(--info) bb=(--attempts 1 --timeout 30) clearFlag=false

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
    --clear)
      clearFlag=true
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
      if "$clearFlag"; then
        __interactiveApproveClear "$usage" "$sourcePath" || return $?
        ! $verboseFlag || statusMessage --last printf -- "%s %s" "$(decorate info "Cleared approval for")" "$displayPath"
        interactiveBashSource "${aa[@]+"${aa[@]}"}" "$sourcePath" || return $?
        return 0
      fi
      if [ -f "$sourcePath" ]; then
        verb="file"
        if __interactiveApprove "$usage" "$sourcePath" "Load" "${aa[@]+"${aa[@]}"}" "${bb[@]}"; then
          ! $verboseFlag || statusMessage --last printf -- "%s %s %s" "$(decorate info "$prefix")" "$(decorate label "$verb")" "$displayPath"
          __catchEnvironment "$usage" source "$sourcePath" || return $?
          approved=true
        fi
      elif [ -d "$sourcePath" ]; then
        verb="path"
        if __interactiveApprove "$usage" "$sourcePath/" "Load path" "${aa[@]+"${aa[@]}"}" "${bb[@]}"; then
          ! $verboseFlag || statusMessage --last printf -- "%s %s %s" "$(decorate info "$prefix")" "$(decorate label "$verb")" "$displayPath"
          __catchEnvironment "$usage" bashSourcePath "$sourcePath" || return $?
          approved=true
        fi
      else
        __throwEnvironment "$usage" "Not a file or directory? $displayPath is a $(decorate value "$(betterType "$sourcePath")")" || return $?
      fi
      if $verboseFlag && ! $approved; then
        statusMessage --last decorate subtle "Skipping unapproved $verb $(decorate file "$sourcePath")" || :
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
