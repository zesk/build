#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Graveyard for code
#
# You should stop using these. Soon. Now. Yesterday.
#
# This file should be ignored by the other deprecated.sh
#

#
#   ____                                _           _
#  |  _ \  ___ _ __  _ __ ___  ___ __ _| |_ ___  __| |
#  | | | |/ _ \ '_ \| '__/ _ \/ __/ _` | __/ _ \/ _` |
#  | |_| |  __/ |_) | | |  __/ (_| (_| | ||  __/ (_| |
#  |____/ \___| .__/|_|  \___|\___\__,_|\__\___|\__,_|
#             |_|
#

# DEPRECATED 2024-11-29
_integer() {
  _deprecated "${FUNCNAME[0]}"
  isUnsignedInteger "$@"
}

# Not keeping this around will break old scripts, so don't be a ...
# Deprecated: 2025-01-15
runHook() {
  _deprecated "${FUNCNAME[0]}"
  hookRun "$@"
}

# Deprecated: 2025-01-15
runHookOptional() {
  _deprecated "${FUNCNAME[0]}"
  hookRunOptional "$@"
}

# Deprecated: 2025-01-25
__failArgument() {
  _deprecated "${FUNCNAME[0]}"
  __throwArgument "$@" || return $?
}

# Deprecated: 2025-01-25
__failEnvironment() {
  _deprecated "${FUNCNAME[0]}"
  __throwEnvironment "$@" || return $?
}

# Deprecated: 2025-01-25
__usageEnvironment() {
  _deprecated "${FUNCNAME[0]}"
  __catchEnvironment "$@" || return $?
}

# Deprecated: 2025-01-25
__usageArgument() {
  _deprecated "${FUNCNAME[0]}"
  __catchArgument "$@" || return $?
}
