#!/usr/bin/env bash
#
# developer.sh
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Zesk Developer scripts

# shellcheck source=/dev/null
if source "${BASH_SOURCE[0]%/*}/tools.sh"; then
  __buildConfigure() {
    local home

    home=$(__environment buildHome) || return $?

    # shellcheck disable=SC2139
    alias t="$home/bin/build/tools.sh"
    alias tools=t
    # shellcheck disable=SC2139
    alias IdenticalRepair="$home/bin/build/identical-repair.sh"

    reloadChanges --name "Zesk Build" bin/build/tools.sh bin/build/tools
    buildCompletion
    developerAnnounce < <(__applicationToolsList)
  }

  __buildConfigureUndo() {
    developerUndo < <(__applicationToolsList)
  }

  __buildConfigure

  unset __buildConfigure
fi
