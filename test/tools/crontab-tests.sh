#!/usr/bin/env bash
#
# console-tests.sh
#
# Console tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
set -eou pipefail

declare -a tests
tests+=(crontabApplicationSyncTest)
crontabApplicationSyncTest() {
  return 0
}
