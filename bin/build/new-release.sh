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
set -eo pipefail
errEnv=1
errArg=2

me="$(basename "${BASH_SOURCE[0]}")"
relTop="../.."
if ! cd "$(dirname "${BASH_SOURCE[0]}")/$relTop"; then
  echo "$me: Can not cd to $relTop" 1>&2
  exit $errEnv
fi

usage() {
  local rs=$1

  shift
  exec 1>&2
  echo "$me $*"
  exit "$rs"
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
newVersion=
while [ $# -gt 0 ]; do
  case $1 in
  *)
    if [ -n "$newVersion" ]; then
      usage $errArg "Unknown argument $1"
    fi
    newVersion=$1
    shift
    ;;
  esac
done

readLoop=
if [ -z "$newVersion" ]; then
  readLoop=1
fi
if ! hasHook version-current; then
  usage $errEnv "Requires hook version-current"
fi
currentVersion=$(runHook version-current)
if [ -z "$currentVersion" ]; then
  usage $errEnv "version-current returned empty string"
fi
if hasHook version-live; then
  liveVersion=$(runHook version-live)
  if [ -z "$liveVersion" ]; then
    usage $errEnv "version-live returned empty string"
  fi
  echo "$(consoleLabel -n "   Live: ") $(consoleValue -n "$liveVersion")"
else
  liveVersion=$currentVersion
fi
defaultVersion=$(defaultVersion "$liveVersion")
echo "$(consoleLabel -n "Current: ") $(consoleValue -n "$currentVersion")"
# echo "$(consoleLabel -n "Default: ") $(consoleValue -n "v$defaultVersion")"
if [ "$currentVersion" == "v$defaultVersion" ]; then
  consoleError "Ready to deploy: $currentVersion"
  exit 0
fi
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
      usage $errArg "Invalid version $newVersion"
    else
      consoleError "Invalid version $newVersion"
    fi
  fi
done

releaseNotes=docs/release/$newVersion.md
if [ ! -f "$releaseNotes" ]; then
  cat >"$releaseNotes" <<EOF
# Release $newVersion

- Upgrade from $currentVersion
- Lots of new
- Features here

EOF
  consoleSuccess "Version $newVersion ready - release notes: $releaseNotes"
  runHook version-created "$newVersion" "$releaseNotes"
else
  consoleWarning "Version $newVersion already - release notes: $releaseNotes"
  runHook version-already "$newVersion" "$releaseNotes"
fi
git add "$releaseNotes"
