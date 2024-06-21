#!/usr/bin/env bash
#
# php-tests.sh
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
set -eou pipefail

declare -a tests

tests+=(testPHPSomething)
testPHPSomething() {
  return 0
}
