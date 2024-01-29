#!/bin/bash
#
# Dead simple PHP build
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
set -eou pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

[ -d ./bin/build ] || ./bin/pipeline/install-bin-build.sh

if ! bin/build/tools.sh phpBuild --deployment staging --skip-tag "$@" -- simple.application.php public src docs; then
  bin/build/tools.sh consoleError "Build failed" 1>&2
  return 1
fi
