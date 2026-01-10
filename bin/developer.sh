#!/usr/bin/env bash
#
# developer.sh
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
# Zesk Developer scripts

# shellcheck source=/dev/null
if source "${BASH_SOURCE[0]%/*}/tools.sh"; then
  # Zesk Build Development tools
  #
  # - `buildPR` - Open URL to a new Pull Request
  # - `buildAddTool code` - Add a new tool to Zesk Build (just use the code name, like `tofu`)
  # - `buildContainer image` - Load Zesk Build in a container image
  # - `buildFastFiles` - Build the fast files (do these work faster even?)
  # - `buildBuildTiming` - Run the build with different setups to see which one is fastest
  # - `__buildFingerUpdate` - Force update the deprecated and identical fingerprints
  #
  # Zesk Build Testing
  #
  # - `buildTestSuite` - Test Zesk Build (also `bin/test.sh`)
  # - `buildQuickTest` - No professionals testing (no plumber or housekeeper) and no slow or package tests
  # - `buildStagingTest` - No professionals testing (no plumber or housekeeper)
  # - `buildProductionTest` - All professionals testing (yes plumber, yes housekeeper) but skip `slow-non-critical` tests
  # - `buildTestPlatforms` - Test platforms
  #
  # Zesk Build Deployments
  #
  # - `buildPreRelease` - Run pre-release steps on code (deprecated, identical)
  # - `bin/build.sh` - Build Zesk Build
  # - `bin/deploy.sh` - Deploy built Zesk Build
  # - `bin/documentation.sh` - Build documentation
  #
  # As always, when editing code, be sure to test with a cleanly loaded version as
  #
  #     `bin/tools.sh myTest` vs. `myTest` - the former is correct and loads the code each run
  #
  __buildHelp() {
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
  ___buildHelp() {
    # __IDENTICAL__ usageDocument 1
    usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
  }

  __buildConfigure() {
    local handler="_${FUNCNAME[0]}"
    local home

    home=$(catchReturn "$handler" buildHome) || return $?

    unset BUILD_ENVIRONMENT_DIRS BUILD_HOOK_EXTENSIONS BUILD_RELEASE_NOTES

    catchReturn "$handler" colorScheme <"$home/etc/term-colors.conf" || return $?
    export BUILD_COLORS_MODE
    if [ -z "${BUILD_COLORS_MODE-}" ]; then
      BUILD_COLORS_MODE=$(consoleConfigureColorMode)
    fi

    # shellcheck disable=SC2139
    alias t="$home/bin/build/tools.sh"
    alias tools=t
    alias '?'="__buildHelp"

    muzzle reloadChanges --stop 2>&1
    muzzle reloadChanges --name "$(buildEnvironmentGet APPLICATION_NAME)" "$home/bin/tools.sh" "$home/bin/build/build.json"
    muzzle buildCompletion

    bashPrompt --skip-prompt bashPromptModule_TermColors bashPromptModule_BuildProject

    pathConfigure --last "$home/bin" "$home/bin/build"

    __buildHelp --cache

    backgroundProcess --new-only --stop 30 --wait 90 bin/build/tools.sh fingerprint --check -- bin/build/tools.sh fingerprint
    backgroundProcess --new-only --stop 30 --wait 90 bin/build/deprecated.sh --check -- bin/build/deprecated.sh
    # backgroundProcess --verbose --stop 30 --wait 90 bin/build/repair.sh --internal --check -- bin/build/repair.sh --internal

    export BUILD_PROJECT_DEACTIVATE="${FUNCNAME[0]}Undo"

    unset "${FUNCNAME[0]}" "_${FUNCNAME[0]}"
  }
  ___buildConfigure() {
    # __IDENTICAL__ usageDocument 1
    usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
  }

  # Undo Zesk Build project configuration
  __buildConfigureUndo() {
    local handler="returnMessage"
    local home

    muzzle reloadChanges --stop 2>&1

    home=$(catchReturn "$handler" buildHome) || return $?

    local name
    name=$(catchReturn "$handler" buildEnvironmentContext "$home" buildEnvironmentGet APPLICATION_NAME) || return $?
    [ -n "$name" ] || name=$(basename "$home")

    statusMessage decorate notice "Deactivating $(decorate value "$name") ..."

    muzzle reloadChanges --stop 2>&1

    pathRemove "$home/bin" "$home/bin/build"

    unset "${FUNCNAME[0]}" "_${FUNCNAME[0]}" 2>/dev/null
  }

  __buildConfigure
else
  printf "%s\n" "Loading ${BASH_SOURCE[0]%/*}/tools.sh failed" 1>&2
  false
fi
