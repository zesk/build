#!/usr/bin/env bash
#
# yum-tests.sh
#
# Yum tests (Fedora?)
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

testIsYum() {
  yumIsInstalled --help >/dev/null || return $?

  mockEnvironmentStart BUILD_DEBUG

  assertExitCode --stdout-match "Is yum installed" 0 yumIsInstalled --help || return $?

  mockEnvironmentStop BUILD_DEBUG
}
