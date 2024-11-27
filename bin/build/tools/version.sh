#!/usr/bin/env bash
#
# version.sh
#
# Tools to help with code version management
#
# Copyright: Copyright &copy; 2024 Market Acumen, Inc.
#
# Docs: o ./docs/_templates/tools/version.md
# Test: o ./test/tools/version-tests.sh

# Check if something matches a version
isVersion() {
  local part parts
  [ $# -gt 0 ] || return 1
  while [ $# -gt 0 ]; do
    IFS=. read -r -a parts < <(printf "%s\n" "$1") || :
    for part in "${parts[@]}"; do
      isUnsignedInteger "$part" || return 1
    done
    shift
  done
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
# Usage: {fn} [ version ]
# Argument: version - Optional. String. Version for the release notes path. If not specified uses the current version.
# Output: docs/release/version.md
# Hook: version-current
# Example:     open $(bin/build/release-notes.sh)
# Example:     vim $(releaseNotes)
# shellcheck disable=SC2120
releaseNotes() {
  local usage="_${FUNCNAME[0]}"
  local argument nArguments argumentIndex
  local version home releasePath

  version=
  nArguments=$#
  while [ $# -gt 0 ]; do
    argumentIndex=$((nArguments - $# + 1))
    argument="$(usageArgumentString "$usage" "argument #$argumentIndex" "$1")" || return $?
    case "$argument" in
      *)
        if [ -n "$version" ]; then
          decorate error "Version $version already specified: $argument"
        else
          version="$argument"
        fi
        ;;
    esac
    shift || __failArgument "$usage" "missing argument #$argumentIndex: $argument" || return $?
  done
  buildEnvironmentContext __releaseNotes "$usage" "$version"
}
__releaseNotes() {
  local usage="$1" version="${2-}"

  if [ -z "$version" ]; then
    version=$(__usageEnvironment "$usage" runHook version-current) || return $?
    [ -n "$version" ] || __failEnvironment "$usage" "version-current hook returned blank" || return $?
  fi
  export BUILD_RELEASE_NOTES
  __usageEnvironment "$usage" buildEnvironmentLoad BUILD_RELEASE_NOTES || return $?
  home=$(__usageEnvironment "$usage" buildHome) || return $?
  [ -n "${BUILD_RELEASE_NOTES}" ] || __failEnvironment "$usage" "BUILD_RELEASE_NOTES is blank" || return $?
  releasePath="${BUILD_RELEASE_NOTES%/}"
  isAbsolutePath "$releasePath" || releasePath=$(simplifyPath "$home/$releasePath")
  printf "%s/%s.md\n" "${releasePath%/}" "$version"
}
_releaseNotes() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Usage: {fn} lastVersion
# Converts vX.Y.N to vX.Y.(N+1) so v1.0.0 to v1.0.1
# Argument: lastVersion - Required. String. Version to calculate the next minor version.
nextMinorVersion() {
  local usage="_${FUNCNAME[0]}"
  local last prefix

  last="${1##*.}"
  __usageArgument "$usage" isInteger "$last" || return $?
  prefix="${1%.*}"
  prefix="${prefix#v*}"
  if [ "$prefix" != "${1-}" ]; then
    prefix="$prefix."
  else
    prefix=
  fi
  last=$((last + 1))
  printf "%s%s" "$prefix" "$last"
}
_nextMinorVersion() {
  # IDENTICAL usageDocument 1
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
# Exit Code: 0 - Release generated or has already been generated
# Exit Code: 1 - If new version needs to be created and `--non-interactive`
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
newRelease() {
  local usage="_${FUNCNAME[0]}"
  local argument nArguments argumentIndex

  local isInteractive=true newVersion=""

  local saved=("$@") nArguments=$#
  while [ $# -gt 0 ]; do
    local argument argumentIndex=$((nArguments - $# + 1))
    argument="$(usageArgumentString "$usage" "argument #$argumentIndex (Arguments: $(_command "${usage#_}" "${saved[@]}"))" "$1")" || return $?
    case "$argument" in
      # IDENTICAL --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --non-interactive)
        isInteractive=false
        decorate warning "Non-interactive mode set"
        ;;
      *)
        [ -z "$newVersion" ] || __failArgument "$usage" "unknown argument #$argumentIndex: $argument" || return $?
        newVersion="${argument#v}"
        isVersion "$newVersion" || __failArgument "$usage" "$argument is not a version" || return $?
        newVersion="v$newVersion"
        ;;
    esac
    shift || __failArgument "$usage" "missing argument #$argumentIndex: $argument" || return $?
  done

  buildEnvironmentContext __newRelease "$usage" "$isInteractive" "$newVersion"
}
__newRelease() {
  local usage="$1" isInteractive="$2" newVersion="$3"
  local newVersion readLoop=false currentVersion liveVersion nextVersion notes isInteractive
  local versionOrdering
  local width=40

  # No version on command-line *potentially* ask (interactive only)
  if [ -z "$newVersion" ]; then
    readLoop=true
  fi
  hasHook version-current || __failEnvironment "$usage" "Requires hook version-current" || return $?
  currentVersion=$(__usageEnvironment "$usage" runHook version-current) || return $?
  [ -n "$currentVersion" ] || __failEnvironment "$usage" "version-current hook returned empty string" || return $?
  if hasHook version-live; then
    liveVersion=$(__usageEnvironment "$usage" runHook version-live) || return $?
    [ -n "$currentVersion" ] || __failEnvironment "$usage" "version-live hook returned empty string" || return $?
    consoleNameValue $width "Live:" "$liveVersion"
  else
    liveVersion=$currentVersion
  fi
  notes="$(__usageEnvironment "$usage" releaseNotes "$currentVersion")" || return $?
  nextVersion=$(nextMinorVersion "$liveVersion")
  consoleNameValue $width "Current:" "$currentVersion"

  if [ -n "$newVersion" ] && [ "$currentVersion" != "$newVersion" ]; then
    consoleNameValue "$width" "New:" "$(decorate bold-green "$newVersion")"
    local checkVersion="$liveVersion"
    [ -n "$checkVersion" ] || checkVersion="$lastVersion"
    lastVersion="$(printf "%s\n" "$liveVersion" "$newVersion" | versionSort | tail -n 1)" || return $?
    if [ "$newVersion" != "$lastVersion" ]; then
      __failArgument "$usage" "$(decorate error "$newVersion") is before live $(decorate code "$liveVersion")" || return $?
    fi
    ! $isInteractive || confirmYesNo --yes "Change version to $(decorate code "$newVersion")? " || return $?
    if [ -f "$notes" ]; then
      local newNotes
      newNotes=$(__usageEnvironment "$usage" releaseNotes "$newVersion") || return $?
      if [ -f "$newNotes" ]; then
        __failEnvironment "$usage" "$(decorate file "$notes") and $(decorate file "$newNotes") both exist - can not re-version" || return $?
      fi
      __usageEnvironment "$usage" sed "s/$(quoteSedPattern "$currentVersion")/$(quoteSedReplacement "$newVersion")/g" <"$notes" >"$notes.fixed" || _clean $? "$notes.fixed" || return $?
      __usageEnvironment "$usage" git mv "$notes" "$newNotes" || _clean $? "$notes.fixed" || return $?
      __usageEnvironment "$usage" mv -f "$notes.fixed" "$newNotes" || _clean $? "$notes.fixed" || return $?
    fi
    currentVersion="$newVersion"
    notes="$(__usageEnvironment "$usage" releaseNotes "$currentVersion")" || return $?
    nextVersion=$(nextMinorVersion "$liveVersion")
    if $isInteractive; then
      __usageEnvironment "$usage" runHook version-created "$currentVersion" "$notes" || return $?
    fi
  fi
  versionOrdering="$(printf "%s\n%s" "$liveVersion" "$currentVersion")"
  if [ "$currentVersion" != "$liveVersion" ] && [ "$(printf %s "$versionOrdering" | versionSort)" = "$versionOrdering" ] || [ "$currentVersion" == "v$nextVersion" ]; then
    consoleNameValue $width "Ready to deploy:" "$currentVersion"
    consoleNameValue $width "Release notes:" "$notes"
    if $isInteractive; then
      __usageEnvironment "$usage" runHook version-already "$currentVersion" "$notes" || return $?
    fi
    return 0
  fi
  if ! $isInteractive; then
    if [ -z "$newVersion" ]; then
      newVersion=$nextVersion
    elif ! isVersion "$newVersion"; then
      __failArgument "$usage" "New version $newVersion is not a valid version tag" || return $?
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
          __failArgument "$usage" "Invalid version $newVersion" || return $?
        fi
        decorate error "Invalid version $newVersion"
      fi
    done
  fi
  notes="$(__usageEnvironment "$usage" releaseNotes "$newVersion")" || return $?
  if [ ! -f "$notes" ]; then
    __newReleaseNotes "$newVersion" "$currentVersion" >"$notes"
    decorate success "Version $newVersion ready - release notes: $notes"
    if $isInteractive; then
      __usageEnvironment "$usage" runHook version-created "$newVersion" "$notes" || return $?
    fi
  else
    decorate warning "Version $newVersion already - release notes: $notes"
    if $isInteractive; then
      __usageEnvironment "$usage" runHook version-already "$newVersion" "$notes" || return $?
    fi
  fi
  git add "$notes"
}
_newRelease() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__newReleaseNotes() {
  local newVersion=$1 currentVersion=$2
  cat <<EOF
# Release $newVersion

- Upgrade from $currentVersion
- New snazzy features here
EOF
}
