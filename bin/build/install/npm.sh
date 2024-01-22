#!/usr/bin/env bash
#
# php.sh
#
# Depends: apt
#
# npm install if needed
#
# Copyright &copy; 2024 Market Acumen, Inc.

# IDENTICAL bashHeader 5
set -eou pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/../../.."

# shellcheck source=/dev/null
. ./bin/build/tools.sh

npmInstall "$@"
