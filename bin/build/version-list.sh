#!/usr/bin/env bash
#
# version-last.sh
#
# Depends: git
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
errorEnvironment=1
relTop="../.."
me=$(basename "${BASH_SOURCE[0]}")
if ! cd "$(dirname "${BASH_SOURCE[0]}")/$relTop"; then
  echo "$me: Can not cd to $relTop" 1>&2
  exit $errorEnvironment
fi

# shellcheck source=/dev/null
. "./bin/build/tools.sh"

#
# Fetches a list of tags from git and filters those which start with v and a digit and returns
# them sorted by version correctly.
#
# Usage: versionList
# Exit Code: 1 - If the `.git` directory does not exist
# Exit Code: 0 - Success
#
versionList() {
  if [ ! -d "./.git" ]; then
    echo "No .git directory at $(pwd), stopping" 1>&2
    return $errorEnvironment
  fi

  # versionSort works on vMMM.NNN.PPP
  # skip any versions with extensions like v1.0.1d2
  git tag | grep -e '^v[0-9.]*$' | versionSort
}
