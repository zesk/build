#!/bin/bash
#
# Identical template
#
# Original of __functionSettings
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# IDENTICAL __functionSettings EOF

# Summary: Load cached function comment values
# Argument: home - Directory. BUILD_HOME
# Argument: functionName - String. Function to fetch settings for
# Argument: generatePath - Boolean. Optional. Pass in `true` to just generate the file path and *not* require the file to exist.
# Environment: BUILD_DOCUMENTATION_PATH
# Requires: __documentationFile
__functionSettings() {
  local home="$1" && shift
  local functionName="$1" && shift
  local generatePath=false && if [ $# -gt 0 ]; then generatePath="$1" && shift; fi
  __documentationFile "$home" "$functionName" "$generatePath" "sh"
}
