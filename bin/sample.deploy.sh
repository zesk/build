#!/usr/bin/env bash
#
# Deploy a PHP Application
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
"$(dirname "${BASH_SOURCE[0]}")/build/tools.sh" deployApplication

# This is copied into local project after first install
./bin/install-bin-build.sh

./bin/build/pipeline/php-undeploy.sh
