#!/usr/bin/env bash
# IDENTICAL zeskBuildTestHeader 5
#
# fingerprint-tests.sh
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

testFingerprint() {
  BUILD_DEBUG="" assertExitCode --stdout-match "with application fingerprint" 0 fingerprint --help || return $?
}
