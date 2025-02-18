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

  local version=""
  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
      # _IDENTICAL_ --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      *)
        if [ -n "$version" ]; then
          decorate error "Version $version already specified: $argument"
        else
          version="$argument"
        fi
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done
  buildEnvironmentContext __releaseNotes "$usage" "$version"
}
__releaseNotes() {
  local usage="$1" version="${2-}" home releasePath

  if [ -z "$version" ]; then
    version=$(__catchEnvironment "$usage" hookRun version-current) || return $?
    [ -n "$version" ] || __throwEnvironment "$usage" "version-current hook returned blank" || return $?
  fi
  export BUILD_RELEASE_NOTES
  __catchEnvironment "$usage" buildEnvironmentLoad BUILD_RELEASE_NOTES || return $?
  home=$(__catchEnvironment "$usage" buildHome) || return $?
  [ -n "${BUILD_RELEASE_NOTES}" ] || __throwEnvironment "$usage" "BUILD_RELEASE_NOTES is blank" || return $?
  releasePath="${BUILD_RELEASE_NOTES%/}"
  isAbsolutePath "$releasePath" || releasePath=$(simplifyPath "$home/$releasePath")
  printf "%s/%s.md\n" "${releasePath%/}" "$version"
}
_releaseNotes() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Usage: {fn} lastVersion
# Converts vX.Y.N to vX.Y.(N+1) so v1.0.0 to v1.0.1
# Argument: lastVersion - Required. String. Version to calculate the next minor version.
nextMinorVersion() {
  local usage="_${FUNCNAME[0]}"

  [ $# -gt 0 ] || __throwArgument "$usage" "lastVersion required" || return $?
  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
      # _IDENTICAL_ --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      *)
        local last prefix

        last="${1##*.}"
        __catchArgument "$usage" isInteger "$last" || return $?
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
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done
}
_nextMinorVersion() {
  # _IDENTICAL_ usageDocument 1
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

  local isInteractive=true newVersion=""

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
      # _IDENTICAL_ --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --non-interactive)
        isInteractive=false
        decorate warning "Non-interactive mode set"
        ;;
      *)
        if [ -n "$newVersion" ]; then
        # _IDENTICAL_ argumentUnknown 1
        __throwArgument "$usage" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
        fi
        newVersion="${argument#v}"
        isVersion "$newVersion" || __throwArgument "$usage" "$argument is not a version" || return $?
        newVersion="v$newVersion"
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
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
  hasHook version-current || __throwEnvironment "$usage" "Requires hook version-current" || return $?
  currentVersion=$(__catchEnvironment "$usage" hookRun version-current) || return $?
  [ -n "$currentVersion" ] || __throwEnvironment "$usage" "version-current hook returned empty string" || return $?
  if hasHook version-live; then
    liveVersion=$(__catchEnvironment "$usage" hookRun version-live) || return $?
    [ -n "$currentVersion" ] || __throwEnvironment "$usage" "version-live hook returned empty string" || return $?
    decorate pair $width "Live:" "$liveVersion"
  else
    liveVersion=$currentVersion
  fi
  notes="$(__catchEnvironment "$usage" releaseNotes "$currentVersion")" || return $?
  nextVersion=$(nextMinorVersion "$liveVersion")
  decorate pair $width "Current:" "$currentVersion"

  if [ -n "$newVersion" ] && [ "$currentVersion" != "$newVersion" ]; then
    decorate pair "$width" "New:" "$(decorate bold-green "$newVersion")"
    local checkVersion="$liveVersion"
    [ -n "$checkVersion" ] || checkVersion="$lastVersion"
    lastVersion="$(printf "%s\n" "$liveVersion" "$newVersion" | versionSort | tail -n 1)" || return $?
    if [ "$newVersion" != "$lastVersion" ]; then
      __throwArgument "$usage" "$(decorate error "$newVersion") is before live $(decorate code "$liveVersion")" || return $?
    fi
    ! $isInteractive || confirmYesNo --yes "Change version to $(decorate code "$newVersion")? " || return $?
    if [ -f "$notes" ]; then
      local newNotes
      newNotes=$(__catchEnvironment "$usage" releaseNotes "$newVersion") || return $?
      if [ -f "$newNotes" ]; then
        __throwEnvironment "$usage" "$(decorate file "$notes") and $(decorate file "$newNotes") both exist - can not re-version" || return $?
      fi
      __catchEnvironment "$usage" sed "s/$(quoteSedPattern "$currentVersion")/$(quoteSedReplacement "$newVersion")/g" <"$notes" >"$notes.fixed" || _clean $? "$notes.fixed" || return $?
      __catchEnvironment "$usage" git mv "$notes" "$newNotes" || _clean $? "$notes.fixed" || return $?
      __catchEnvironment "$usage" mv -f "$notes.fixed" "$newNotes" || _clean $? "$notes.fixed" || return $?
    fi
    currentVersion="$newVersion"
    notes="$(__catchEnvironment "$usage" releaseNotes "$currentVersion")" || return $?
    nextVersion=$(nextMinorVersion "$liveVersion")
    if $isInteractive; then
      __catchEnvironment "$usage" hookRun version-created "$currentVersion" "$notes" || return $?
    fi
  fi
  versionOrdering="$(printf "%s\n%s" "$liveVersion" "$currentVersion")"
  if [ "$currentVersion" != "$liveVersion" ] && [ "$(printf %s "$versionOrdering" | versionSort)" = "$versionOrdering" ] || [ "$currentVersion" == "v$nextVersion" ]; then
    decorate pair $width "Ready to deploy:" "$currentVersion"
    decorate pair $width "Release notes:" "$notes"
    if $isInteractive; then
      __catchEnvironment "$usage" hookRun version-already "$currentVersion" "$notes" || return $?
    fi
    return 0
  fi
  if ! $isInteractive; then
    if [ -z "$newVersion" ]; then
      newVersion=$nextVersion
    elif ! isVersion "$newVersion"; then
      __throwArgument "$usage" "New version $newVersion is not a valid version tag" || return $?
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
          __throwArgument "$usage" "Invalid version $newVersion" || return $?
        fi
        decorate error "Invalid version $newVersion"
      fi
    done
  fi
  notes="$(__catchEnvironment "$usage" releaseNotes "$newVersion")" || return $?
  if [ ! -f "$notes" ]; then
    __newReleaseNotes "$newVersion" "$currentVersion" >"$notes"
    decorate success "Version $newVersion ready - release notes: $notes"
    if $isInteractive; then
      __catchEnvironment "$usage" hookRun version-created "$newVersion" "$notes" || return $?
    fi
  else
    decorate warning "Version $newVersion already - release notes: $notes"
    if $isInteractive; then
      __catchEnvironment "$usage" hookRun version-already "$newVersion" "$notes" || return $?
    fi
  fi
  git add "$notes"
}
_newRelease() {
  # _IDENTICAL_ usageDocument 1
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
