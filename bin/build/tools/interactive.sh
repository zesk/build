#!/usr/bin/env bash
#
# Interactivity
#
# Copyright &copy; 2024 Market Acumen, LLC
#
# Depends: text.sh colors.sh
# bin: test echo printf
# Docs: o ./docs/_templates/tools/interactive.md
# Test: o ./test/tools/interactive-tests.sh

# IDENTICAL errorArgument 1
errorArgument=2

####################################################################################################
####################################################################################################
#  ▜▘   ▐              ▐  ▗                         ▐
#  ▐ ▛▀▖▜▀ ▞▀▖▙▀▖▝▀▖▞▀▖▜▀ ▄▌ ▌▞▀▖ ▞▀▘▌ ▌▛▀▖▛▀▖▞▀▖▙▀▖▜▀
#  ▐ ▌ ▌▐ ▖▛▀ ▌  ▞▀▌▌ ▖▐ ▖▐▐▐ ▛▀  ▝▀▖▌ ▌▙▄▘▙▄▘▌ ▌▌  ▐ ▖
#  ▀▘▘ ▘ ▀ ▝▀▘▘  ▝▀▘▝▀  ▀ ▀▘▘ ▝▀▘ ▀▀ ▝▀▘▌  ▌  ▝▀ ▘   ▀
####################################################################################################
####################################################################################################

#
# Usage: _escalatedFileCopy displaySource source destination verb
#
_escalatedFileCopy() {
  consoleReset
  printf "\n%s -> %s: %s\n\n" "$(consoleGreen "$1")" "$(consoleRed "$3")" "$(consoleBoldRed "$4")"
  if confirmYesNo yes "$(printf "%s: %s\n(%s/%s - default %s)? " \
    "$(consoleBold Copy privileged file to)" \
    "$(consoleCode "$3")" \
    "$(consoleRed Yes)" \
    "$(consoleGreen No)" "$(consoleRed Yes)")"; then
    cp "$2" "$3"
    return 0
  fi
  printf "%s \"%s\"\n" "$(consoleError "Used declined update of")" "$(consoleRed "$3")" 1>&2
  return "$errorArgument"
}

#
# Usage: _regularFileCopy displaySource source destination verb
#
_regularFileCopy() {
  local displaySource="$1" source="$2" destination="$3" verb="$4"
  consoleReset
  local displaySource="${displaySource##"$devopsHome"}"
  printf "%s -> %s: %s" "$(consoleGreen "$displaySource")" "$(consoleRed "$destination")" "$(consoleCyan "$verb")"
  cp "$source" "$destination"
  return 0
}

_copyPrompt() {
  local source="$1" destination="$2" verb="$3"
  printf "%s -> %s %s" "$(consoleGreen "$source")" "$(consoleRed "$destination")" "$(consoleCyan "$verb")"
}

# Usage: {fn} source destination verb
# Argument: displaySource - Source path
# Argument: displayDestination - Destination path
# Argument: verb - Descriptive verb of what's up
_showFileContents() {
  _copyPrompt "$@"
  prefixLines "$(consoleCode)"
  printf "%s\n" "$(consoleReset)"
}

#
# Show changes in a file with a header
#
# Usage: {fn} source destination verb
#
_showChangedFile() {
  diff "$mappedSource" "$destination" | sed '1d' | _showFileContents "$1" "$destination" "Changes"
}

#
# Show a new file which will be added
#
# Usage: {fn} displaySource source destination
# Argument: displaySource - Source path to show
# Argument: source - Actual source path
# Argument: destination - Destination path
_showNewFile() {
  local displaySource="$1" source="$2" destination="$3"
  local lines
  head -10 "$source" | _showFileContents "$displaySource" "$destination" "Changes"
  lines=$(($(wc -l <"$source") + 0))
  consoleInfo "$(printf "%d %s total" "$lines" "$(plural "$lines" line lines)")"
}

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

# Parses text and determines if it's a yes.
#
# Usage: yesNo text
# Exit Code: 0 - Yes
# Exit Code: 1 - No
# Exit Code: 2 - Neither
# See: lowercase
#
yesNo() {
  case "$(lowercase "$1")" in
    y | yes | 1 | true)
      return 0
      ;;
    n | no | 0 | false)
      return 1
      ;;
  esac
  return 2
}

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
    if yesNo "$yes"; then
      return 0
    fi
    if [ $? -eq 1 ]; then
      return 1
    fi
    if [ -n "$default" ]; then
      yesNo "$default"
      return $?
    fi
    printf "%s" "$*"
  done
}

#
#
# Usage: copyFileChanged source destination
# Argument: source - Source path
# Argument: destination - Destination path
# Exit Code: 0 - Something changed
# Exit Code: 1 - Nothing changed
#
copyFileChanged() {
  local source="$1" destination="$2"
  local verb

  if [ ! -f "$source" ]; then
    consoleError "copyFileChanged source \"$source\" does not exist" 1>&2
    return 1
  fi
  if [ -f "$destination" ]; then
    if ! diff -q "$source" "$destination"; then
      _copyPrompt "$source" "$destination" "Changes"
      diff "$source" "$destination" | sed '1d' | prefixLines "$(consoleCode)"
      consoleReset
      verb="File was updated"
    else
      return 1
    fi
  else
    _showNewFile "$source" "$source" "$destination"
    verb="File was created"
  fi
  _regularFileCopy "$source" "$source" "$destination" "$verb"
}

#
# Usage: copyFileChangedQuiet source destination
# Argument: source - Source file path
# Argument: destination - Destination file path
# Exit code: 0 - Never fails
# See: copyFileChanged
#
copyFileChangedQuiet() {
  copyFileChanged "$@" || :
}

#
# Map a file using environment variables before copying, return 0 if something changed
#
# Usage: mapCopyFileChanged source destination
# Argument: from - Source path
# Argument: to - Destination path
# Exit Code: 0 - Something changed
# Exit Code: 1 - Nothing changed
#
mapCopyFileChanged() {
  local source="$1" destination="$2"
  local mappedSource verb
  mappedSource=$(mktemp)
  mapEnvironment <"$source" >"$mappedSource"
  if [ -f "destination" ]; then
    if ! diff -q "$mappedSource" "destination"; then
      _showChangedFile "$source" "$mappedSource" "destination"
      verb="File was updated"
    else
      return 1
    fi
  else
    _showNewFile "$source" "$mappedSource" "destination"
    verb="File was created"
  fi
  _regularFileCopy "$source" "$mappedSource" "destination" "*$verb"
}

#
# Usage: escalatedCopyFileChanged source destination
# Argument: source - Source file path
# Argument: destination - Destination file path
# Exit Code: 0 - Something changed
# Exit Code: 1 - Nothing changed
# Used when copying a file from a non-privileged user to a privileged location (root) or anything which allows for user
# escalation privileges. Maps the file using local environment.
#
escalatedMapCopyFileChanged() {
  local source="$1" destination="$2"
  local mappedSource verb
  mappedSource=$(mktemp)
  mapEnvironment <"$source" >"$mappedSource"
  if [ -f "$destination" ]; then
    if ! diff -q "$mappedSource" "$destination"; then
      _showChangedFile "$source" "$mappedSource" "$destination"
      verb="File has changed and needs update"
    else
      return 1 # unchanged
    fi
  else
    _showNewFile "$source" "$mappedSource" "$destination"
    verb="Needs to be created"
  fi
  if [ -n "$verb" ]; then
    _escalatedFileCopy "$source" "$mappedSource" "$destination" "*$verb"
  else
    return 1 # unchanged
  fi
}

# Usage: escalatedCopyFileChanged source destination
# Argument: source - Source file path
# Argument: destination - Destination file path
# Exit Code: 0 - Something changed
# Exit Code: 1 - Nothing changed
#
escalatedCopyFileChanged() {
  local source="$1" destination="$2"
  local verb
  verb=
  if [ -f "$destination" ]; then
    if ! diff -q "$source" "$destination"; then
      diff "$source" "$destination" | prefixLines "$(consoleCode)"
      verb="File has changed and needs update"
    fi
  else
    _showNewFile "$source" "$source" "$destination"
    verb="Needs to be created"
  fi
  if [ -n "$verb" ]; then
    _escalatedFileCopy "$source" "$source" "$destination" "$verb"
  else
    return 1 # unchanged
  fi

}
