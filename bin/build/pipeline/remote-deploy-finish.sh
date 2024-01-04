#!/usr/bin/env bash
#
# Run on remote systems right after code is updated to continue deployment.
#
# Note environment here is NOT THE BUILD ENVIRONMENT - it is the remote host itself
#
# The directory is currently run inside:
#
# - deployHome/applicationChecksum/app/
# - applicationHome/
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
set -eou pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/../../.."

# shellcheck source=/dev/null
. ./bin/build/tools.sh

remoteDeployFinish "$@"
