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
# Output: ${BUILD_RELEASE_NOTES%%/}/version.md
# Hook: version-current
# Exit code: 1 - if an error occurs
# Example:     open $(bin/build/release-notes.sh)
# Example:     vim $(releaseNotes)
# shellcheck disable=SC2120
releaseNotes() {
  local version home

  version=
  while [ $# -gt 0 ]; do
    case $1 in
      *)
        if [ -n "$version" ]; then
          consoleError "Version $version already specified: $1"
        else
          version="${1-}"
        fi
        ;;
    esac
    shift
  done
  if [ -z "$version" ]; then
    version=$(__usageEnvironment "$usage" runHook version-current) || return $?
    [ -n "$version" ] || __failEnvironment "$usage" "version-current hook returned blank" || return $?
  fi

  export BUILD_RELEASE_NOTES
  __usageEnvironment "$usage" buildEnvironmentLoad BUILD_RELEASE_NOTES || return $?
  home=$(__usageEnvironment "$usage" buildHome) || return $?
  [ -n "${BUILD_RELEASE_NOTES}" ] || __failEnvironment "$usage" "BUILD_RELEASE_NOTES is blank" || return $?
  releasePath="$BUILD_RELEASE_NOTES"
  isAbsolutePath "$releasePath}" || releasePath="$home/$releasePath"
  [ -d "$releasePath" ] || __failEnvironment "$usage" "Not a directory $releasePath" || return $?
  printf "%s/%s.md\n" "${releasePath%%/}" "$version"
}

#
# Usage: {fn} lastVersion
# Converts vX.Y.N to vX.Y.(N+1) so v1.0.0 to v1.0.1
#
nextMinorVersion() {
  local last prefix

  last="${1##*.}"
  __argument isInteger "$last" || return $?
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

#
# Argument: --non-interactive - Optional. If new version is needed, use default version
# Argument: versionName - Optional. Set the new version name to this.
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
  local newVersion readLoop currentVersion liveVersion nextVersion notes isInteractive
  local versionOrdering
  local width=40

  isInteractive=true
  readLoop=false
  newVersion=
  nArguments=$#
  while [ $# -gt 0 ]; do
    argumentIndex=$((nArguments - $# + 1))
    argument="$(usageArgumentString "$usage" "argument #$argumentIndex" "$1")" || return $?
    case "$argument" in
      --non-interactive)
        isInteractive=false
        consoleWarning "Non-interactive mode set"
        ;;
      # IDENTICAL --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      *)
        [ -z "$newVersion" ] || __failArgument "$usage" "unknown argument #$argumentIndex: $argument" || return $?
        newVersion="$argument"
        ;;
    esac
    shift || __failArgument "$usage" "missing argument #$argumentIndex: $argument" || return $?
  done

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
  nextVersion=$(nextMinorVersion "$liveVersion")
  consoleNameValue $width "Current:" "$currentVersion"
  versionOrdering="$(printf "%s\n%s" "$liveVersion" "$currentVersion")"
  if [ "$currentVersion" != "$liveVersion" ] && [ "$(printf %s "$versionOrdering" | versionSort)" = "$versionOrdering" ] || [ "$currentVersion" == "v$nextVersion" ]; then
    notes="$(releaseNotes)"
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
        printf "%s? (%s %s) " "$(consoleInfo "New version")" "$(consoleBoldMagenta "default")" "$(consoleCode "$nextVersion")"
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
        consoleError "Invalid version $newVersion"
      fi
    done
  fi
  notes="$(__usageEnvironment "$usage" releaseNotes "$newVersion")" || return $?
  if [ ! -f "$notes" ]; then
    trimSpace >"$notes" <<-EOF
        # Release $newVersion

        - Upgrade from $currentVersion
        - New snazzy features here
EOF
    consoleSuccess "Version $newVersion ready - release notes: $notes"
    if $isInteractive; then
      __usageEnvironment "$usage" runHook version-created "$newVersion" "$notes" || return $?
    fi
  else
    consoleWarning "Version $newVersion already - release notes: $notes"
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
