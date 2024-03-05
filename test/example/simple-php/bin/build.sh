#!/bin/bash
#
# Dead simple PHP build
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# zesk-build-bin-header-install 10
_fail() {
  printf "%s\n" "$*" 1>&2
  exit 1
}

set -eou pipefail || _fail "set -eou pipefail fail?"
cd "$(dirname "${BASH_SOURCE[0]}")/.." || _fail "cd $(dirname "${BASH_SOURCE[0]}")/.. failed"

[ -d ./bin/build ] || ./bin/pipeline/install-bin-build.sh || _fail "install-bin-build.sh failed"

# shellcheck source=/dev/null
. ./bin/build/tools.sh || _fail "tools.sh failed"
# zesk-build-bin-header-install

if ! phpBuild --deployment staging --skip-tag "$@" -- simple.application.php public src docs; then
  _fail "Build failed"
fi
