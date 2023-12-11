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
# Deprecated use function
# Generate an environment file for this project.
#
# See: makeEnvironment
echo "# make-env.sh is deprecated"
makeEnvironment "$@"
