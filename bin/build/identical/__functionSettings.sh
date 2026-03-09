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
# Environment: BUILD_DOCUMENTATION_PATH
# Requires:
__functionSettings() {
  local home="$1" && shift
  local functionName="$1" && shift
  export BUILD_DOCUMENTATION_PATH
  local paths && IFS=":" read -r -d $'\n' -a paths <<<"${BUILD_DOCUMENTATION_PATH-"bin/build/documentation"}"
  local settingsFile="" path && for path in "${paths[@]+"${paths[@]}"}"; do
    settingsFile="$home/${path%/}/$functionName.sh"
    [ -f "$settingsFile" ] || continue
    printf "%s\n" "$settingsFile"
    return 0
  done
  return 1
}
