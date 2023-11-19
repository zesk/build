#!/usr/bin/env bash
#
# Deploy a PHP Application
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
set -eo pipefail
# set -x # Debugging

cd "$(dirname "${BASH_SOURCE[0]}")/.."

./bin/install-bin-build.sh
./bin/build/pipeline/php-undeploy.sh
