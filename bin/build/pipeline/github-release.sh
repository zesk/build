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
requireEnvironment=(GITHUB_ACCESS_TOKEN GITHUB_REPOSITORY_OWNER GITHUB_REPOSITORY_NAME)
export DEBIAN_FRONTEND=noninteractive

#
# Exit codes
#
errEnv=1
errArg=2

me=$(basename "$0")
relTop=../../..
if ! cd "$(dirname "${BASH_SOURCE[0]}")/$relTop"; then
  echo "$me: Can not cd to $relTop" 1>&2
  exit $errEnv
fi

# shellcheck source=/dev/null
. ./bin/build/tools.sh

usage() {
  local rs=$1
  shift
  consoleRed "$*"
  echo
  consoleInfo "$me descriptionFilePath releaseName commitish - Generate a release on GitHub using API"
  echo
  exit "$rs"
}

usageEnvironment "${requireEnvironment[@]}"

if [ ! -f "$1" ]; then
  usage "$errArg" "Pass in description file as first argument"
fi
export descriptionFile="$1"
shift

if [ -z "$1" ]; then
  usage "$errArg" "Pass in release name"
fi
export releaseName="$1"
shift

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

runHook github-release-before.sh

consoleDecoration "$(echoBar)"
bigText "$releaseName" | prefixLines "$(consoleMagenta)"
consoleDecoration "$(echoBar)"
consoleGreen "Tagging $releaseName and pushing ... "
consoleDecoration "$(echoBar)"
start=$(beginTiming)

git tag -d "$releaseName" 2>/dev/null || :
git push origin ":$releaseName" 2>/dev/null || :
git push github ":$releaseName" 2>/dev/null || :
git tag "$releaseName"
git push origin --all --tags
git push github --all --tags --force
consoleDecoration "$(echoBar)"
reportTiming "$start" OK

JSON='{"draft":false,"prerelease":false,"generate_release_notes":false}'
JSON="$(echo "$JSON" | jq --arg commitish "$commitish" --arg name "$releaseName" --rawfile desc "$descriptionFile" '. + {body: $desc, target_commitish: $commitish tag_name: $name, name: $name}')"

curl -L \
  -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: token $GITHUB_ACCESS_TOKEN" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  "https://api.github.com/repos/$GITHUB_REPOSITORY_OWNER/$GITHUB_REPOSITORY_NAME/releases" \
  -d "$JSON"

consoleSuccess "Release $releaseName completed"
