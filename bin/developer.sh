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
  __buildConfigure() {
    local handler="_${FUNCNAME[0]}"
    local home

    [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0

    home=$(catchReturn "$handler" buildHome) || return $?

    unset BUILD_ENVIRONMENT_DIRS BUILD_HOOK_EXTENSIONS BUILD_RELEASE_NOTES

    catchReturn "$handler" colorScheme <"$home/etc/term-colors.conf" || return $?
    export BUILD_COLORS_MODE
    if [ -z "${BUILD_COLORS_MODE-}" ]; then
      BUILD_COLORS_MODE=$(consoleConfigureColorMode)
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
    alias IdenticalRepair="$home/bin/build/repair.sh"

    muzzle reloadChanges --stop 2>&1
    muzzle reloadChanges --name "$name" "$home/bin/tools.sh" "$home/bin/build/build.json"
    muzzle buildCompletion

    bashPrompt --skip-prompt bashPromptModule_TermColors

    pathConfigure --last "$home/bin" "$home/bin/build"

    backgroundProcess --verbose --stop 30 --wait 90 bin/build/tools.sh fingerprint --check -- bin/build/tools.sh fingerprint
    backgroundProcess --verbose --stop 30 --wait 90 bin/build/deprecated.sh --check -- bin/build/deprecated.sh
    # backgroundProcess --verbose --stop 30 --wait 90 bin/build/repair.sh --internal --check -- bin/build/repair.sh --internal

    export BUILD_PROJECT_DEACTIVATE="${FUNCNAME[0]}Undo"

    markdownToConsole < <(bashFunctionComment "${BASH_SOURCE[0]}" "${FUNCNAME[0]}")

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
