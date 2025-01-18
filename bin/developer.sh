#!/usr/bin/env bash
#
# developer.sh
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Zesk Developer scripts

__buildAliases() {
  local home

  home=$(__environment buildHome) || return $?

  # shellcheck disable=SC2139
  alias t="$home/bin/build/tools.sh"
  alias tools=t
}

__buildAliases
