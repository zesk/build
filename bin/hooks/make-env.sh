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

#
# Generate an environment file with environment variables (must be `export`ed)
#
# If your project has specific environment variables, you can add them in your `make-env` hook.
#
# Usage: runHook make-env [ requiredEnvironment0 ... ] [ -- optionalEnvironment0 ... ]
# See: makeEnvironment
#
# fn: runHook make-env
hookMakeEnvironment() {
  makeEnvironment "$@"
}
