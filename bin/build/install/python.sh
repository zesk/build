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
export DEBIAN_FRONTEND=noninteractive

cd "$(dirname "${BASH_SOURCE[0]}")/../../.."

# shellcheck source=/dev/null
. "./bin/build/tools.sh"

if which python >/dev/null; then
  exit 0
fi

./bin/build/install/apt.sh python-is-python3 python3 python3-pip
