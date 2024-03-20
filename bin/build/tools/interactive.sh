#!/usr/bin/env bash
#
# Interactivity
#
# Copyright &copy; 2024 Market Acumen, Inc.
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

#
# Read user input and return 0 if the user says yes
# Exit Code: 0 - Yes
# Exit Code: 1 - No
# Usage: {fn} [ defaultValue ]
# Argument: defaultValue - Value to return if no value given by user
confirmYesNo() {
  local default yes

  default="${1-}"
  shift
  printf "%s" "$*"
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
    printf "%s" "$*"
  done
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
  consoleReset
  printf "\n%s -> %s: %s\n\n" "$(consoleGreen "$1")" "$(consoleRed "$3")" "$(consoleBoldRed "$4")"
  if confirmYesNo yes "$(printf "%s: %s\n(%s/%s - default %s)? " \
    "$(consoleBold Copy privileged file to)" \
    "$(consoleCode "$3")" \
    "$(consoleRed Yes)" \
    "$(consoleGreen No)" "$(consoleRed Yes)")"; then
    __execute cp "$2" "$3"
    return $?
  fi
  printf "%s \"%s\"\n" "$(consoleError "Used declined update of")" "$(consoleRed "$3")" 1>&2
  _argument || return $?
}

#
# Usage: {fn} displaySource source destination verb
#
# Copy a file with no privilege escalation
#
_copyFileRegular() {
  local displaySource="$1" source="$2" destination="$3" verb="$4"
  consoleReset || _copyFilePrompt "OVERRIDE $displaySource" "$destination" "$verb" || :
  __execute cp "$source" "$destination"
}

_copyFilePrompt() {
  local source="$1" destination="$2" verb="$3"
  printf "%s -> %s %s\n" "$(consoleGreen "$source")" "$(consoleRed "$destination")" "$(consoleCyan "$verb")"
}

# Usage: {fn} source destination verb
# Argument: displaySource - Source path
# Argument: displayDestination - Destination path
# Argument: verb - Descriptive verb of what's up
_copyFileShow() {
  _copyFilePrompt "$@"
  wrapLines "$(consoleCode)" "$(consoleReset)"
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
  consoleInfo "$(printf "%d %s total" "$lines" "$(plural "$lines" line lines)")"
}

####################################################################################################
####################################################################################################



# Usage: {fn} [ --map ] [ --escalate ] source destination
# Argument: --map - Flag. Optional. Map environment values into file before copying.
# Argument: --escalate - Flag. Optional. The file is a privilege escalation and needs visual confirmation.
# Argument: source - File. Required. Source path
# Argument: destination - File. Required. Destination path
# Exit Code: 0 - Success
# Exit Code: 1 - Failed
copyFile() {
  local arg source destination this
  local mapFlag copyFunction actualSource verb prefix
  local exitCode

  this=${FUNCNAME[0]}
  mapFlag=false
  copyFunction=_copyFileRegular
  while [ $# -gt 0 ]; do
    arg="$1"
    [ -n "$arg" ] || _argument "$this: Blank argument" || return $?
    case "$arg" in
      --map)
        mapFlag=true
        ;;
      --escalate)
        copyFunction=_copyFileEscalated
        ;;
      *)
        source="$1"
        if [ ! -f "$source" ]; then
          _environment "$this: source \"$source\" does not exist" || return $?
        fi
        shift || _argument "$this: Missing destination" || return $?
        destination=$(usageArgumentFileDirectory _argument "destination" "$1") || return $?
        shift || _argument "$this: shift failed" || return $?
        [ $# -eq 0 ] || _argument "$this: Unknown argument $1" || return $?
        if $mapFlag; then
          actualSource=$(mktemp)
          if ! mapEnvironment <"$source" >"$actualSource"; then
            rm "$actualSource" || :
            _environment "$this: Failed to mapEnvironment $source" || return $?
          fi
          verb=" (mapped)"
        else
          actualSource="$source"
          verb=""
        fi
        if [ -f "$destination" ]; then
          if ! diff -q "$actualSource" "$destination"; then
            prefix="$(consoleSubtle "$(basename "$source")")"
            _copyFilePrompt "$source" "$destination" "Changes" || :
            diff "$source" "$destination" | sed '1d' | wrapLines "$prefix$(consoleCode)" "$(consoleReset)" || :
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
  copyFunction=_copyFileRegular
  while [ $# -gt 0 ]; do
    arg="$1"
    [ -n "$arg" ] || _argument "Blank argument" || return $?
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
        if ! diff -q "$actualSource" "$destination"; then
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
