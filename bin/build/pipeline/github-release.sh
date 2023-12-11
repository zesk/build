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

# IDENTICAL errorEnvironment 1
errorEnvironment=1

# IDENTICAL errorArgument 1
errorArgument=2

me=$(basename "$0")
cd "$(dirname "${BASH_SOURCE[0]}")/../../.."

# shellcheck source=/dev/null
. ./bin/build/tools.sh

_githubReleaseUsage() {
  usageDocument "bin/build/pipeline/$me" "githubRelease" "$@"
}

#
# fn: {base}
# Usage: {fn} descriptionFilePath releaseName commitish - Generate a release on GitHub using API
# Argument: --token token - Optional. Uses `GITHUB_ACCESS_TOKEN` if not supplied. Access token for GitHub REST API.
# Argument: --owner owner - Optional. Uses `GITHUB_REPOSITORY_OWNER` if not supplied. Repository owner of release.
# Argument: --name name - Optional. Uses `GITHUB_REPOSITORY_NAME` if not supplied. Repository name to release.
# Argument: --expire expireString - Optional. Uses `GITHUB_ACCESS_TOKEN_EXPIRE` if not supplied. Expiration time for the token.
# Argument: descriptionFilePath - Required. File which exists. Path to file containing release notes (typically markdown)
# Argument: releaseName - Required. String. Name of the release (e.g. `v1.0.0`)
# Argument: commitish - Required. String. The GIT short SHA tag for the release
# Environment: GITHUB_ACCESS_TOKEN - Access to GitHub to publish releases
# Environment: GITHUB_ACCESS_TOKEN_EXPIRE - Date in `YYYY-MM-DD` format which represents the date when `GITHUB_ACCESS_TOKEN` expires (required)
# Environment: GITHUB_REPOSITORY_OWNER - Owner of the repository (`https://github.com/owner`)
# Environment: GITHUB_REPOSITORY_NAME - Name of the repository (`https://github.com/owner/name`)
githubRelease() {
  local start descriptionFile releaseName commitish JSON resultsFile accessToken accessTokenExpire repoOwner repoName

  export GITHUB_ACCESS_TOKEN
  export GITHUB_ACCESS_TOKEN_EXPIRE
  export GITHUB_REPOSITORY_OWNER
  export GITHUB_REPOSITORY_NAME

  extras=()
  commitish="$1"
  accessTokenExpire="${GITHUB_ACCESS_TOKEN_EXPIRE-}"
  accessToken="${GITHUB_ACCESS_TOKEN-}"
  repoOwner="${GITHUB_REPOSITORY_OWNER-}"
  repoName="${GITHUB_REPOSITORY_NAME-}"
  shift
  while [ $# -gt 0 ]; do
    case "$1" in
      --token)
        shift || _githubReleaseUsage $errorArgument "Missing token argument"
        accessToken="$1"
        ;;
      --owner)
        shift || _githubReleaseUsage $errorArgument "Missing owner argument"
        repoOwner="$1"
        ;;
      --name)
        shift || _githubReleaseUsage $errorArgument "Missing name argument"
        repoName="$1"
        ;;
      --expire)
        shift || _githubReleaseUsage $errorArgument "Missing expire argument"
        accessTokenExpire="$1"
        ;;
      *)
        if [ -z "$1" ]; then
          _githubReleaseUsage "$errorArgument" "Blank argument"
          return $?
        fi
        extras+=("$1")
        ;;
    esac
    shift
  done
  if [ ${#extras[@]} -ne 3 ]; then
    _githubReleaseUsage $errorArgument "Need: descriptionFile releaseName commitish, found ${#extras[@]} arguments"
    return $?
  fi

  descriptionFile="${extras[0]}"
  releaseName="${extras[1]}"
  commitish="${extras[2]}"

  if ! isUpToDate "$accessTokenExpire" 0; then
    _githubReleaseUsage "$errorEnvironment" "Need to update the GitHub access token, expired"
    return $?
  fi
  # descriptionFile
  if [ ! -f "$descriptionFile" ]; then
    _githubReleaseUsage "$errorArgument" "Description file is not a file"
  fi
  #
  # Preflight our environment to make sure we have the basics defined in the calling script
  #
  aptInstall curl

  start=$(beginTiming)
  consoleInfo -n "Adding remote ..."
  ssh-keyscan github.com >>"$HOME/.ssh/known_hosts" 2>/dev/null
  if git remote | grep -q github; then
    echo -n "$(consoleInfo Remote) $(consoleMagenta github) $(consoleInfo exists, not adding again.) "
  else
    git remote add github "git@github.com:$repoOwner/$repoName.git"
  fi
  reportTiming "$start" OK

  runOptionalHook github-release-before

  consoleDecoration "$(echoBar)"
  bigText "$releaseName" | prefixLines "$(consoleMagenta)"
  consoleDecoration "$(echoBar)"
  consoleGreen -n "Tagging $releaseName ($commitish) and pushing ... "
  start=$(beginTiming)

  git tag -d "$releaseName" 2>/dev/null || :
  git push origin ":$releaseName" --quiet 2>/dev/null || :
  git push github ":$releaseName" --quiet 2>/dev/null || :
  git tag "$releaseName"
  git push origin --all --quiet
  git push origin --tags --quiet
  git push github --tags --force --quiet
  git push github --all --force --quiet
  reportTiming "$start" Completed in

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
  consoleInfo
  if ! curl -s -L \
    -X POST \
    -H "Accept: application/vnd.github+json" \
    -H "Authorization: token $accessToken" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    "https://api.github.com/repos/$repoOwner/$repoName/releases" \
    -d "$JSON" >"$resultsFile"; then
    consoleError "POST failed to GitHub" 1>&2
    prefixLines "$(consoleInfo)JSON: $(consoleCode)" <"$JSON" 1>&2
    buildFailed "$resultsFile" 1>&2
    return $?
  fi
  url="$(jq .html_url <"$resultsFile")"
  if [ -z "$url" ] || [ "$url" = "null" ]; then
    consoleError "Results had no html_url" 1>&2
    consoleError "Access token length ${#accessToken}" 1>&2
    printf %s "$JSON" | prefixLines "$(consoleInfo)Submitted JSON: $(consoleCode)" 1>&2
    buildFailed "$resultsFile" 1>&2
    return $?
  fi
  printf "%s: %s\n" "$(consoleInfo URL)" "$(consoleOrange "$url")"

  consoleSuccess "Release $releaseName completed"
  rm "$resultsFile"
}

githubRelease "$@"
