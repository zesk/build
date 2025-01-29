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

buildPreRelease() {
  local home

  home=$(__environment buildHome) || return $?

  __execute "$home/bin/build/deprecated.sh" --internal || exitCode=$?
  __execute "$home/bin/build/identical-check.sh" --internal || exitCode=$?
  __execute "$home/bin/documentation.sh" || exitCode=$?
  find "$home" -name '*.sh' ! -path '*/.*/*' | bashLintFiles || exitCode=$?
  return "$exitCode"
}

__buildAliases
