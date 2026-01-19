#!/usr/bin/env bash
#
# mdoc-tests.sh
#
# Copyright &copy; 2026 Market Acumen, Inc.

# Tag: slow-non-critical
testMdoc() {
  assertExitCode 0 printf -- "%s" "No mdoc code yet" || return $?
}
