#!/usr/bin/env bash
#
# developer.sh
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Zesk Developer scripts

# shellcheck source=/dev/null
if source "${BASH_SOURCE[0]%/*}/tools.sh"; then
  # Zesk Build configured
  __buildConfigure() {
    local handler="_${FUNCNAME[0]}"
    local home

    [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0

    home=$(catchReturn "$handler" buildHome) || return $?

    export BUILD_COLORS_MODE
    if [ -z "${BUILD_COLORS_MODE-}" ]; then
      BUILD_COLORS_MODE=$(consoleConfigureConsoleMode)
    fi
    # Logo for iTerm2
    iTerm2Image -i "$home/etc/zesk-build-icon.png"

    # Title
    local name
    name=$(catchReturn "$handler" buildEnvironmentGet APPLICATION_NAME) || return $?
    [ -n "$name" ] || name=$(basename "$home")
    title="$name $(catchReturn "$handler" hookVersionCurrent)" || return $?
    bigText --bigger "$title"

    # shellcheck disable=SC2139
    alias t="$home/bin/build/tools.sh"
    alias tools=t
    # shellcheck disable=SC2139
    alias IdenticalRepair="$home/bin/build/identical-repair.sh"

    muzzle reloadChanges --stop 2>&1
    muzzle reloadChanges --name "$name" "$home/bin/tools.sh" "$home/bin/build/build.json"
    muzzle buildCompletion

    bashPrompt --skip-prompt bashPromptModule_TermColors

    pathConfigure --last "$home/bin" "$home/bin/build"

    # developerAnnounce < <(developerTrack)

    backgroundProcess --verbose --stop 30 --wait 90 bin/build/tools.sh fingerprint --check -- bin/build/tools.sh fingerprint
    backgroundProcess --verbose --stop 30 --wait 90 bin/build/deprecated.sh --check -- bin/build/deprecated.sh
    backgroundProcess --verbose --stop 30 --wait 90 bin/build/identical-repair.sh --internal --check -- bin/build/identical-repair.sh --internal

    export BUILD_PROJECT_DEACTIVATE="${FUNCNAME[0]}Undo"

    simpleMarkdownToConsole < <(bashFunctionComment "${BASH_SOURCE[0]}" "${FUNCNAME[0]}")

    unset "${FUNCNAME[0]}" "_${FUNCNAME[0]}"
  }
  ___buildConfigure() {
    true || __buildConfigure --help
    # __IDENTICAL__ usageDocument 1
    usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
  }

  __buildConfigureUndo() {
    local handler="returnMessage"
    local home

    muzzle reloadChanges --stop 2>&1

    home=$(catchReturn "$handler" buildHome) || return $?

    local name
    name=$(catchReturn "$handler" buildEnvironmentContext "$home" buildEnvironmentGet APPLICATION_NAME) || return $?
    [ -n "$name" ] || name=$(basename "$home")

    statusMessage decorate notice "Deactivating $name ..."

    pathRemove "$home/bin" "$home/bin/build"

    unset "${FUNCNAME[0]}" 2>/dev/null
  }

  __buildConfigure
else
  printf "%s\n" "Loading ${BASH_SOURCE[0]%/*}/tools.sh failed" 1>&2
  false
fi
