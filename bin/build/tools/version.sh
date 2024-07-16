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

# IDENTICAL errorEnvironment 1
errorEnvironment=1

# IDENTICAL errorArgument 1
errorArgument=2

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
#
releaseNotes() {
  local version

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
    version=$(runHook version-current)
    if [ -z "$version" ]; then
      consoleError "No version-current" 1>&2
      return $errorEnvironment
    fi
  fi
  releasePath="./docs/release"
  if [ ! -d "$releasePath" ]; then
    consoleError "Not a directory $releasePath" 1>&2
    return $errorEnvironment
  fi
  # shellcheck source=/dev/null
  source "$(dirname "${BASH_SOURCE[0]}")/../env/BUILD_RELEASE_NOTES.sh"
  printf "%s/%s.md\n" "${BUILD_RELEASE_NOTES%%/}" "$version"

}

_newReleaseUsage() {
  usageDocument "./bin/build/tools/$(basename "${BASH_SOURCE[0]}")" newRelease "$@"
}

#
# Usage: {fn} lastVersion
# Converts vX.Y.N to vX.Y.(N+1) so v1.0.0 to v1.0.1
#
nextMinorVersion() {
  local last prefix

  last=${1##*.}
  prefix=${1%.*}
  prefix=${prefix#v*}
  if [ "$prefix" != "$1" ]; then
    prefix="$prefix."
  else
    prefix=
  fi
  if ! isInteger "$last"; then
    return $errorArgument
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
  local newVersion readLoop currentVersion liveVersion nextVersion releaseNotes nonInteractive
  local width=40

  nonInteractive=
  newVersion=
  while [ $# -gt 0 ]; do
    case $1 in
      --non-interactive)
        nonInteractive=1
        consoleWarning "Non-interactive mode set"
        ;;
      --help)
        _newReleaseUsage 0
        return 0
        ;;
      *)
        if [ -n "$newVersion" ]; then
          _newReleaseUsage $errorArgument "Unknown argument $1"
          return $?
        fi
        newVersion=$1
        ;;
    esac
    shift
  done

  readLoop=
  if [ -z "$newVersion" ]; then
    readLoop=1
  fi
  if ! hasHook version-current; then
    _newReleaseUsage $errorEnvironment "Requires hook version-current"
    return "$errorEnvironment"
  fi
  currentVersion=$(runHook version-current)
  if [ -z "$currentVersion" ]; then
    _newReleaseUsage $errorEnvironment "version-current returned empty string"
    return "$errorEnvironment"
  fi
  if hasHook version-live; then
    liveVersion=$(runHook version-live)
    if [ -z "$liveVersion" ]; then
      _newReleaseUsage $errorEnvironment "version-live returned empty string"
      return "$errorEnvironment"
    fi
    consoleNameValue $width "Live:" "$liveVersion"
  else
    liveVersion=$currentVersion
  fi
  nextVersion=$(nextMinorVersion "$liveVersion")
  consoleNameValue $width "Current:" "$currentVersion"
  versionOrdering="$(printf "%s\n%s" "$liveVersion" "$currentVersion")"
  if [ "$currentVersion" != "$liveVersion" ] && [ "$(printf %s "$versionOrdering" | versionSort)" = "$versionOrdering" ] || [ "$currentVersion" == "v$nextVersion" ]; then
    releaseNotes="$(releaseNotes)"
    consoleNameValue $width "Ready to deploy:" "$currentVersion"
    consoleNameValue $width "Release notes:" "$releaseNotes"
    if ! test $nonInteractive; then
      runHook version-already "$currentVersion" "$releaseNotes"
    fi
    return 0
  fi
  if test $nonInteractive; then
    if [ -z "$newVersion" ]; then
      newVersion=$nextVersion
    elif ! isVersion "$newVersion"; then
      _newReleaseUsage $errorArgument "New version $newVersion is not a valid version tag"
      return $errorArgument
    fi
  else
    while true; do
      if test $readLoop; then
        printf "%s? (%s %s) " "$(consoleInfo "New version")" "$(consoleBoldMagenta "default")" "$(consoleCode "$nextVersion")"
        read -r newVersion || :
        if [ -z "$newVersion" ]; then
          newVersion=$nextVersion
        fi
      fi
      if [[ "$newVersion" =~ [0-9]+\.[0-9]+\.[0-9]+ ]]; then
        newVersion="v$newVersion"
        break
      else
        if ! test $readLoop; then
          _newReleaseUsage $errorArgument "Invalid version $newVersion"
        else
          consoleError "Invalid version $newVersion"
        fi
      fi
    done
  fi
  releaseNotes="$(releaseNotes "$newVersion")"
  if [ ! -f "$releaseNotes" ]; then
    trimSpace >"$releaseNotes" <<-EOF
        # Release $newVersion

        - Upgrade from $currentVersion
        - New snazzy features here
EOF
    consoleSuccess "Version $newVersion ready - release notes: $releaseNotes"
    if ! test $nonInteractive; then
      runHook version-created "$newVersion" "$releaseNotes"
    fi
  else
    consoleWarning "Version $newVersion already - release notes: $releaseNotes"
    if ! test $nonInteractive; then
      runHook version-already "$newVersion" "$releaseNotes"
    fi
  fi
  git add "$releaseNotes"
}
