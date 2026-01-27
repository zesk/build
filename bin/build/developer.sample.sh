#!/usr/bin/env bash
#
# developer.sh
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
# Developer scripts

# shellcheck source=/dev/null
if source "${BASH_SOURCE[0]%/*}/tools.sh"; then
  # {APPLICATION_NAME}
  # - Add developer notes here
  __developerHelp() {
    local handler="_${FUNCNAME[0]}"

    if [ "${1-}" = "--cache" ]; then
      if ! interactiveOccasionally "${FUNCNAME[0]}"; then
        printf "%s %s\n" "$(decorate code ' ? ')" "$(decorate info 'to show help')"
        return 0
      fi
    fi

    local home

    home=$(catchReturn "$handler" buildHome) || return $?

    # Title
    local name
    name=$(catchReturn "$handler" buildEnvironmentGet APPLICATION_NAME) || return $?
    [ -n "$name" ] || name=$(basename "$home")

    local title
    title="$name $(catchReturn "$handler" hookVersionCurrent)" || return $?
    bigText --bigger "$title"
    # Logo for iTerm2
    iTerm2Image -i "$home/etc/zesk-build-icon.png"

    markdownToConsole < <(bashFunctionComment "${BASH_SOURCE[0]}" "${FUNCNAME[0]}")

  }
  ___developerHelp() {
    # __IDENTICAL__ usageDocument 1
    usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
  }

  __developerConfigure() {
    local handler="_${FUNCNAME[0]}"
    local home

    home=$(catchReturn "$handler" buildHome) || return $?

    unset BUILD_ENVIRONMENT_DIRS BUILD_HOOK_EXTENSIONS BUILD_RELEASE_NOTES

    catchReturn "$handler" colorScheme <"$home/etc/term-colors.conf" || return $?

    alias '?'="__developerHelp"

    muzzle reloadChanges --stop 2>&1
    muzzle reloadChanges --name "$(buildEnvironmentGet APPLICATION_NAME)" "$home/bin/tools.sh" "$home/bin/tools/"
    muzzle buildCompletion

    bashPrompt --skip-prompt bashPromptModule_TermColors bashPromptModule_BuildProject

    pathConfigure --last "$home/bin" "$home/bin/build"

    __developerHelp --cache

    export BUILD_PROJECT_DEACTIVATE="${FUNCNAME[0]}Undo"

    unset "${FUNCNAME[0]}" "_${FUNCNAME[0]}"
  }
  ___developerConfigure() {
    # __IDENTICAL__ usageDocument 1
    usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
  }

  # Undo project configuration
  __developerConfigureUndo() {
    local handler="_${FUNCNAME[0]}"

    local home && home=$(catchReturn "$handler" buildHome) || return $?
    local name && name=$(catchReturn "$handler" buildEnvironmentContext "$home" buildEnvironmentGet APPLICATION_NAME) || return $?
    [ -n "$name" ] || name=$(basename "$home")

    statusMessage decorate info "Deactivating $(decorate value "$name") @ $(decorate file --no-app "$home")..."

    muzzle reloadChanges --stop 2>&1
    pathRemove "$home/bin" "$home/bin/build"

    unset "${FUNCNAME[0]}" "_${FUNCNAME[0]}" 2>/dev/null
    statusMessage decorate notice "Deactivated $(decorate value "$name") @ $(decorate file --no-app "$home")."
  }
  ___developerConfigureUndo() {
    # __IDENTICAL__ usageDocument 1
    usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
  }

  __developerConfigure
else
  printf "%s\n" "Loading ${BASH_SOURCE[0]%/*}/tools.sh failed" 1>&2
  false
fi
