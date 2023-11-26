#!/usr/bin/env bash
#
# github-release.sh
#
# Depends: apt
#
# Release something on GitHub
#
# Copyright &copy; 2023 Market Acumen, Inc.
#

set -eo pipefail

#
#  ▞▀▖      ▗▀▖▗             ▐  ▗
#  ▌  ▞▀▖▛▀▖▐  ▄ ▞▀▌▌ ▌▙▀▖▝▀▖▜▀ ▄ ▞▀▖▛▀▖
#  ▌ ▖▌ ▌▌ ▌▜▀ ▐ ▚▄▌▌ ▌▌  ▞▀▌▐ ▖▐ ▌ ▌▌ ▌
#  ▝▀ ▝▀ ▘ ▘▐  ▀▘▗▄▘▝▀▘▘  ▝▀▘ ▀ ▀▘▝▀ ▘ ▘
export DEBIAN_FRONTEND=noninteractive

#
# Exit codes
#

# IDENTICAL errorArgument 1
errorArgument=2

me=$(basename "$0")
cd "$(dirname "${BASH_SOURCE[0]}")/../../.."

# shellcheck source=/dev/null
. ./bin/build/tools.sh

usage() {
  usageDocument "bin/build/pipeline/$me" "githubRelease" "$@"
}

#
# fn: {base}
# Usage: {fn} descriptionFilePath releaseName commitish - Generate a release on GitHub using API
# Argument: descriptionFilePath - Required. File which exists. Path to file containing release notes (typically markdown)
# Argument: releaseName - Required. String. Name of the release (e.g. `v1.0.0`)
# Argument: commitish - Required. String. The GIT short SHA tag for the release
#
githubRelease() {
  local start descriptionFile releaseName commitish JSON resultsFile
  local requireEnvironment=(GITHUB_ACCESS_TOKEN GITHUB_REPOSITORY_OWNER GITHUB_REPOSITORY_NAME)

  usageEnvironment "${requireEnvironment[@]}"

  # descriptionFile
  if [ ! -f "$1" ]; then
    usage "$errorArgument" "Pass in description file path as first argument"
  fi
  descriptionFile="$1"

  # releaseName
  if ! shift; then
    usage "$errorArgument" "Missing release name"
    return $?
  fi
  if [ -z "$1" ]; then
    usage "$errorArgument" "Empty releaseName"
  fi
  releaseName="$1"

  # commitish
  if ! shift; then
    usage "$errorArgument" "Missing commitish"
    return $?
  fi
  if [ -z "$1" ]; then
    usage "$errorArgument" "Empty commitish"
  fi
  commitish="$1"
  shift
  while [ $# -gt 0 ]; do
    case $1 in
    --help)
      if usage 0; then
        return 0
      fi
      ;;
    *)
      if ! usage "$errorArgument" "Unknown argument $1"; then
        return "$errorArgument"
      fi
      ;;
    esac
    shift
  done

  #
  # Preflight our environment to make sure we have the basics defined in the calling script
  #
  ./bin/build/install/apt.sh curl

  start=$(beginTiming)
  consoleInfo -n "Adding remote ..."
  ssh-keyscan github.com >>"$HOME/.ssh/known_hosts" 2>/dev/null
  if git remote | grep -q github; then
    echo -n "$(consoleInfo Remote) $(consoleMagenta github) $(consoleInfo exists, not adding again.) "
  else
    git remote add github "git@github.com:$GITHUB_REPOSITORY_OWNER/$GITHUB_REPOSITORY_NAME.git"
  fi
  reportTiming "$start" OK

  runOptionalHook github-release-before

  consoleDecoration "$(echoBar)"
  bigText "$releaseName" | prefixLines "$(consoleMagenta)"
  consoleDecoration "$(echoBar)"
  consoleGreen "Tagging $releaseName ($commitish) and pushing ... "
  consoleDecoration "$(echoBar)"
  start=$(beginTiming)

  git tag -d "$releaseName" 2>/dev/null || :
  git push origin ":$releaseName" --quiet 2>/dev/null || :
  git push github ":$releaseName" --quiet 2>/dev/null || :
  git tag "$releaseName"
  git push origin --all --quiet
  git push origin --tags --quiet
  git push github --tags --force --quiet
  git push github --all --force --quiet
  consoleDecoration "$(echoBar)"
  reportTiming "$start" OK

  # passing commitish in the JSON results in a failure, just tag it beforehand and push to all remotes (mostly just github) that's good enough
  #
  # GitHub MUST have two sets of credentials enabled:
  # - The SSH key for the deployment robot should have push access to the repository on GitHub to enable releases (git handles this)
  # - The GITHUB_ACCESS_TOKEN must have the permission to create releases for this repository
  #
  JSON='{"draft":false,"prerelease":false,"generate_release_notes":false}'
  JSON="$(echo "$JSON" | jq --arg name "$releaseName" --rawfile desc "$descriptionFile" '. + {body: $desc, tag_name: $name, name: $name}')"

  resultsFile=./.build/results.json
  requireFileDirectory "$resultsFile"
  if ! curl -s -L \
    -X POST \
    -H "Accept: application/vnd.github+json" \
    -H "Authorization: token $GITHUB_ACCESS_TOKEN" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    "https://api.github.com/repos/$GITHUB_REPOSITORY_OWNER/$GITHUB_REPOSITORY_NAME/releases" \
    -d "$JSON" >"$resultsFile"; then
    buildFailed "$resultsFile"
  fi
  echo
  consoleSuccess "$(jq .html_url <"$resultsFile")"
  echo
  consoleSuccess "Release $releaseName completed"
  rm "$resultsFile"
}

githubRelease "$@"
