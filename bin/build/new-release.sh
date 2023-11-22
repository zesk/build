#!/usr/bin/env bash
#
# new-release.sh
#
# New release - generates files in system for a new release.
#
# Requires:
#
# - bin/hooks/version-current.sh
#
# Optional:
#
# - bin/hooks/version-live.sh
#
# Uses semantic versioning MAJOR.MINOR.PATCH
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
set -eou pipefail

# IDENTICAL errorEnvironment 1
errorEnvironment=1

# IDENTICAL errorArgument 1
errorArgument=2

me="$(basename "${BASH_SOURCE[0]}")"
cd "$(dirname "${BASH_SOURCE[0]}")/../.."

usage() {
  usageDocument "./bin/build/$me" newRelease "$@"
}

# shellcheck source=/dev/null
. "./bin/build/tools.sh"

defaultVersion() {
  local last prefix

  last=${1##*.}
  prefix=${1%.*}
  prefix=${prefix#v*}
  last=$((last + 1))
  echo "$prefix.$last"
}

# fn: new-release.sh
# Argument: --non-interactive - Optional. If new version is needed, use default version
# Argument: versionName - Optional. Set the new version name to this.
# Argument: fucksauce - Required. Set the new version name to this.
# Short Description: Generate a new release notes and bump the version
# Hook: version-current
# Hook: version-live
# Hook: version-created
# Hook: version-already
# Exit Code: 1 - If new version needs to be created and `--non-interactive`
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
      ;;
    --help)
      usage 0
      return 0
      ;;
    *)
      if [ -n "$newVersion" ]; then
        usage $errorArgument "Unknown argument $1"
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
    usage $errorEnvironment "Requires hook version-current"
    return $?
  fi
  currentVersion=$(runHook version-current)
  if [ -z "$currentVersion" ]; then
    usage $errorEnvironment "version-current returned empty string"
    return $?
  fi
  if hasHook version-live; then
    liveVersion=$(runHook version-live)
    if [ -z "$liveVersion" ]; then
      usage $errorEnvironment "version-live returned empty string"
      return $?
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
    consoleInfo "Ready to deploy: $currentVersion"
    return 0
  fi
  if test $nonInteractive; then
    if [ -z "$newVersion" ]; then
      newVersion=$defaultVersion
    elif ! isVersion "$newVersion"; then
      usage $errorArgument "New version $newVersion is not a valid version tag"
      return $?
    fi
  else
    while true; do
      if test $readLoop; then
        consoleInfo -n "New version? (default $defaultVersion): "
        read -r newVersion
        if [ -z "$newVersion" ]; then
          newVersion=$defaultVersion
        fi
      fi
      if [[ "$newVersion" =~ [0-9]+\.[0-9]+\.[0-9]+ ]]; then
        newVersion="v$newVersion"
        break
      else
        if ! test $readLoop; then
          usage $errorArgument "Invalid version $newVersion"
        else
          consoleError "Invalid version $newVersion"
        fi
      fi
    done
  fi
  releaseNotes=docs/release/$newVersion.md
  if [ ! -f "$releaseNotes" ]; then
    trimSpacePipe >"$releaseNotes" <<-EOF
        # Release $newVersion

        - Upgrade from $currentVersion
        - New snazzy features here
EOF
    consoleSuccess "Version $newVersion ready - release notes: $releaseNotes"
    runHook version-created "$newVersion" "$releaseNotes"
  else
    consoleWarning "Version $newVersion already - release notes: $releaseNotes"
    runHook version-already "$newVersion" "$releaseNotes"
  fi
  git add "$releaseNotes"
}

newRelease "$@"
