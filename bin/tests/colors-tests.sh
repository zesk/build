#!/usr/bin/env bash
#
# colors-tests.sh
#
# Colors tests
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
set -eou pipefail

declare -a tests

tests+=(allColorTest)

tests+=(colorTest)
