#!/usr/bin/env bash
# IDENTICAL zeskBuildTestHeader 5
#
# yum-tests.sh
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
# Yum tests (Fedora?)

testIsYum() {
  yumIsInstalled --help >/dev/null || return $?

  mockEnvironmentStart BUILD_DEBUG

  assertExitCode --stdout-match "Is yum installed" 0 yumIsInstalled --help || return $?

  mockEnvironmentStop BUILD_DEBUG
}
