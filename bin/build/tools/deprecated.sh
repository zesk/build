#!/usr/bin/env bash
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
# Graveyard for code - 6 month death after it appears here. Same for deprecated.txt support.
#
# You should stop using these. Soon. Now. Yesterday.
#
# This file *should* be ignored by the other deprecated.sh
#

#
#   ____                                _           _
#  |  _ \  ___ _ __  _ __ ___  ___ __ _| |_ ___  __| |
#  | | | |/ _ \ '_ \| '__/ _ \/ __/ _` | __/ _ \/ _` |
#  | |_| |  __/ |_) | | |  __/ (_| (_| | ||  __/ (_| |
#  |____/ \___| .__/|_|  \___|\___\__,_|\__\___|\__,_|
#             |_|
#

# Deprecated: 2026-01
maximumFieldLength() {
  _deprecated "${FUNCNAME[0]}"
  fileFieldMaximum "$@"
}

# Deprecated: 2026-01
maximumLineLength() {
  _deprecated "${FUNCNAME[0]}"
  fileLineMaximum "$@"
}

# Deprecated: 2026-01
boxedHeading() {
  _deprecated "${FUNCNAME[0]}"
  consoleHeadingBoxed "$@" || return $?
}

# Deprecated: 2026-01
lineFill() {
  _deprecated "${FUNCNAME[0]}"
  consoleHeadingLine
}

# Deprecated: 2026-01
repeat() {
  _deprecated "${FUNCNAME[0]}"
  textRepeat "$@"
}

# Deprecated: 2026-01
whichExists() {
  _deprecated "${FUNCNAME[0]}"
  executableExists "$@"
}

# Deprecated: 2026-01
whichHook() {
  _deprecated "${FUNCNAME[0]}"
  hookFind "$@"
}

# Deprecated: 2026-01
extensionLists() {
  fileExtensionLists "$@"
}

# Deprecated: 2026-01
yesterdayDate() {
  _deprecated "${FUNCNAME[0]}"
  dateYesterday "$@"
}

# Deprecated: 2026-01
todayDate() {
  _deprecated "${FUNCNAME[0]}"
  dateToday "$@"
}

# Deprecated: 2026-01
tomorrowDate() {
  _deprecated "${FUNCNAME[0]}"
  dateTomorrow "$@"
}

# Summary: Output debugging information when the build fails
#
# Outputs debugging information after build fails:
#
# - last 50 lines in build log
# - Failed message
# - last 3 lines in build log
#
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
# Deprecated: 2026-01
buildFailed() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0

  local quietLog="${1-}" && shift
  _deprecated "${FUNCNAME[0]}"

  local failBar
  failBar="$(consoleHeadingLine "*")"
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

# Deprecated: 2026-01
makeShellFilesExecutable() {
  _deprecated "${FUNCNAME[0]}"
  bashMakeExecutable "$@" || return $?
}

# Deprecated: 2026-01
echoBar() {
  _deprecated "${FUNCNAME[0]}"
  consoleLine "$@" || return $?
}

# Deprecated: 2026-01
# shellcheck disable=SC2329
isAbsolutePath() {
  _deprecated "${FUNCNAME[0]}"
  pathIsAbsolute "$@" || return $?
}

# Deprecated: 2026-01
insideDocker() {
  true || isAbsolutePath --help
  _deprecated "${FUNCNAME[0]}"
  dockerInside "$@" || return $?
}

# Deprecated: 2026-01
hasConsoleAnimation() {
  _deprecated "${FUNCNAME[0]}"
  consoleHasAnimation "$@" || return $?
}

# Deprecated: 2026-01
hasColors() {
  _deprecated "${FUNCNAME[0]}"
  consoleHasColors "$@" || return $?
}

# Deprecated: 2026-01
findUncaughtAssertions() {
  _deprecated "${FUNCNAME[0]}"
  bashFindUncaughtAssertions "$@" || return $?
}

# Deprecated: 2026-01
debugOpenFiles() {
  _deprecated "${FUNCNAME[0]}"
  filesOpenStatus "$@" || return $?
}

clearLine() {
  _deprecated "${FUNCNAME[0]}"
  consoleLineFill "$@"
}

# Deprecated: 2026-01
# See: shaPipe
# Use `shaPipe --cache cacheDirectory` instead
#
# Argument: cacheDirectory - Directory. Optional. The directory where cache files can be stored exclusively for this function. Supports a blank value to disable caching, otherwise, it must be a valid directory.
# Argument: filename - File. Optional. File determine the sha value for.
# Depends: sha1sum shaPipe
# Summary: SHA1 checksum of standard input
# Example:     cachedShaPipe "$cacheDirectory" < "$fileName"
# Example:     cachedShaPipe "$cacheDirectory" "$fileName0" "$fileName1"
# Output: cf7861b50054e8c680a9552917b43ec2b9edae2b
# stdin: any file
# stdout: `String`. A hexadecimal string which uniquely represents the data in `stdin`.
cachedShaPipe() {
  local cacheDirectory="${1-}"
  _deprecated "${FUNCNAME[0]}"
  if [ "${cacheDirectory#-}" != "${cacheDirectory}" ]; then
    shaPipe "$@"
  else
    shaPipe --cache "$@"
  fi
}

# DEPRECATED, `BUILD_COLORS_MODE` no longer used or supported.
# Set colors to deal with dark or light-background consoles
# Deprecated: 2026-01
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# BUILD_DEBUG: BUILD_COLORS_MODE - Output the color mode when it is changed
consoleColorMode() {
  local handler="_${FUNCNAME[0]}"
  _deprecated "${handler#_}" "Use consoleConfigureDecorate" || :
  consoleConfigureDecorate
}

_consoleColorMode() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Validates a value is not blank and is an environment file which is loaded immediately.
#
# Argument: usageFunction - Function. Required. Run if handler fails
# Argument: variableName - String. Required. Name of variable being tested
# Argument: variableValue - String. Required. Required. only in that if it's blank, it fails.
# Argument: noun - String. Optional. Noun used to describe the argument in errors, defaults to `file`
# Return Code: 2 - Argument error
# Return Code: 0 - Success
# Upon success, outputs the file name to stdout, outputs a console message to stderr
usageArgumentLoadEnvironmentFile() {
  _deprecated "${FUNCNAME[0]}"
  local envFile bashEnv usageFunction returnCode

  usageFunction="$1"
  envFile=$(validate "$usageFunction" File "${3-}") || return $?
  bashEnv=$(fileTemporaryName "$usageFunction") || return $?
  catchEnvironment "$usageFunction" environmentFileToBashCompatible "$envFile" >"$bashEnv" || returnClean $? "$bashEnv" || return $?
  set -a # UNDO ok
  # shellcheck source=/dev/null
  source "$bashEnv"
  returnCode=$?
  set +a
  rm -f "$bashEnv" || :
  if [ $returnCode -ne 0 ]; then
    "$usageFunction" "$returnCode" "source $envFile -> $bashEnv failed" || return $?
  fi
  printf "%s\n" "$envFile"
}

# DEPRECATED 2025-10-05
__catch() {
  # TODO Add this back in after another release
  catchReturn "$@" || return $?
}

# DEPRECATED 2025-10-05
__catchCode() {
  _deprecated "${FUNCNAME[0]}"
  catchCode "$@" || return $?
}

# DEPRECATED 2025-10-05
__throwEnvironment() {
  _deprecated "${FUNCNAME[0]}"
  throwEnvironment "$@" || return $?
}

# DEPRECATED 2025-10-05
__catchEnvironment() {
  _deprecated "${FUNCNAME[0]}"
  catchEnvironment "$@" || return $?
}

# DEPRECATED 2025-10-05
__catchArgument() {
  _deprecated "${FUNCNAME[0]}"
  catchArgument "$@" || return $?
}

# DEPRECATED 2025-10-05
__execute() {
  _deprecated "${FUNCNAME[0]}"
  execute "$@" || return $?
}

# DEPRECATED 2025-10-05
__echo() {
  _deprecated "${FUNCNAME[0]}"
  executeEcho "$@" || return $?
}

# DEPRECATED 2025-10-05
_choose() {
  _deprecated "${FUNCNAME[0]}"
  booleanChoose "$@"
}

# DEPRECATED 2025-10-03
newRelease() {
  _deprecated "${FUNCNAME[0]}"
  releaseNew "$@"
}

# DEPRECATED 2025-10-03
_home() {
  _deprecated "${FUNCNAME[0]}"
  userRecordHome "$@"
}

# DEPRECATED 2025-10-03
_argument() {
  _deprecated "${FUNCNAME[0]}"
  returnArgument "$@"
}

# DEPRECATED 2025-10-03
_environment() {
  _deprecated "${FUNCNAME[0]}"
  returnEnvironment "$@"
}

# DEPRECATED 2025-10-03
__environment() {
  _deprecated "${FUNCNAME[0]}"
  __catchEnvironment "returnMessage" "$@"
}

# DEPRECATED 2025-10-03
__argument() {
  _deprecated "${FUNCNAME[0]}"
  __catchArgument "returnMessage" "$@"
}

# DEPRECATED 2025-10-03
isAbsolutePath() {
  _deprecated "${FUNCNAME[0]}"
  pathIsAbsolute "$@"
}

# DEPRECATED 2025-07-29
interactiveBashSource() {
  _deprecated "${FUNCNAME[0]}"
  approveBashSource "$@"
}
