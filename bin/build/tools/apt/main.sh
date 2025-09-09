#!/usr/bin/env bash
#
# apt functions
#
# Copyright &copy; 2025 Market Acumen, Inc.

__aptNonInteractive() {
  local handler="$1" && shift
  DEBIAN_FRONTEND=noninteractive NEEDRESTART_MODE=l __catchEnvironment "$handler" apt-get "$@" || return $?
}
