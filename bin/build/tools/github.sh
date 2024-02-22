#!/usr/bin/env bash
#
# github.sh
#
# github tools
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Docs: contextOpen ./docs/_templates/tools/github.md
# Test: contextOpen ./test/bin/github-tests.sh
#

errorEnvironment=1

errorArgument=2

#
# Get the latest release version
#
# Usage: {fn} projectName [ ... ]
#
githubLatestRelease() {
  if [ $# -eq 0 ]; then
    _githubLatestRelease "$errorArgument" "projectName required" || return $?
  fi
  if ! whichApt curl curl; then
    _githubLatestRelease "$errorArgument" "curl is a required dependency" || return $?
  fi
  while [ $# -gt 0 ]; do
    if ! curl -o - -s "https://api.github.com/repos/$1/releases/latest" | jq -r .name; then
      _githubLatestRelease "$errorEnvironment" "API call failed for $1" || return $?
    fi
    shift || _githubLatestRelease "$errorArgument" "shift failed" || return $?
  done
}
_githubLatestRelease() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Summary: Generate a release on GitHub using API
# Usage: {fn} [ --token token ] [ --owner owner ] [ --name name ] [ --expire expire ] descriptionFilePath releaseName commitish
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
#
# Use GitHub API to generate a release
#
# GitHub MUST have two sets of credentials enabled:
#
# - The SSH key for the deployment robot should have push access to the repository on GitHub to enable releases (git handles this)
#  - Found here: https://github.com/$repoOwner/$repoName/settings/keys
# - The `token` must have the permission to create releases for this repository
#  - Found here: https://github.com/settings/tokens
#
# Think of them of the "source" (user) and "target" (ssh key) access. Both must exist to work.
# TODO: GITHUB_ACCESS_TOKEN_EXPIRE is ignored
githubRelease() {
  local start arg descriptionFile releaseName commitish JSON resultsFile accessToken accessTokenExpire repoOwner repoName
  local host

  export GITHUB_ACCESS_TOKEN
  export GITHUB_ACCESS_TOKEN_EXPIRE
  export GITHUB_REPOSITORY_OWNER
  export GITHUB_REPOSITORY_NAME

  extras=()
  accessTokenExpire="${GITHUB_ACCESS_TOKEN_EXPIRE-}"
  accessToken="${GITHUB_ACCESS_TOKEN-}"
  repoOwner="${GITHUB_REPOSITORY_OWNER-}"
  repoName="${GITHUB_REPOSITORY_NAME-}"
  while [ $# -gt 0 ]; do
    arg="$1"
    if [ -z "$arg" ]; then
      _githubRelease $errorArgument "Blank argument" || return $?
    fi
    case "$arg" in
      --token)
        shift || _githubRelease $errorArgument "Missing $arg argument" || return $?
        accessToken="$1"
        ;;
      --owner)
        shift || _githubRelease $errorArgument "Missing $arg argument" || return $?
        repoOwner="$1"
        ;;
      --name)
        shift || _githubRelease $errorArgument "Missing $arg argument" || return $?
        repoName="$1"
        ;;
      --expire)
        shift || _githubRelease $errorArgument "Missing $arg argument" || return $?
        accessTokenExpire="$1"
        ;;
      *)
        extras+=("$1")
        ;;
    esac
    shift
  done
  if [ ${#extras[@]} -ne 3 ]; then
    _githubRelease $errorArgument "Need: descriptionFile releaseName commitish, found ${#extras[@]} arguments" || return $?
    return $?
  fi

  descriptionFile="${extras[0]}"
  releaseName="${extras[1]}"
  commitish="${extras[2]}"

  if ! isUpToDate "$accessTokenExpire" 0; then
    _githubRelease "$errorEnvironment" "Need to update the GitHub access token, expired" || return $?
  fi
  # descriptionFile
  if [ ! -f "$descriptionFile" ]; then
    _githubRelease "$errorArgument" "Description file is not a file" || return $?
  fi
  if [ -z "$repoOwner" ]; then
    _githubRelease "$errorArgument" "Repository owner is blank" || return $?
  fi
  if [ -z "$repoName" ]; then
    _githubRelease "$errorArgument" "Repository name is blank" || return $?
  fi
  if [ -z "$accessToken" ]; then
    _githubRelease "$errorArgument" "Access token is blank" || return $?
  fi
  #
  # Preflight our environment to make sure we have the basics defined in the calling script
  #
  if ! aptWhich curl curl; then
    _githubRelease "$errorEnvironment" "curl is required" || return $?
  fi

  host=github.com
  if ! sshAddKnownHost "$host"; then
    _githubRelease "$errorEnvironment" "Unable to add known host $host" || return $?
  fi
  if git remote | grep -q github; then
    printf "%s %s %s" "$(consoleInfo Remote)" "$(consoleMagenta github)" "$(consoleInfo exists, not adding again.) "
  else
    git remote add github "git@github.com:$repoOwner/$repoName.git"
  fi

  if ! runOptionalHook github-release-before; then
    _githubRelease "$errorEnvironment" "github-release-before failed" || return $?
  fi

  resultsFile="$(buildCacheDirectory results.json)"
  if ! requireFileDirectory "$resultsFile"; then
    _githubRelease "$errorEnvironment" "Unable to create cache directory" || return $?
  fi

  consoleDecoration "$(echoBar)" || :
  bigText "$releaseName" | prefixLines "$(consoleMagenta)" || :
  consoleDecoration "$(echoBar)" || :
  printf "%s %s (%s) %s\n" "$(consoleGreen Tagging)" "$(consoleCode "$releaseName")" "$(consoleMagenta "$commitish")" "$(consoleGreen "and pushing ... ")" || :

  start=$(beginTiming)
  git tag -d "$releaseName" 2>/dev/null || :
  git push origin ":$releaseName" --quiet 2>/dev/null || :
  git push github ":$releaseName" --quiet 2>/dev/null || :
  if ! git tag "$releaseName" ||
    ! git push origin --all --quiet ||
    ! git push origin --tags --quiet ||
    ! git push github --tags --force --quiet ||
    ! git push github --all --force --quiet; then
    _githubRelease "$errorEnvironment" "git operations failed" || return $?
  fi
  reportTiming "$start" "Completed in" || :

  # passing commitish in the JSON results in a failure, just tag it beforehand and push to all remotes (mostly just github)
  # that's good enough

  JSON='{"draft":false,"prerelease":false,"generate_release_notes":false}'
  JSON="$(echo "$JSON" | jq --arg name "$releaseName" --rawfile desc "$descriptionFile" '. + {body: $desc, tag_name: $name, name: $name}')"

  consoleInfo
  if ! curl -s -L \
    -X POST \
    -H "Accept: application/vnd.github+json" \
    -H "Authorization: token $accessToken" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    "https://api.github.com/repos/$repoOwner/$repoName/releases" \
    -d "$JSON" >"$resultsFile"; then
    consoleError "POST failed to GitHub" 1>&2 || :
    prefixLines "$(consoleInfo)JSON: $(consoleCode)" <"$JSON" 1>&2 || :
    buildFailed "$resultsFile" 1>&2 || return $?
  fi
  url="$(jq .html_url <"$resultsFile")"
  if [ -z "$url" ] || [ "$url" = "null" ]; then
    consoleError "Results had no html_url" 1>&2 || :
    consoleError "Access token length ${#accessToken}" 1>&2 || :
    printf %s "$JSON" | prefixLines "$(consoleInfo)Submitted JSON: $(consoleCode)" 1>&2 || :
    buildFailed "$resultsFile" 1>&2 || return $?
  fi
  printf "%s: %s\n" "$(consoleInfo URL)" "$(consoleOrange "$url")" || :

  consoleSuccess "Release $releaseName completed" || :
  rm "$resultsFile" || :
}
_githubRelease() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
