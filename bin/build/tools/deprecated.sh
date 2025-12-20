#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
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

# DEPRECATED 2025-07-29
checkDockerEnvFile() {
  _deprecated "${FUNCNAME[0]}"
  environmentFileIsDocker "$@"
}

# DEPRECATED 2025-07-23
anyEnvToDockerEnv() {
  _deprecated "${FUNCNAME[0]}"
  anyEnvToDockerEnv "$@"
}

# DEPRECATED 2025-07-23
anyEnvToBashEnv() {
  _deprecated "${FUNCNAME[0]}"
  environmentFileToBashCompatible "$@"
}

# DEPRECATED 2025-07-23
dockerEnvToBash() {
  _deprecated "${FUNCNAME[0]}"
  environmentFileDockerToBashCompatible "$@"
}

# DEPRECATED 2025-07-23
dockerEnvFromBashEnv() {
  _deprecated "${FUNCNAME[0]}"
  environmentFileBashCompatibleToDocker "$@"
}

# DEPRECATED 2025-07-23
copyFile() {
  _deprecated "${FUNCNAME[0]}"
  fileCopy "$@"
}

# DEPRECATED 2025-07-23
copyFileWouldChange() {
  _deprecated "${FUNCNAME[0]}"
  fileChange "$@"
}

# DEPRECATED 2025-07-16
allColorTest() {
  _deprecated "${FUNCNAME[0]}"
  colorSampleCodes "$@"
}

# DEPRECATED 2025-07-16
colorTest() {
  _deprecated "${FUNCNAME[0]}"
  colorSampleStyles "$@"
}

# DEPRECATED 2025-07-16
semanticColorTest() {
  _deprecated "${FUNCNAME[0]}"
  colorSampleSemanticStyles "$@"
}

# DEPRECATED 2025-07-16
colorComboTest() {
  _deprecated "${FUNCNAME[0]}"
  colorSampleCombinations "$@"
}

# DEPRECATED 2025-07-07
_code() {
  _deprecated "${FUNCNAME[0]}"
  returnCode "$@"
}

# DEPRECATED 2025-07-07
getFromPipelineYML() {
  _deprecated "${FUNCNAME[0]}"
  bitbucketGetVariable "$@"
}

# DEPRECATED 2025-07-07
_clean() {
  _deprecated "${FUNCNAME[0]}"
  returnClean "$@"
}

# DEPRECATED 2025-07-07
_undo() {
  _deprecated "${FUNCNAME[0]}"
  returnUndo "$@"
}

# DEPRECATED 2025-07-07
modifiedDays() {
  _deprecated "${FUNCNAME[0]}"
  fileModifiedDays "$@"
}

# DEPRECATED 2025-07-07
modifiedSeconds() {
  _deprecated "${FUNCNAME[0]}"
  fileModifiedSeconds "$@"
}

# DEPRECATED 2025-07-07
requireFileDirectory() {
  _deprecated "${FUNCNAME[0]}"
  fileDirectoryRequire "$@"
}

# DEPRECATED 2025-07-07
requireDirectory() {
  _deprecated "${FUNCNAME[0]}"
  directoryRequire "$@"
}

# DEPRECATED 2025-07-07
betterType() {
  _deprecated "${FUNCNAME[0]}"
  fileType "$@"
}

# DEPRECATED 2025-07-07
simplifyPath() {
  _deprecated "${FUNCNAME[0]}"
  directoryPathSimplify "$@"
}

# DEPRECATED 2025-07-07
renameFiles() {
  _deprecated "${FUNCNAME[0]}"
  filesRename "$@"
}

# DEPRECATED 2025-07-07
reverseFileLines() {
  _deprecated "${FUNCNAME[0]}"
  fileReverseLines "$@"
}

# DEPRECATED 2025-07-07
renameLink() {
  _deprecated "${FUNCNAME[0]}"
  linkRename "$@"
}

# DEPRECATED 2025-07-07
modificationTime() {
  _deprecated "${FUNCNAME[0]}"
  fileModificationTime "$@"
}

# DEPRECATED 2025-07-07
modificationSeconds() {
  _deprecated "${FUNCNAME[0]}"
  fileModificationSeconds "$@"
}

# DEPRECATED 2025-07-07
isEmptyFile() {
  _deprecated "${FUNCNAME[0]}"
  fileIsEmpty "$@"
}

# DEPRECATED 2025-07-07
isNewestFile() {
  _deprecated "${FUNCNAME[0]}"
  fileIsNewest "$@"
}

# DEPRECATED 2025-07-07
isOldestFile() {
  _deprecated "${FUNCNAME[0]}"
  fileIsOldest "$@"
}

# DEPRECATED 2025-07-07
oldestFile() {
  _deprecated "${FUNCNAME[0]}"
  fileOldest "$@"
}

# DEPRECATED 2025-07-07
newestFile() {
  _deprecated "${FUNCNAME[0]}"
  fileNewest "$@"
}

# DEPRECATED 2025-07-07
truncateFloat() {
  _deprecated "${FUNCNAME[0]}"
  floatTruncate "$@"
}

# DEPRECATED 2025-07-07
roundFloat() {
  _deprecated "${FUNCNAME[0]}"
  floatRound "$@"
}

# DEPRECATED 2025-07-07
timestampToDate() {
  _deprecated "${FUNCNAME[0]}"
  dateFromTimestamp "$@"
}

# DEPRECATED 2025-07-07
hostIPList() {
  _deprecated "${FUNCNAME[0]}"
  networkIPList "$@"
}
