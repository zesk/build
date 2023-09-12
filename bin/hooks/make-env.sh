#!/usr/bin/env bash
#
# Run during bin/pipeline/php-build.sh
#
# Generate the .env file
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
set -eo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/../.."

# shellcheck source=/dev/null
. ./bin/build/tools.sh

consoleSuccess "$(basename "${BASH_SOURCE[0]}") is the default script, please customize for your application."
./bin/build/pipeline/make-env.sh "$@"
