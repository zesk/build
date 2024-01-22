#!/usr/bin/env bash
#
# Generate an environment file
#
# Pass in list of required environment values and export any additional values required
#
# Recommendation that environment generation should NOT include the entire environment and
# instead explicitly define all desired variables used as well as their coverage within
# the application.
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL bashHeader 5
set -eou pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/../../.."

# shellcheck source=/dev/null
. ./bin/build/tools.sh

makeEnvironment "$@"
