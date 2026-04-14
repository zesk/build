#!/usr/bin/env bash
#
# developer.sh
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
# Zesk Developer scripts

# shellcheck source=/dev/null
if source "${BASH_SOURCE[0]%/*}/tools.sh"; then
  # Zesk Build Development
  # - `buildPR` - Open URL to a new Pull Request
  # - `buildFunctionsDerivedCompile` - Compile the usage directory `./bin/build/documentation/` and derived files.
  # - `buildFunctionsCompile` - Compile the usage directory `./bin/build/documentation/` (just settings).
  # - `buildAddTool code` - Add a new tool to Zesk Build (just use the code name, like `tofu`)
  # - `buildContainer image` - Load Zesk Build in a container image
  # - `buildBuildTiming` - Run the build with different setups to see which one is fastest
  # - `__buildFingerUpdate` - Force update the deprecated and identical fingerprints
  # - `bpr` -> `buildPR` shortcut
  #
  # Zesk Build Testing
  # - `bin/test.sh` - Test Zesk Build
  # - `buildQuickTest` - No professionals testing (no plumber or housekeeper) and no slow or package tests
  # - `buildStagingTest` - No professionals testing (no plumber or housekeeper)
  # - `buildProductionTest` - All professionals testing (yes plumber, yes housekeeper) but skip `slow-non-critical` tests
  # - `buildTestPlatforms` - Test platforms
  #
  # Zesk Build Deployment
  # - `buildPreRelease` - Run pre-release steps on code (deprecated, identical)
  # - `bin/build.sh`, `bin/deploy.sh`, `bin/documentation.sh` - Build, Deploy, Build Documentation for Zesk Build
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
    decorate big --bigger "$title"
    # Logo for iTerm2
    iTerm2Image -i "$home/etc/zesk-build-icon.png"

    markdownToConsole < <(bashFunctionComment "${BASH_SOURCE[0]}" "${FUNCNAME[0]}")
  }
  ___buildHelp() {
    # __IDENTICAL__ bashDocumentation 1
    bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
  }

  __buildConfigure() {
    local handler="_${FUNCNAME[0]}"
    local home

    home=$(catchReturn "$handler" buildHome) || return $?

    unset BUILD_ENVIRONMENT_DIRS BUILD_HOOK_EXTENSIONS BUILD_RELEASE_NOTES

    catchReturn "$handler" colorScheme <"$home/etc/term-colors.conf" || return $?

    approveBashSource --check "${BASH_SOURCE[0]}" || decorate warning "$(decorate file "${BASH_SOURCE[0]}") is not approved"

    # shellcheck disable=SC2139
    alias t="tools"
    alias '?'="__buildHelp"
    alias bpr='__buildFingerUpdate && gitCommit && buildPR'

    muzzle reloadChanges --stop 2>&1
    muzzle reloadChanges --name "$(buildEnvironmentGet APPLICATION_NAME)" "$home/bin/tools.sh" "$home/bin/build/build.json"
    muzzle buildCompletion

    bashPrompt --skip-prompt bashPromptModule_TermColors bashPromptModule_BuildProject
    bashPrompt --skip-prompt --remove "bashPromptModule_""binBuild" 2>/dev/null || :

    pathConfigure --last "$home/bin" "$home/bin/build"
    pathCleanDuplicates

    __buildHelp --cache

    export BUILD_PROJECT_DEACTIVATE="${FUNCNAME[0]}Undo"

    export BUILD_DEBUG
    BUILD_DEBUG="$(listAppend "${BUILD_DEBUG-}" "," "handler")"

    unset "${FUNCNAME[0]}" "_${FUNCNAME[0]}"
  }
  ___buildConfigure() {
    # __IDENTICAL__ bashDocumentation 1
    bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
  }

  # Show dark and light mode
  darkLight() {
    local m
    bin/build/repair.sh decorate
    source bin/tools.sh
    for m in __decorateStylesDefaultLight __decorateStylesDefaultDark; do
      "$m"
      colorSampleSemanticStyles
    done
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
  __buildBackground() {
    decorate warning backgroundProcess is still experimental
    backgroundProcess --terminate 2>/dev/null || :
    backgroundProcess --new-only --stop 30 --wait 90 bin/build/tools.sh fingerprint --check -- bin/build/tools.sh fingerprint
    backgroundProcess --new-only --stop 30 --wait 90 bin/build/deprecated.sh --check -- bin/build/deprecated.sh
    # backgroundProcess --verbose --stop 30 --wait 90 bin/build/repair.sh --internal --check -- bin/build/repair.sh --internal
  }
  __buildConfigure
else
  printf "%s\n" "Loading ${BASH_SOURCE[0]%/*}/tools.sh failed" 1>&2
  false
fi
