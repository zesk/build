#!/usr/bin/env bash
#
# developer.sh
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Zesk Developer scripts

developerTrack "${BASH_SOURCE[0]}"

__buildFunctions() {
  developerTrack "${BASH_SOURCE[0]}" --list
}
__buildAnnounce() {
  developerAnnounce < <(__buildFunctions)
}

__buildConfigure() {
  local home

  home=$(__environment buildHome) || return $?

  # shellcheck disable=SC2139
  alias t="$home/bin/build/tools.sh"
  alias tools=t
  # shellcheck disable=SC2139
  alias IdenticalRepair="$home/bin/build/identical-repair.sh"

  reloadChanges --name "Zesk Build" bin/build/tools.sh bin/build/tools
}

__buildConfigureUndo() {
  developerUndo < <(__buildFunctions)
}

__buildConfigure
__buildAnnounce

unset __buildConfigure __buildAnnounce
