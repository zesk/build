#!/usr/bin/env bash
# IDENTICAL zeskBuildBashHeader 5
#
# initialize.sh
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

#
# Set up test-related environment variables and traps
__testSuiteInitialize() {
  local handler="$1" && shift

  # Add fast-usage to debugging TODO consider removing this now that usage is fast
  export BUILD_DEBUG
  BUILD_DEBUG="${BUILD_DEBUG-},fast-usage"
  BUILD_DEBUG="${BUILD_DEBUG#,}"

  # Stop at 200-depth stacks and fail
  export FUNCNEST=200

  # Test internal exports
  export __TEST_SUITE_CLEAN_EXIT=false
  export __TEST_SUITE_TRACE=initialization
  export __TEST_SUITE_CLEAN_DIRS=()

  # Add a trap
  trap '__testCleanupMess' EXIT QUIT TERM ERR
  set -E

  __assertTimingSetup "$handler" || return $?

  # If someone interrupts find out where it was running
  bashDebugInterruptFile --handler "$handler" || return $?
}

#
# Set up shell options
#
__testRunShellInitialize() {
  shopt -s shift_verbose failglob
}
