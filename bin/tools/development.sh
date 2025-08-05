#!/usr/bin/env bash
#
# pre-release.sh
#
# Copyright &copy; 2025 Market Acumen, Inc.

# Argument: name - String. Optional. Name of tool to add.
buildAddTool() {
  local usage="_return" home file

  home=$(__catch "$usage" buildHome) || return $?

  while [ $# -gt 0 ]; do
    case "$1" in
    *[^-[:alnum:]]*)
      __throwArgument "$usage" "Invalid name: $1" || return $?
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

  home=$(__catch "$handler" buildHome) || return $?
  "$home/bin/test.sh" -c --skip-tag slow --skip-tag package-install "$@"
}
_buildQuickTest() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

buildFastFiles() {
  local handler="_${FUNCNAME[0]}"
  local home

  __help "$handler" "$@" || return 0

  home=$(__catch "$handler" buildHome) || return $?

  local pattern patterns=("__check") aa=() && for pattern in "${patterns[@]}"; do aa+=(-e "/$(quoteSedPattern "# IDENTICAL $pattern")/{N;d;}"); done

  local ff=("$home/bin/build/tools/sugar.sh")

  for f in "${ff[@]}"; do
    local target="${f%.sh}-fast.sh"
    local tempTarget="$target.temp"
    __catchEnvironment "$handler" sed "${aa[@]}" "$f" | grep -v '# \(IDENTICAL\|_IDENTICAL_\|__IDENTICAL__\)' >"$tempTarget" || return $?
    if [ -f "$target" ]; then
      if ! diff -q "$tempTarget" "$target"; then
        diff "$target" "$tempTarget" | dumpPipe "Updated $(decorate file "$target"): < old, > new"
        __catch "$handler" mv "$tempTarget" "$target" || returnClean $? "$tempTarget" || return $?
      else
        __catchEnvironment "$handler" rm -f "$tempTarget" || return $?
        decorate info "No changes required for $(decorate file "$target")"
      fi
    else
      __catch "$handler" mv "$tempTarget" "$target" || returnClean $? "$tempTarget" || return $?
      decorate info "Created $(decorate file "$target")"
    fi
  done
}
_buildFastFiles() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Test build timings with different settings
buildBuildTiming() {
  local handler="_${FUNCNAME[0]}"
  local index=1
  for production in false true; do
    for colors in false true; do
      bigText "Test #$index"
      decorate pair "PRODUCTION" "$production"
      decorate pair "BUILD_COLORS" "$colors"
      __catch "$handler" env -i BUILD_DEBUG=usage HOME="$HOME" PATH="$PATH" PRODUCTION=$production BUILD_COLORS=$colors time "$home/bin/build.sh" || return $?
      index=$((index + 1))
    done
  done
}
_buildBuildTiming() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
