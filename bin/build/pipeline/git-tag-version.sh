#!/usr/bin/env bash
#
# git-tag-version.sh
#
# does `git pull --tags origin` and then tags build for development or release
# tags up to BUILD_MAXIMUM_TAGS_PER_VERSION as "{current}d{index}"
#
# Depends: apt git docker
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
set -eou pipefail

# IDENTICAL errorArgument 1
errorArgument=2

me=$(basename "${BASH_SOURCE[0]}")
cd "$(dirname "${BASH_SOURCE[0]}")/../../.."

# shellcheck source=/dev/null
. ./bin/build/tools.sh

init=$(beginTiming)
./bin/build/install/git.sh

export usageDelimiter=,
usageOptions() {
  cat <<EOF
--suffix versionSuffix,word to use between version and index as: {current}rc{nextIndex}"
EOF
}
usageDescription() {
  cat <<EOF
$(consoleReset)Generates a git tag for a build version, so $(consoleCode "v1.0d1"), $(consoleCode "v1.0d2"), for version $(consoleCode "v1.0").

Default is: $(consoleLaael --suffix rc) (release candidate)

    $(consoleCode d) for development
    $(consoleCode s) for staging
    $(consoleCode rc) for release candidate

EOF
}
usage() {
  usageMain "$me" "$@"
  return $?
}

export BUILD_MAXIMUM_TAGS_PER_VERSION

# fn: git-tag-version.sh
# Tag a version of the software in git and push tags to origin.
# If this fails it will output the installation log.
# When this tool succeeds the git repository contains a tag with the suffix and an index which represents the build index.
# Usage: git-tag-version.sh [ --suffix versionSuffix ] Tag version in git
# Argument: --suffix - word to use between version and index as: `{current}rc{nextIndex}`
# Hook: version-current
# Environment: BUILD_VERSION_SUFFIX - String. Version suffix to use as a default. If not specified the default is `rc`.
gitTagVersion() {
  local versionSuffix start currentVersion previousVersion releaseNotes
  local tagPrefix index tryVersion maximumTagsPerVersion

  maximumTagsPerVersion=${BUILD_MAXIMUM_TAGS_PER_VERSION:-1000}

  start=$(beginTiming)
  versionSuffix=
  while [ $# -gt 0 ]; do
    case $1 in
    --suffix)
      shift
      versionSuffix=$1
      if [ -z "$versionSuffix" ]; then
        usage $errorArgument "--suffix is blank"
        return $?
      fi
      shift
      ;;
    *)
      usage $errorArgument "Unknown argument: $1"
      return $?
      ;;
    esac
  done

  consoleInfo -n "Pulling tags from origin "
  git pull --tags origin >/dev/null
  reportTiming "$start"

  currentVersion=$(runHook version-current)
  previousVersion=$("./bin/build/version-last.sh" "$currentVersion")

  if git show-ref --tags "$currentVersion" --quiet; then
    consoleError "Version $currentVersion already exists, already tagged." 1>&2
    exit 16
  fi
  if [ "$previousVersion" = "$currentVersion" ]; then
    consoleError "Version $currentVersion up to date, nothing to do." 1>&2
    exit 17
  fi
  echo "$(consoleLabel -n "Previous version is: ") $(consoleValue -n "$previousVersion")"
  echo "$(consoleLabel -n " Release version is: ") $(consoleValue -n "$currentVersion")"

  releaseNotes=./docs/release/$currentVersion.md

  if [ ! -f "$releaseNotes" ]; then
    consoleError "Version $currentVersion no release notes \"$releaseNotes\" found, stopping." 1>&2
    exit 18
  fi

  # rc is for release candidate
  versionSuffix=${versionSuffix:-${BUILD_VERSION_SUFFIX:-rc}}
  tagPrefix="${currentVersion}${versionSuffix}"
  index=0
  while true; do
    tryVersion="$tagPrefix$index"
    if ! git show-ref --tags "$tryVersion" --quiet; then
      break
    fi
    index=$((index + 1))
    if [ $index -gt "$maximumTagsPerVersion" ]; then
      consoleError "Tag version exceeded maximum of $maximumTagsPerVersion" 1>&2
      exit 19
    fi
  done

  consoleInfo "Tagging version $tryVersion and pushing ... "
  git tag "$tryVersion"
  git push --tags --quiet
  git fetch -q
  reportTiming "$init" "Tagged version completed in"
}

gitTagVersion "$@"
