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

# DEPRECATED 2025-04-09
# nounAction naming
sshAddKnownHost() {
  _deprecated "${FUNCNAME[@]}"
  sshKnownHostAdd "$@"
}
