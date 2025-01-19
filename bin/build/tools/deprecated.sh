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

# DEPRECATED
# See: packageUninstall
aptUninstall() {
  packageUninstall --manager apt "$@"
}

# DEPRECATED
# See: packageWhich
whichApt() {
  packageWhich --manager apt "$@"
}

# DEPRECATED
# See: packageWhichUninstall
whichAptUninstall() {
  packageWhichUninstall --manager apt "$@"
}

# DEPRECATED
# See: packageNeedRestartFlag
aptNeedRestartFlag() {
  packageNeedRestartFlag "$@"
}

# Not keeping this around will break old scripts, so don't be a ...
# Deprecated: 2025-01-15
runHook() {
  hookRun "$@"
}

# Not keeping this around will break old scripts, so don't be a ...
# Deprecated: 2025-01-15
runHookOptional() {
  hookRunOptional "$@"
}

# Deprecated: 2024
consoleReset() {
  if hasColors; then
    printf "\e[0m"
  fi
}

# Deprecated: 2024
consoleBlackBackground() {
  __consoleEscape '\033[48;5;0m' '\033[0m' "$@"
}
