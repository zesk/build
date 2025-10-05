#!/usr/bin/env bash
#
# version.sh
#
# Tools to help with code version management
#
# Copyright: Copyright &copy; 2025 Market Acumen, Inc.
#
# Docs: o ./documentation/source/tools/version.md
# Test: o ./test/tools/version-tests.sh

# Check if something matches a version
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: binary - Required. String. The binary to look for.
isVersion() {
  local part parts
  [ $# -gt 0 ] || return 1
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  while [ $# -gt 0 ]; do
    [ -n "$1" ] || return 1
    IFS=. read -r -a parts < <(printf "%s\n" "$1") || :
    for part in "${parts[@]}"; do
      isUnsignedInteger "$part" || return 1
    done
    shift
  done
}
_isVersion() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Take one or more versions and strip the leading `v`
# stdin: Versions containing a preceding `v` character (optionally)
# stdout: Versions with the initial `v` (if it exists) removed
versionNoVee() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  while [ $# -gt 0 ]; do
    printf "%s\n" "${1#v}"
    shift
  done
}
_versionNoVee() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Summary: Output path to current release notes
#
# Output path to current release notes
#
# If this fails it outputs an error to stderr
#
# When this tool succeeds it outputs the path to the current release notes file
#
# Environment: BUILD_RELEASE_NOTES
# Argument: --application application - Optional. Directory. Application home directory.
# Argument: version - Optional. String. Version for the release notes path. If not specified uses the current version.
# Output: docs/release/version.md
# Hook: version-current
# Example:     open $(bin/build/release-notes.sh)
# Example:     vim $(releaseNotes)
# shellcheck disable=SC2120
releaseNotes() {
  local handler="_${FUNCNAME[0]}"

  local version="" home=""
  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --application) shift && home="$(usageArgumentDirectory "$handler" "$argument" "${1-}")" || return $? ;;
    *)
      if [ -n "$version" ]; then
        decorate error "Version $version already specified: $argument"
      else
        version="$argument"
      fi
      ;;
    esac
    shift
  done
  [ -n "$home" ] || home="$(catchReturn "$handler" buildHome)" || return $?
  catchReturn "$handler" buildEnvironmentContext "$home" __releaseNotes "$handler" "$version" || return $?
}
_releaseNotes() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__releaseNotes() {
  local handler="$1" version="${2-}" home releasePath

  set -eou pipefail
  local home
  home=$(catchReturn "$handler" buildHome) || return $?
  if [ -z "$version" ]; then
    version=$(catchEnvironment "$handler" hookRun --application "$home" version-current) || return $?
    [ -n "$version" ] || throwEnvironment "$handler" "version-current hook returned blank" || return $?
  fi
  local notes
  notes=$(catchReturn "$handler" buildEnvironmentGet --application "$home" BUILD_RELEASE_NOTES) || return $?
  [ -n "$notes" ] || throwEnvironment "$handler" "BUILD_RELEASE_NOTES is blank" || return $?
  releasePath="${notes%/}"
  pathIsAbsolute "$releasePath" || releasePath=$(catchReturn "$handler" directoryPathSimplify "$home/$releasePath") || return $?
  printf "%s/%s.md\n" "${releasePath%/}" "$version"
}

#
# Converts vX.Y.N to vX.Y.(N+1) so v1.0.0 to v1.0.1
# Argument: lastVersion - Required. String. Version to calculate the next minor version.
versionNextMinor() {
  local handler="_${FUNCNAME[0]}"

  [ $# -gt 0 ] || throwArgument "$handler" "lastVersion required" || return $?
  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    *)
      local last prefix

      last="${1##*.}"
      catchArgument "$handler" isInteger "$last" || return $?
      prefix="${1%.*}"
      prefix="${prefix#v*}"
      if [ "$prefix" != "${1-}" ]; then
        prefix="$prefix."
      else
        prefix=
      fi
      last=$((last + 1))
      printf "%s%s" "$prefix" "$last"
      ;;
    esac
    shift
  done
}
_versionNextMinor() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Argument: --non-interactive - Optional. If new version is needed, use default version
# Argument: versionName - Optional. Set the new version name to this - must be after live version in version order
# Summary: Generate a new release notes and bump the version
# Hook: version-current
# Hook: version-live
# Hook: version-created
# Hook: version-already
# Return Code: 0 - Release generated or has already been generated
# Return Code: 1 - If new version needs to be created and `--non-interactive`
# **New release** - generates files in system for a new release.
#
# *Requires* hook `version-current`, optionally `version-live`
#
# Uses semantic versioning `MAJOR.MINOR.PATCH`
#
# Checks the live version versus the version in code and prompts to
# generate a new release file if needed.
#
# A release notes template file is added at `./docs/release/`. This file is
# also added to `git` the first time.
#
releaseNew() {
  local handler="_${FUNCNAME[0]}"

  local isInteractive=true newVersion="" application=""

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --non-interactive)
      isInteractive=false
      decorate warning "Non-interactive mode set"
      ;;
    --application) shift && application=$(usageArgumentDirectory "$handler" "$argument" "${1-}") || return $? ;;
    *)
      if [ -n "$newVersion" ]; then
      # _IDENTICAL_ argumentUnknownHandler 1
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      fi
      newVersion="${argument#v}"
      isVersion "$newVersion" || throwArgument "$handler" "$argument is not a version" || return $?
      newVersion="v$newVersion"
      ;;
    esac
    shift
  done
  [ -n "$application" ] || application=$(catchReturn "$handler" buildHome) || return $?

  buildEnvironmentContext "$application" __releaseNew "$handler" "$isInteractive" "$newVersion"
}

__releaseNew() {
  local handler="$1" isInteractive="$2" newVersion="$3"
  local newVersion readLoop=false currentVersion liveVersion nextVersion notes isInteractive
  local versionOrdering
  local width=40

  # No version on command-line *potentially* ask (interactive only)
  if [ -z "$newVersion" ]; then
    readLoop=true
  fi
  hasHook version-current || throwEnvironment "$handler" "Requires hook version-current" || return $?
  currentVersion=$(catchEnvironment "$handler" hookRun version-current) || return $?
  [ -n "$currentVersion" ] || throwEnvironment "$handler" "version-current hook returned empty string" || return $?
  if hasHook version-live; then
    liveVersion=$(catchEnvironment "$handler" hookRun version-live) || return $?
    [ -n "$currentVersion" ] || throwEnvironment "$handler" "version-live hook returned empty string" || return $?
    decorate pair $width "Live:" "$liveVersion"
  else
    liveVersion=$currentVersion
  fi
  notes="$(catchEnvironment "$handler" releaseNotes "$currentVersion")" || return $?
  nextVersion=$(versionNextMinor "$liveVersion")
  decorate pair $width "Current:" "$currentVersion"

  if [ -n "$newVersion" ] && [ "$currentVersion" != "$newVersion" ]; then
    decorate pair "$width" "New:" "$(decorate bold-green "$newVersion")"
    local checkVersion="$liveVersion"
    [ -n "$checkVersion" ] || checkVersion="$lastVersion"
    lastVersion="$(printf "%s\n" "$liveVersion" "$newVersion" | versionSort | tail -n 1)" || return $?
    if [ "$newVersion" != "$lastVersion" ]; then
      throwArgument "$handler" "$(decorate error "$newVersion") is before live $(decorate code "$liveVersion")" || return $?
    fi
    ! $isInteractive || confirmYesNo --yes "Change version to $(decorate code "$newVersion")? " || return $?
    if [ -f "$notes" ]; then
      local newNotes
      newNotes=$(catchEnvironment "$handler" releaseNotes "$newVersion") || return $?
      if [ -f "$newNotes" ]; then
        throwEnvironment "$handler" "$(decorate file "$notes") and $(decorate file "$newNotes") both exist - can not re-version" || return $?
      fi
      catchEnvironment "$handler" sed "s/$(quoteSedPattern "$currentVersion")/$(quoteSedReplacement "$newVersion")/g" <"$notes" >"$notes.fixed" || returnClean $? "$notes.fixed" || return $?
      catchEnvironment "$handler" git mv "$notes" "$newNotes" || returnClean $? "$notes.fixed" || return $?
      catchEnvironment "$handler" mv -f "$notes.fixed" "$newNotes" || returnClean $? "$notes.fixed" || return $?
    fi
    currentVersion="$newVersion"
    notes="$(catchEnvironment "$handler" releaseNotes "$currentVersion")" || return $?
    nextVersion=$(versionNextMinor "$liveVersion")
    if $isInteractive; then
      catchEnvironment "$handler" hookRun version-created "$currentVersion" "$notes" || return $?
    fi
  fi
  versionOrdering="$(printf "%s\n%s" "$liveVersion" "$currentVersion")"
  if [ "$currentVersion" != "$liveVersion" ] && [ "$(printf %s "$versionOrdering" | versionSort)" = "$versionOrdering" ] || [ "$currentVersion" == "v$nextVersion" ]; then
    decorate pair $width "Ready to deploy:" "$currentVersion"
    decorate pair $width "Release notes:" "$notes"
    if $isInteractive; then
      catchEnvironment "$handler" hookRun version-already "$currentVersion" "$notes" || return $?
    fi
    return 0
  fi
  if ! $isInteractive; then
    if [ -z "$newVersion" ]; then
      newVersion=$nextVersion
    elif ! isVersion "$newVersion"; then
      throwArgument "$handler" "New version $newVersion is not a valid version tag" || return $?
    fi
  else
    while true; do
      if $readLoop; then
        local message
        message="$(printf "%s? (%s %s) " "$(decorate info "New version")" "$(decorate bold-magenta "default")" "$(decorate code "$nextVersion")")"
        printf "%s" "$message"
        read -r newVersion || :
        if [ -z "$newVersion" ]; then
          newVersion=$nextVersion
        fi
      fi
      if isVersion "$newVersion"; then
        newVersion="v$newVersion"
        break
      else
        if ! $readLoop; then
          throwArgument "$handler" "Invalid version $newVersion" || return $?
        fi
        decorate error "Invalid version $newVersion"
      fi
    done
  fi
  notes="$(catchEnvironment "$handler" releaseNotes "$newVersion")" || return $?
  if [ ! -f "$notes" ]; then
    catchEnvironment "$handler" hookRunOptional version-notes "$newVersion" "$currentVersion" >"$notes" || returnClean $? "$notes" || return $?
    if fileIsEmpty "$notes"; then
      __releaseNewNotes "$newVersion" "$currentVersion" >"$notes"
    fi
    decorate success "Version $newVersion ready - release notes: $notes"
    if $isInteractive; then
      catchEnvironment "$handler" hookRun version-created "$newVersion" "$notes" || return $?
    fi
  else
    decorate warning "Version $newVersion already - release notes: $notes"
    if $isInteractive; then
      catchEnvironment "$handler" hookRun version-already "$newVersion" "$notes" || return $?
    fi
  fi
  git add "$notes"
}
_releaseNew() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__releaseNewNotes() {
  local newVersion=$1 currentVersion=$2
  cat <<EOF
# Release $newVersion

- Upgrade from $currentVersion
- New snazzy features here
EOF
}
