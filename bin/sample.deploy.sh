#!/usr/bin/env bash
#
# Deploy a PHP Application
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
set -eou pipefail
# set -x # Debugging

cd "$(dirname "${BASH_SOURCE[0]}")/.."

# This is copied into local project after first install
./bin/install-bin-build.sh

./bin/build/pipeline/php-undeploy.sh
