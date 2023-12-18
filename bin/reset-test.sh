#!/usr/bin/env bash
#
# Reset test from scratch and run again
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
set -eou pipefail

envFile=${1:-.env.PRODUCTION}
shift || :

cd "$(dirname "${BASH_SOURCE[0]}")/.."

# shellcheck source=/dev/null
. ./bin/build/tools.sh

if [ ! -f "$envFile" ]; then
    consoleError "No $envFile found"
    exit 1
fi
set -a
# shellcheck source=/dev/null
source "$envFile"

bin/test.sh --clean "$@"
