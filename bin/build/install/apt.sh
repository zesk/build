#!/usr/bin/env bash
#
# apt.sh
#
# Depends: apt
#
# apt-utils base setup
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL bashHeader 5
set -eou pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/../../.."

# shellcheck source=/dev/null
. ./bin/build/tools.sh

aptInstall "$@"
