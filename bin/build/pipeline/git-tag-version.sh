#!/usr/bin/env bash
#
# git-tag-version.sh
#
# does `git pull --tags origin` and then tags build for development or release
# tags up to BUILD_MAXIMUM_TAGS_PER_VERSION as "{current}d{index}"
#
# Depends: apt git docker
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL bashHeader 5
set -eou pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/../../.."

# shellcheck source=/dev/null
. ./bin/build/tools.sh

if ! gitInstall; then
  consoleError "Unable to install git" 1>&2
  exit 1
fi
gitTagVersion "$@"
