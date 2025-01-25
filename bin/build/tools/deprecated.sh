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

# Not keeping this around will break old scripts, so don't be a ...
# Deprecated: 2025-01-15
runHook() {
  _deprecated "${FUNCNAME[0]}"
  hookRun "$@"
}

# Not keeping this around will break old scripts, so don't be a ...
# Deprecated: 2025-01-15
runHookOptional() {
  _deprecated "${FUNCNAME[0]}"
  hookRunOptional "$@"
}

#__failArgument() {
#  _deprecated "${FUNCNAME[0]}"
#  __throwArgument "$@"
#}
#
#__failEnvironment() {
#  _deprecated "${FUNCNAME[0]}"
#  __throwEnvironment "$@"
#}
#
#__usageEnvironment() {
#  _deprecated "${FUNCNAME[0]}"
#  __catchEnvironment "$@"
#}
#__usageArgument() {
#  _deprecated "${FUNCNAME[0]}"
#  __catchArgument "$@"
#}

# Consider:
# __failArgument -> __throwArgument
# __failEnvironment -> __throwEnvironment
# __usageEnvironment -> __catchEnvironment
# __usageArgument -> __catchArgument
