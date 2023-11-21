#!/usr/bin/env bash
#
# version-last.sh
#
# Depends: git
#
# Copyright &copy; 2023 Market Acumen, Inc.
#

# Get the last reported version.
# Usage: versionLast [ ignorePattern ]
# Argument: ignorePattern - Optional. Specify a grep pattern to ignore; allows you to ignore current version
versionLast() {
  local listBin

  listBin="$(dirname "${BASH_SOURCE[0]}")/version-list.sh"
  if [ -n "$1" ]; then
    $listBin | grep -v "$1" | tail -1
  else
    $listBin | tail -1
  fi

}

versionLast "$@"
