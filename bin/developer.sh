#!/usr/bin/env bash
#
# developer.sh
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Zesk Developer scripts

# shellcheck source=/dev/null
if source "${BASH_SOURCE[0]%/*}/tools.sh"; then
  # Configure your shell for build developer
  # Adds some aliases (t, tools, IdenticalRepair), adds a bash prompt
  # and shell completions, terminal colors, and outputs banner and shows new functions
  __buildConfigure() {
    local handler="_${FUNCNAME[0]}"
    local home

    home=$(__catch "$handler" buildHome) || return $?

    # Logo for iTerm2
    if isiTerm2; then
      if iTerm2Image "$home/etc/zesk-build-icon.png"; then
        : "Icon output"
      fi
    fi
    # Title
    local name
    name=$(__catch "$handler" buildEnvironmentGet APPLICATION_NAME) || return $?
    [ -n "$name" ] || name=$(basename "$home")
    title="$name $(__catch "$handler" hookVersionCurrent)" || return $?
    bigText --bigger "$title"

    # shellcheck disable=SC2139
    alias t="$home/bin/build/tools.sh"
    alias tools=t
    # shellcheck disable=SC2139
    alias IdenticalRepair="$home/bin/build/identical-repair.sh"

    muzzle reloadChanges --stop 2>&1
    printf "%s" "$(decorate warning "Watching ")"
    reloadChanges --name "$name" "$home/bin/tools.sh" "$home/bin/"
    buildCompletion

    bashPrompt --skip-prompt bashPromptModule_TermColors

    pathConfigure --last "$home/bin" "$home/bin/build"

    developerAnnounce < <(developerTrack)

    export BUILD_PROJECT_DEACTIVATE=__buildConfigureUndo

    unset __buildConfigure
  }
  ___buildConfigure() {
    # __IDENTICAL__ usageDocument 1
    usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
  }

  __buildConfigureUndo() {
    local handler="_return"
    local home

    home=$(__catch "$handler" buildHome) || return $?

    local name
    name=$(__catch "$handler" directoryChange "$home" buildEnvironmentContext buildEnvironmentGet APPLICATION_NAME) || return $?
    [ -n "$name" ] || name=$(basename "$home")

    statusMessage decorate notice "Deactivating $name ..."

    pathRemove "$home/bin" "$home/bin/build"

    developerUndo < <(developerTrack)

    unset __buildConfigureUndo 2>/dev/null
  }

  __buildConfigure
else
  printf "%s\n" "Loading ${BASH_SOURCE[0]%/*}/tools.sh failed" 1>&2
  false
fi
