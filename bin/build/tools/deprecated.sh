#!/usr/bin/env bash
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
# Graveyard for code
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

# DEPRECATED, `BUILD_COLORS_MODE` no longer used or supported.
# Set colors to deal with dark or light-background consoles
# Deprecated: 2026-01
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional.Display this help.
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
