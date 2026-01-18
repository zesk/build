#!/bin/bash
#
# Identical template
#
# Original of __build
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
#

# IDENTICAL __build EOF

# Load build tools (installing if needed) and runs a command
# Argument: relativeHome - Directory. Optional.Path to application home.
# Argument: installerPath - Directory. Optional.Path to `install-bin-build.sh` binary. Defaults to `bin`
# Argument: command ... - Callable. Optional.A command to run and optional arguments.
# Requires: __install
# Example:     __build ../../.. functionToCall "$@"
__build() {
  local relative="${1:-".."}" installerPath="${2:-"bin"}" && shift && shift
  __install "$installerPath/install-bin-build.sh" "bin/build/tools.sh" "$relative" "$@" || return $?
}
