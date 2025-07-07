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
mostRecentlyModifiedFile() {
  _deprecated "${FUNCNAME[0]}"
  fileModifiedRecentlyName "$@"
}

# DEPRECATED 2025-07-07
mostRecentlyModifiedTimestamp() {
  _deprecated "${FUNCNAME[0]}"
  fileModifiedRecentlyTimestamp "$@"
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

# DEPRECATED 2025-05-16
bashPromptModule_iTerm2Colors() {
  _deprecated "${FUNCNAME[0]}"
  bashPromptModule_TermColors "$@"
}

# DEPRECATED 2025-05-15
# nounAction naming
sshAddKnownHost() {
  _deprecated "${FUNCNAME[@]}"
  sshKnownHostAdd "$@"
}

# DEPRECATED 2025-04-22
# See: readlineConfigurationAdd
inputConfigurationAdd() {
  _deprecated "${FUNCNAME[0]}"
  readlineConfigurationAdd "$@"
}

# DEPRECATED 2025-04-22
# See: decorate wrap
wrapLines() {
  _deprecated "${FUNCNAME[0]}"
  decorate wrap "$@"
}

# DEPRECATED 2025-04-09
# nounAction naming
listFileModificationTimes() {
  _deprecated "${FUNCNAME[0]}"
  fileModificationTimes "$@"
}
