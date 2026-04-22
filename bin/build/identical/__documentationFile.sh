#!/bin/bash
#
# Identical template
#
# Original of __documentationFile
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# IDENTICAL __documentationFile EOF

# Summary: Load cached documentation files
# Argument: home - Directory. BUILD_HOME
# Argument: functionName - String. Function to fetch documentation file
# Argument: generatePath - Boolean. Optional. Pass in `true` to just generate the file path and *not* require the file to exist.
# Argument: extension - String. File extension. Optional. Default to `md`.
# Environment: BUILD_DOCUMENTATION_PATH
# Requires:
__documentationFile() {
  local home="$1" && shift
  local functionName="$1" && shift
  local generatePath=false && if [ $# -gt 0 ]; then generatePath="$1" && shift; fi
  local extension="md" && if [ $# -gt 0 ]; then extension="$1" && shift; fi

  export BUILD_DOCUMENTATION_PATH
  local paths && IFS=":" read -r -d $'\n' -a paths <<<"${BUILD_DOCUMENTATION_PATH-"bin/build/documentation"}"
  local docFile="" path && for path in "${paths[@]+"${paths[@]}"}"; do
    docFile="$home/${path%/}/$functionName.$extension"
    $generatePath || [ -f "$docFile" ] || continue
    printf "%s\n" "$docFile"
    return 0
  done
  return 1
}
