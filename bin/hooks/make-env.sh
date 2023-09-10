#!/usr/bin/env bash
#
# Run during bin/pipeline/php-build.sh
#
# Generate the .env file
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
set -eo pipefail

errEnv=1
me=$(basename "${BASH_SOURCE[0]}")
if ! cd "$(dirname "${BASH_SOURCE[0]}")/../.."; then
    echo "$me: Can not cd" && exit $errEnv
fi

# shellcheck source=/dev/null
. ./bin/build/tools.sh

consoleSuccess "$me is the default script, please customize for your application."
./bin/build/pipeline/make-env.sh "$@"
