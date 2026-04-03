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

# Deprecated: 2026-04
# See: bashSimpleDocumentation
usageDocumentSimple() {
  _deprecated "${FUNCNAME[0]}"
  bashSimpleDocumentation "$@"
}

# Deprecated: 2026-04
# See: bashDocumentation
usageDocument() {
  _deprecated "${FUNCNAME[0]}"
  bashDocumentation "$@"
}

# Deprecated: 2026-04
# See: textCannon
cannon() {
  _deprecated "${FUNCNAME[0]}"
  textCannon "$@"
}

# Deprecated: 2026-04
# See: localePlural
plural() {
  _deprecated "${FUNCNAME[0]}"
  localePlural "$@"
}

# Deprecated: 2026-04
# See: stringHideNewlines
pluralWord() {
  _deprecated "${FUNCNAME[0]}"
  localePluralWord "$@"
}

# Deprecated: 2026-04
# See: stringHideNewlines
newlineHide() {
  _deprecated "${FUNCNAME[0]}"
  stringHideNewlines "$@"
}

# Deprecated: 2026-04
# See: bashPromptModule_BuildProject
bashPromptModule_binBuild() {
  _deprecated "${FUNCNAME[0]}"
  bashPromptModule_BuildProject "$@"
}

# Heading for section output
#
# Summary: Text heading decoration
# Argument: --outside outsideStyle - String. Optional. Style to apply to the outside border. (Default `decoration`)
# Argument: --inside insideStyle - String. Optional. Style to apply to the inside spacing. (Default blank)
# Argument: --shrink characterCount - UnsignedInteger. Optional. Reduce the box by this many characters wide. (Default 0)
# Argument: --size lineCount - UnsignedInteger. Optional. Print this many blank lines between the header and title. (Default 1)
# Argument: text ... - Text to put in the box
# Example:     consoleHeadingBoxed Moving ...
# Output:     +==========================================================================+
# Output:     |                                                                          |
# Output:     | Moving ...                                                               |
# Output:     |                                                                          |
# Output:     +==========================================================================+
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Deprecated: 2026-03
# See: __decorateExtensionBox
consoleHeadingBoxed() {
  _deprecated "${FUNCNAME[0]}"
  decorate box "$@"
}
_consoleHeadingBoxed() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Deprecated: 2026-03
# See: executeLoop
loopExecute() {
  _deprecated "${FUNCNAME[0]}"
  executeLoop "$@" || return $?
}

# Deprecated: 2026-03
# See: stringRandom
randomString() {
  _deprecated "${FUNCNAME[0]}"
  stringRandom "$@"
}

# Deprecated: 2026-03
# See: executableRequire
usageRequireBinary() {
  _deprecated "${FUNCNAME[0]}"
  executableRequire "$@"
}

# Deprecated: 2026-03
# See: environmentRequire
usageRequireEnvironment() {
  _deprecated "${FUNCNAME[0]}"
  environmentRequire "$@"
}

# Deprecated: 2026-03
# See: gitTagVee
veeGitTag() {
  _deprecated "${FUNCNAME[0]}"
  gitTagVee "$@"
}

# Deprecated: 2026-03
# See: directoryWatch
watchDirectory() {
  _deprecated "${FUNCNAME[0]}"
  directoryWatch "$@"
}

# Deprecated: 2026-03
# See: textSHA
shaPipe() {
  _deprecated "${FUNCNAME[0]}"
  textSHA "$@"
}

# Deprecated: 2026-03
# See: logRotate
rotateLog() {
  _deprecated "${FUNCNAME[0]}"
  logRotate "$@"
}

# Deprecated: 2026-03
# See: logRotates
rotateLogs() {
  _deprecated "${FUNCNAME[0]}"
  logRotates "$@"
}

# Deprecated: 2026-03
# See: stringUppercase
uppercase() {
  _deprecated "${FUNCNAME[0]}"
  stringUppercase "$@"
}

# Deprecated: 2026-03
# See: stringLowercase
lowercase() {
  _deprecated "${FUNCNAME[0]}"
  stringLowercase "$@"
}

# Deprecated: 2026-03
# See: stringUnquote
unquote() {
  _deprecated "${FUNCNAME[0]}"
  stringUnquote "$@"
}

# Deprecated: 2026-03
# See: cpuLoadAverage
loadAverage() {
  _deprecated "${FUNCNAME[0]}"
  cpuLoadAverage "$@"
}

# Deprecated: 2026-03
# See: booleanParse
parseBoolean() {
  _deprecated "${FUNCNAME[0]}"
  booleanParse "$@"
}

# Deprecated: 2026-03
# See: integerClamp
clampDigits() {
  _deprecated "${FUNCNAME[0]}"
  integerClamp "$@"
}

# Deprecated: 2026-03
# See: textReplaceFirst
replaceFirstPattern() {
  _deprecated "${FUNCNAME[0]}"
  textReplaceFirst "$@"
}

# Deprecated: 2026-03
# See: textReplace
stringReplace() {
  _deprecated "${FUNCNAME[0]}"
  textReplace "$@"
}

# Deprecated: 2026-03
# See: textTrimBoth
trimBoth() {
  _deprecated "${FUNCNAME[0]}"
  textTrimBoth "$@"
}

# Deprecated: 2026-03
# See: textTrimHead
trimHead() {
  _deprecated "${FUNCNAME[0]}"
  textTrimHead "$@"
}

# Deprecated: 2026-03
# See: textTrimTail
trimTail() {
  _deprecated "${FUNCNAME[0]}"
  textTrimTail "$@"
}

# Deprecated: 2026-03
# See: textSingleBlankLines
singleBlankLines() {
  _deprecated "${FUNCNAME[0]}"
  textSingleBlankLines "$@"
}

# Deprecated: 2026-03
# See: textTrimRight
trimRightSpace() {
  _deprecated "${FUNCNAME[0]}"
  textTrimRight "$@"
}

# Deprecated: 2026-03
# See: textTrimLeft
trimLeftSpace() {
  _deprecated "${FUNCNAME[0]}"
  textTrimLeft "$@"
}

# Deprecated: 2026-03
# See: trimSpace
trimSpace() {
  _deprecated "${FUNCNAME[0]}"
  textTrim "$@"
}

# Deprecated: 2026-03
# See: textRemoveFields
removeFields() {
  _deprecated "${FUNCNAME[0]}"
  textRemoveFields "$@"
}

# Deprecated: 2026-01
# See: stringFound
isSubstring() {
  _deprecated "${FUNCNAME[0]}"
  stringFound "$@"
}

# Deprecated: 2026-01
# See: stringFoundInsensitive
isSubstringInsensitive() {
  _deprecated "${FUNCNAME[0]}"
  stringFoundInsensitive "$@"
}

# Deprecated: 2026-01
# See: hookExists
hasHook() {
  _deprecated "${FUNCNAME[0]}"
  hookExists "$@"
}

# Load test tools
# Deprecated: 2025-01 - just call `testSuite` which does this
# Deprecated: 2026-01
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Argument: binary - Callable. Optional. Run this program after loading test tools.
# Argument: ... - Optional. Arguments. Arguments for binary.
# See: testSuite
testTools() {
  local handler="_${FUNCNAME[0]}"

  __help "$handler" "${1-}" || return 0

  _deprecated "${FUNCNAME[0]}"

  __testLoader "$handler" : || return $?
  catchEnvironment "$handler" isFunction __testSuite || return $?

  [ $# -ne 0 ] || return 0
  isCallable "$1" || throwArgument "$handler" "$1 is not callable" || return $?
  catchEnvironment "$handler" "$@" || return $?
}
_testTools() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Deprecated: 2026-01
# See: fileFieldMaximum
maximumFieldLength() {
  _deprecated "${FUNCNAME[0]}"
  fileFieldMaximum "$@"
}

# Deprecated: 2026-01
# See: fileLineMaximum
maximumLineLength() {
  _deprecated "${FUNCNAME[0]}"
  fileLineMaximum "$@"
}

# Deprecated: 2026-01
# See: consoleHeadingBoxed
boxedHeading() {
  _deprecated "${FUNCNAME[0]}"
  consoleHeadingBoxed "$@" || return $?
}

# Deprecated: 2026-01
# See: consoleHeadingLine
lineFill() {
  _deprecated "${FUNCNAME[0]}"
  consoleHeadingLine
}

# Deprecated: 2026-01
# See: textRepeat
repeat() {
  _deprecated "${FUNCNAME[0]}"
  textRepeat "$@"
}

# Deprecated: 2026-01
# See: executableExists
whichExists() {
  _deprecated "${FUNCNAME[0]}"
  executableExists "$@"
}

# Deprecated: 2026-01
# See: hookFind
whichHook() {
  _deprecated "${FUNCNAME[0]}"
  hookFind "$@"
}

# Deprecated: 2026-01
# See: fileExtensionLists
extensionLists() {
  fileExtensionLists "$@"
}

# Deprecated: 2026-01
# See: dateYesterday
yesterdayDate() {
  _deprecated "${FUNCNAME[0]}"
  dateYesterday "$@"
}

# Deprecated: 2026-01
# See: dateToday
todayDate() {
  _deprecated "${FUNCNAME[0]}"
  dateToday "$@"
}

# Deprecated: 2026-01
# See: dateTomorrow
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
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Deprecated: 2026-01
# See: bashMakeExecutable
makeShellFilesExecutable() {
  _deprecated "${FUNCNAME[0]}"
  bashMakeExecutable "$@" || return $?
}

# Deprecated: 2026-01
# See: consoleLine
echoBar() {
  _deprecated "${FUNCNAME[0]}"
  consoleLine "$@" || return $?
}

# Deprecated: 2026-01
# shellcheck disable=SC2329
# See: pathIsAbsolute
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
# See: bashFindUncaughtAssertions
findUncaughtAssertions() {
  _deprecated "${FUNCNAME[0]}"
  bashFindUncaughtAssertions "$@" || return $?
}

# See: filesOpenStatus
# Deprecated: 2026-01
debugOpenFiles() {
  _deprecated "${FUNCNAME[0]}"
  filesOpenStatus "$@" || return $?
}

# See: consoleLineFill
# Deprecated: consoleLineFill
clearLine() {
  _deprecated "${FUNCNAME[0]}"
  consoleLineFill "$@"
}

# Deprecated: 2026-01
# See: textSHA
# Use `textSHA --cache cacheDirectory` instead
#
# Argument: cacheDirectory - Directory. Optional. The directory where cache files can be stored exclusively for this function. Supports a blank value to disable caching, otherwise, it must be a valid directory.
# Argument: filename - File. Optional. File determine the sha value for.
# Depends: sha1sum textSHA
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
    textSHA "$@"
  else
    textSHA --cache "$@"
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
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
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
