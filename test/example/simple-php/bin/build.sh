#!/bin/bash
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
set -eou pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

[ -d ./bin/build ] || ./bin/pipeline/install-bin-build.sh

export APP_THING=secret

if ! bin/build/pipeline/php-build.sh --deployment staging --skip-tag APP_THING -- simple.application.php public src docs; then
  consoleError "Build failed"
  return 1
fi
echo "PWD: $(pwd)"
echo "LS:"
ls -la
