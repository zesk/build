#!/usr/bin/env bash
#
# git.sh
#
# Depends: apt
#
# git install if needed
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
set -eo pipefail
errorEnvironment=1

me=$(basename "$0")
relTop=../../..
if ! cd "$(dirname "${BASH_SOURCE[0]}")/$relTop"; then
  echo "$me: Can not cd to $relTop" 1>&2
  exit $errorEnvironment
fi

# shellcheck source=/dev/null
. ./bin/build/tools.sh

if ! which git 2>/dev/null 1>&2; then
  ./bin/install/apt.sh git
fi
