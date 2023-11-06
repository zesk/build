#!/usr/bin/env bash
#
# mariadb-client.sh
#
# Depends: apt
#
# mariadb-client install if needed
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
set -eo pipefail
export DEBIAN_FRONTEND=noninteractive

cd "$(dirname "${BASH_SOURCE[0]}")/../../.."

# shellcheck source=/dev/null
. "./bin/build/tools.sh"

if which mariadb >/dev/null; then
  exit 0
fi

./bin/build/install/apt.sh mariadb-client
