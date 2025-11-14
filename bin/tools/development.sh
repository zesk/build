#!/usr/bin/env bash
#
# pre-release.sh
#
# Copyright &copy; 2025 Market Acumen, Inc.

# Open a URL with a new PR
buildPRNew() {
  local handler="_${FUNCNAME[0]}"

  open "$(catchEnvironment "$handler" bitbucketPRNewURL "marketacumen" "build")" || return $?
}
_buildPRNew() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Argument: name - String. Optional. Name of tool to add.
buildAddTool() {
  local handler="returnMessage" home file

  home=$(catchReturn "$handler" buildHome) || return $?

  while [ $# -gt 0 ]; do
    case "$1" in
    *[^-[:alnum:]]*)
      throwArgument "$handler" "Invalid name: $1" || return $?
      ;;
    esac
    for file in "bin/build/tools/$1.sh" "test/tools/$1-tests.sh"; do
      if [ ! -f "$home/$file" ]; then
        touch "$home/$file"
        chmod +x "$home/$file"
      fi
      git add "$home/$file"
    done
    file="documentation/source/tools/$1.md"
    if [ ! -f "$home/$file" ]; then
      touch "$home/$file"
    fi
    git add "$home/$file"
    shift
  done
}

# Argument: image - String. Optional. Image to load
# Load Zesk Build in a preconfigured container
# Starts in `/root/build`
# Loads .STAGING.env first
buildContainer() {
  local image="${1-ubuntu:latest}"
  local name="${image%:latest}"
  local ee=(
    "bashPrompt --label \"$name\" bashPromptModule_binBuild bashPromptModule_ApplicationPath bashPromptModule_dotFilesWatcher --order 80 bashPromptModule_TermColors"
    "approved=\$(dotFilesApprovedFile)"
    "[ -f \"\$approved\" ] || dotFilesApproved bash mysql >>\$approved"
    "packageWhich --verbose sha1sum apt-rdepends"
    "cd ~/build"
  )
  dockerLocalContainer --image "$image" --path /root/build --env-file .STAGING.env /root/build/bin/build/bash-build.sh --rc-extras "${ee[@]}" -- "$@"
}

# Run tests (and continue from last failure point) but skip slow and package installation tests.
buildQuickTest() {
  local handler="_${FUNCNAME[0]}"
  local home

  __help "$handler" "$@" || return 0

  home=$(catchReturn "$handler" buildHome) || return $?
  BUILD_TEST_FLAGS='Housekeeper:false;Plumber:false' "$home/bin/test.sh" -c --skip-tag slow --skip-tag package-install "$@"
}
_buildQuickTest() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Run tests (and continue from last failure point)
# Do not do housekeeper or plumber by default. (faster)
buildStagingTest() {
  local handler="_${FUNCNAME[0]}"
  local home

  __help "$handler" "$@" || return 0

  home=$(catchReturn "$handler" buildHome) || return $?
  BUILD_TEST_FLAGS='Housekeeper:false;Plumber:false' "$home/bin/test.sh" -c "$@"
}
_buildStagingTest() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Run production tests
# Argument: ... - Arguments. Optional. Passed to `testSuite`.
buildProductionTest() {
  local handler="_${FUNCNAME[0]}"
  local home

  __help "$handler" "$@" || return 0

  home=$(catchReturn "$handler" buildHome) || return $?
  BUILD_TEST_FLAGS='Housekeeper:true;Plumber:true' "$home/bin/test.sh" --skip-tag slow-non-critical "$@"
}
_buildProductionTest() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Playing with the concept if we remove the type checking that Bash will perform faster
# Initial tests show that increase in speeds is minor at best which is likely as IO or some other issue is at hand.
buildFastFiles() {
  local handler="_${FUNCNAME[0]}"
  local home

  __help "$handler" "$@" || return 0

  home=$(catchReturn "$handler" buildHome) || return $?

  local pattern patterns=("__check") aa=() && for pattern in "${patterns[@]}"; do aa+=(-e "/# __IDENTICAL__ $(quoteSedPattern "$pattern")/{N;d;}"); done

  local ff=("$home/bin/build/tools/sugar.sh")

  for f in "${ff[@]}"; do
    local target="${f%.sh}-fast.sh"
    local tempTarget="$target.temp"
    catchReturn "$handler" sed "${aa[@]}" "$f" | grep -v '# \(IDENTICAL\|_IDENTICAL_\|__IDENTICAL__\)' >"$tempTarget" || return $?
    if [ -f "$target" ]; then
      if ! diff -q "$tempTarget" "$target"; then
        diff "$target" "$tempTarget" | dumpPipe "Updated $(decorate file "$target"): < old, > new"
        catchReturn "$handler" mv "$tempTarget" "$target" || returnClean $? "$tempTarget" || return $?
      else
        catchEnvironment "$handler" rm -f "$tempTarget" || return $?
        decorate info "No changes required for $(decorate file "$target")"
      fi
    else
      catchReturn "$handler" mv "$tempTarget" "$target" || returnClean $? "$tempTarget" || return $?
      decorate info "Created $(decorate file "$target")"
    fi
  done
}
_buildFastFiles() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Test build timings with different settings
# See if buildFastFiles makes a difference
buildBuildTiming() {
  local handler="_${FUNCNAME[0]}"
  local index=1
  for production in false true; do
    for colors in false true; do
      bigText "Test #$index"
      decorate pair "PRODUCTION" "$production"
      decorate pair "BUILD_COLORS" "$colors"
      catchReturn "$handler" env -i BUILD_DEBUG=handler HOME="$HOME" PATH="$PATH" PRODUCTION=$production BUILD_COLORS=$colors time "$home/bin/build.sh" || return $?
      index=$((index + 1))
    done
  done
}
_buildBuildTiming() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Force the fingerprints in the APPLICATION_JSON to be up to date
#
__buildFingerUpdate() {
  local handler="_${FUNCNAME[0]}"

  local f jf

  catchReturn "$handler" buildFastFiles || return $?
  f=$(catchReturn "$handler" hookRun application-fingerprint) || return $?
  jf=$(catchReturn "$handler" buildEnvironmentGet APPLICATION_JSON) || return $?
  local path u=()
  for path in .fingerprint .deprecated '.identical."--internal"' '.identical.default'; do
    local value
    value=$(catchReturn "$handler" jsonFileGet "$jf" "$path") || return $?
    if [ "$value" != "$f" ]; then
      statusMessage decorate info "Updating $(decorate code "$path")"
      catchReturn "$handler" jsonFileSet "$jf" "$path" "$f" || return $?
      u+=("$path")
    fi
  done
  [ "${#u[@]}" -eq 0 ] || statusMessage --last decorate success "Updated $(decorate each bold-red "${u[@]}") [$(pluralWord "${#u[@]}" field)] in $(decorate file "$jf")"
}
___buildFingerUpdate() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
