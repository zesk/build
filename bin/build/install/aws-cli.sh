#!/usr/bin/env bash
#
# aws-cli.sh
#
# Depends: apt
#
# aws cli install
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL bashHeader 5
set -eou pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/../../.."

# shellcheck source=/dev/null
. ./bin/build/tools.sh

awsInstall "$@"
