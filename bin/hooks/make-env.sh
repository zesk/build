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
me=$(basename "${BASH_SOURCE[0]}")

# shellcheck source=/dev/null
. ./bin/build/tools.sh

# Generate the environment file for this project.
#
# Default hook runs `bin/build/pipeline/make-env.sh` directly. To customize this
# override this hook in your project, usually by specifying a list of
# required environment variables which are set in your build pipeline.
#
# See: make-env.sh
# fn: make-env
hookMakeEnvironment() {
    consoleSuccess "$me is the default script, please customize for your application."
    ./bin/build/pipeline/make-env.sh "$@"
}

hookMakeEnvironment "$@"
