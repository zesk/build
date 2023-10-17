#!/usr/bin/env bash
#
# python.sh
#
# Depends: apt
#
# python3 install if needed
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
set -eo pipefail
errorEnvironment=1
export DEBIAN_FRONTEND=noninteractive

me=$(basename "$0")
relTop=../../..
if ! cd "$(dirname "${BASH_SOURCE[0]}")/$relTop"; then
  echo "$me: Can not cd to $relTop" 1>&2
  exit $errorEnvironment
fi

# shellcheck source=/dev/null
. "./bin/build/tools.sh"

if which python >/dev/null; then
  exit 0
fi

./bin/build/install/apt.sh python-is-python3 python3 python3-pip
