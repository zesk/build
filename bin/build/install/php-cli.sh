#!/usr/bin/env bash
#
# php.sh
#
# Depends: apt
#
# php install if needed
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
# set -x
set -eo pipefail
errorEnvironment=1

me="$(basename "$0")"
relTop=../../..
if ! cd "$(dirname "${BASH_SOURCE[0]}")/$relTop"; then
  echo "$me: Can not cd to $relTop" 1>&2
  exit $errorEnvironment
fi

# shellcheck source=/dev/null
. ./bin/build/tools.sh

if which php >/dev/null; then
  exit 0
fi

./bin/build/install/apt.sh php-cli
