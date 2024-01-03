#!/usr/bin/env bash
#
# new-release.sh
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
set -eou pipefail

# IDENTICAL errorEnvironment 1
errorEnvironment=1

# IDENTICAL errorArgument 1
errorArgument=2

# IDENTICAL me 1
me="$(basename "${BASH_SOURCE[0]}")"

# IDENTICAL bashHeader2 5
set -eou pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/../.."

# shellcheck source=/dev/null
. ./bin/build/tools.sh

_newReleaseUsage() {
  usageDocument "./bin/build/$me" newRelease "$@"
}
defaultVersion() {
  local last prefix

  last=${1##*.}
  prefix=${1%.*}
  prefix=${prefix#v*}
  last=$((last + 1))
  echo "$prefix.$last"
}

#
# fn: new-release.sh
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
  local newVersion readLoop currentVersion liveVersion defaultVersion releaseNotes nonInteractive

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
    echo "$(consoleLabel -n "   Live: ") $(consoleValue -n "$liveVersion")"
  else
    liveVersion=$currentVersion
  fi
  defaultVersion=$(defaultVersion "$liveVersion")
  echo "$(consoleLabel -n "Current: ") $(consoleValue -n "$currentVersion")"
  # echo "$(consoleLabel -n "Default: ") $(consoleValue -n "v$defaultVersion")"
  versionOrdering="$(printf "%s\n%s" "$liveVersion" "$currentVersion")"
  if [ "$currentVersion" != "$liveVersion" ] && [ "$(printf %s "$versionOrdering" | versionSort)" = "$versionOrdering" ] || [ "$currentVersion" == "v$defaultVersion" ]; then
    releaseNotes="$(bin/build/release-notes.sh)"
    consoleInfo "Ready to deploy: $currentVersion"
    consoleWarning "Release notes: $releaseNotes"
    if ! test $nonInteractive; then
      runHook version-already "$currentVersion" "$releaseNotes"
    fi
    return 0
  fi
  if test $nonInteractive; then
    if [ -z "$newVersion" ]; then
      newVersion=$defaultVersion
    elif ! isVersion "$newVersion"; then
      _newReleaseUsage $errorArgument "New version $newVersion is not a valid version tag"
      return $errorArgument
    fi
  else
    while true; do
      if test $readLoop; then
        consoleInfo -n "New version? (default $defaultVersion): "
        read -r newVersion || :
        if [ -z "$newVersion" ]; then
          newVersion=$defaultVersion
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
  releaseNotes="$(bin/build/release-notes.sh)"
  if [ ! -f "$releaseNotes" ]; then
    trimSpacePipe >"$releaseNotes" <<-EOF
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

newRelease "$@"
