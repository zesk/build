#!/usr/bin/env bash
#
# terraform.sh
#
# Depends: apt
#
# terraform install if needed
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL bashHeader 5
set -eou pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/../../.."

# shellcheck source=/dev/null
. ./bin/build/tools.sh

terraformInstall "$@"
