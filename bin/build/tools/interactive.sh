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
  printf "%s" "$prompt"
  read -r prompt
}

#
# Read user input and return 0 if the user says yes
# Exit Code: 0 - Yes
# Exit Code: 1 - No
# Usage: {fn} [ --default defaultValue ] [ --yes ] [ --no ]
# Argument: defaultValue - Boolean. Optional. Value to return if no value given by user
# Argument: --yes - Boolean. Optional. Short for `--default yes`
# Argument: --no - Boolean. Optional. Short for `--default no`
confirmYesNo() {
  local default yes

  local saved=("$@") nArguments=$#
  while [ $# -gt 0 ]; do
    local argument argumentIndex=$((nArguments - $# + 1))
    argument="$(usageArgumentString "$usage" "argument #$argumentIndex (Arguments: $(_command "${usage#_}" "${saved[@]}"))" "$1")" || return $?
    case "$argument" in
      # IDENTICAL --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --yes) default=yes ;;
      --no) default=no ;;
      --default)
        shift
        default="$(usageArgumentString "$usage" "$argument" "${1-}")" || return $?
        ;;
      *)
        message="$*"
        break
        ;;
    esac
    # IDENTICAL argument-esac-shift 1
    shift || __failArgument "$usage" "missing argument #$argumentIndex: $argument (Arguments: $(_command "${usage#_}" "${saved[@]}"))" || return $?
  done

  statusMessage printf "%s" "$message"
  while read -r yes; do
    if parseBoolean "$yes"; then
      return 0
    fi
    if [ $? -eq 1 ]; then
      _environment || return $?
    fi
    if [ -n "$default" ]; then
      parseBoolean "$default"
      return $?
    fi
    statusMessage printf "%s" "$message"
  done
}
_confirmYesNo() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
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
  local argument nArguments
  local source destination this
  local mapFlag copyFunction actualSource verb prefix owner mode
  local exitCode

  this=${FUNCNAME[0]}
  mapFlag=false
  copyFunction=_copyFileRegular
  owner=
  mode=
  nArguments=$#
  while [ $# -gt 0 ]; do
    argument="$1"
    usageArgumentString "$usage" "argument #$((nArguments - $# + 1))" "$argument" || return $?
    case "$argument" in
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
        source="$1"
        [ -f "$source" ] || __failEnvironment "$usage" "$this: source \"$source\" does not exist" || return $?
        shift
        destination=$(usageArgumentFileDirectory _argument "destination" "${1-}") || return $?
        shift
        [ $# -eq 0 ] || __usageArgument "$usage" "unknown argument $1" || return $?
        if $mapFlag; then
          actualSource=$(mktemp)
          if ! mapEnvironment <"$source" >"$actualSource"; then
            rm "$actualSource" || :
            __usageEnvironment "$usage" "Failed to mapEnvironment $source" || return $?
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
          __usageEnvironment "$usage" chown "$owner" "$destination" || exitCode=$?
        fi
        if [ $exitCode -eq 0 ] && [ -n "$mode" ]; then
          __usageEnvironment "$usage" chmod "$mode" "$destination" || exitCode=$?
        fi
        if $mapFlag; then
          rm "$actualSource" || :
        fi
        return $exitCode
        ;;
    esac
    shift || _argument "$this: shift failed" || return $?
  done
  _argument "$this: Missing source" || return $?
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
  local arg source actualSource destination
  local mapFlag

  mapFlag=false
  while [ $# -gt 0 ]; do
    arg="$1"
    [ -n "$arg" ] || _argument "blank argument" || return $?
    case "$arg" in
      --map)
        mapFlag=true
        ;;
      *)
        source="$1"
        if [ ! -f "$source" ]; then
          _environment "copyFileWouldChange: source \"$source\" does not exist" || return $?
        fi
        shift || _argument "Missing destination" || return $?
        destination=$(usageArgumentFileDirectory _argument "destination" "$1") || return $?
        shift || _argument "shift failed" || return $?
        [ $# -eq 0 ] || _argument "Unknown argument $1" || return $?
        if [ ! -f "$destination" ]; then
          return 0
        fi
        if $mapFlag; then
          actualSource=$(mktemp)
          if ! mapEnvironment <"$source" >"$actualSource"; then
            rm -f "$actualSource" || :
            _environment "Failed to mapEnvironment $source" || return $?
          fi
        else
          actualSource="$source"
        fi
        if ! diff -q "$actualSource" "$destination" >/dev/null; then
          return 0
        fi
        if $mapFlag; then
          __environment rm -f "$actualSource" || return $?
        fi
        return 1
        ;;
    esac
    shift || _argument "shift failed" || return $?
  done
  _argument "Missing source" || return $?
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
  local argument nArguments argumentIndex saved triedRepair
  local verificationCallable="" repairFunction="" sleepDelay=15 binary="" didClear=false files=() file
  local rowsAllowed output index nextMessage

  didClear=false
  verificationCallable=
  saved=("$@")
  nArguments=$#
  while [ $# -gt 0 ]; do
    argumentIndex=$((nArguments - $# + 1))
    argument="$(usageArgumentString "$usage" "argument #$argumentIndex (Arguments: $(_command "${usage#_}" "${saved[@]}"))" "$1")" || return $?
    case "$argument" in
      # IDENTICAL --help 4
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
    shift || __failArgument "$usage" "missing argument #$argumentIndex: $argument" || return $?
  done

  [ -n "$verificationCallable" ] || __failArgument "$usage" "No verificationCallable" || return $?

  if [ "${#files[@]}" -eq 0 ]; then
    while read -r file; do files+=("$(usageArgumentFile "$usage" "fileToCheck (stdin)" "$1")"); done
    [ "${#files[@]}" -gt 0 ] || return 0
  fi

  [ "${#files[@]}" -gt 0 ] || __failArgument "$usage" "No files supplied" || return $?

  rowsAllowed=$(__usageEnvironment "$usage" consoleRows) || return $?
  rowsAllowed=$((rowsAllowed - 4))
  output=$(__usageEnvironment "$usage" mktemp) || return $?
  index=1
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
      sleep "$sleepDelay" || __failEnvironment "$usage" "Interrupt ..." || _clean $? "$output" || return $?
    done
    index=$((index + 1))
  done
  if $didClear; then
    clear
    _list "$(decorate success "All files now pass:")" "${files[@]}"
  fi
}
_interactiveManager() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
