#!/bin/bash
#
# Identical template
#
# Original of __build
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Requires: IDENTICAL _return __install
# Example: __build ../../.. functionToCall "$@"

# IDENTICAL __build EOF
# Load build tools (installing if needed) and run command
# Usage: {fn} [ relativeHome installerPath [ command ... ] ]
# Argument: installerPath - Optional. Directory. Path to `install-bin-build.sh` binary.
# Argument: relativeHome - Required. Directory. Path to application home.
# Argument: command ... - Optional. Callable. A command to run and optional arguments.
__build() {
  local relative="${1:-".."}" installerPath="${2:-"bin"}" && shift && shift
  __install "$installerPath/install-bin-build.sh" "bin/build/tools.sh" "$relative" "$@" || return $?
}
