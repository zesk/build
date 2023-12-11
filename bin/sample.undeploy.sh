#!/usr/bin/env bash
#
# Deploy a PHP Application
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
set -eo pipefail
# set -x # Debugging

cd "$(dirname "${BASH_SOURCE[0]}")/.."

# Copy of bin/build/install-bin-build.sh in your project
# This is copied into local project after first install
./bin/install-bin-build.sh
./bin/build/pipeline/php-undeploy.sh
