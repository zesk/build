#!/usr/bin/env bash
#
# github.sh
#
# github tools
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Docs: contextOpen ./documentation/source/tools/github.md
# Test: contextOpen ./test/bin/github-tests.sh
#

#
# Get the latest release version
#
# Argument: handler - Function. Error handler.
# Argument: query - Query to jq to extract the JSON result
# Argument: suffix - API suffix to call (blank OK)
# Argument: ownerRepository - The github `owner/repository` to query
# Now supports `GITHUB_ACCESS_TOKEN`
# Environment: GITHUB_ACCESS_TOKEN
__githubAPI() {
  local handler="$1" query="$2" suffix="${3-}" && shift 3

  [ $# -gt 0 ] || __throwArgument "$handler" "projectName required" || return $?

  if ! packageWhich curl curl; then
    __throwEnvironment "$handler" "curl is a required dependency" || return $?
  fi

  local accessToken hh=() details=()
  accessToken=$(__catchEnvironment "$handler" buildEnvironmentGet GITHUB_ACCESS_TOKEN) || return $?
  if [ -n "$accessToken" ]; then
    hh+=(-H "Authorization: token $accessToken")
    details+=("$(decorate green Authenticated)")
  fi

  errorFile=$(fileTemporaryName "$handler") || return $?
  while [ $# -gt 0 ]; do
    local url="https://api.github.com/repos/$1${suffix}"
    if ! curl "${hh[@]+"${hh[@]}"}" -o - -s "$url" 2>>"$errorFile" | jq -r "$query" 2>>"$errorFile"; then
      __throwEnvironment "$handler" "API call failed for $1 ($(decorate code "$url"))"$'\n'"${details[*]-}"$'\n'"$(dumpPipe Errors <"$errorFile")" || _clean $? "$errorFile" || return $?
    fi
    shift
  done
  __catchEnvironment "$handler" rm -rf "$errorFile" || return $?
}

#
# Get the latest release structure
#
# Argument: handler - Function. Error handler.
# Argument: query - Query to jq to extract the JSON result
# Argument: ownerRepository - The github `owner/repository` to query
__githubLatestVariable() {
  local handler="$1" query="$2" && shift 2
  __githubAPI "$handler" "$query" "/releases/latest" "$@"
}

# Parse a GitHub URL and return the owner and project name
# Argument: url - URL. Required. URL to parse.
githubURLParse() {
  local usage="_${FUNCNAME[0]}"

  [ $# -gt 0 ] || __throwArgument "$usage" "url required" || return $?

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
      # _IDENTICAL_ --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      *)
        local url path
        url=$(usageArgumentURL "$usage" "url" "$1") || return $?
        local host
        host=$(urlParseItem host "$url") || return $?
        if [ "$host" != "github.com" ]; then
          __throwArgument "$usage" "Not a github site: $(decorate code "$url")" || return $?
        fi
        path=$(urlParseItem path "$url") || return $?
        # Trim ends of slashes
        path="${path#/}"
        path="${path%/}"
        local owner repository _
        IFS='/' read -d '' -r owner repository _ <<<"$path" || :
        [ -n "$owner" ] || __throwArgument "usage" "Blank owner" || return $?
        [ -n "$repository" ] || __throwArgument "usage" "Blank repository" || return $?
        printf "%s/%s\n" "$owner" "$repository"
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done
}
_githubURLParse() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Output the publish date for the latest release of ownerRepository
# Argument: ownerRepository - String. Github `owner/repository` string
githubPublishDate() {
  local usage="_${FUNCNAME[0]}"
  __githubLatestVariable "$usage" ".published_at" "$@"
}
_githubPublishDate() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Get the latest release version
#
# Argument: projectName - String. Required. Github project name in the form of `owner/repository`
# Environment: GITHUB_ACCESS_TOKEN
githubLatestRelease() {
  local usage="_${FUNCNAME[0]}"

  __githubLatestVariable "$usage" ".name" "$@"
}
_githubLatestRelease() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Get a project JSON structure
# Environment: GITHUB_ACCESS_TOKEN
githubProjectJSON() {
  __githubLatestVariable "$usage" "." "$@"
}
_githubProjectJSON() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Get the latest JSON structure
#
# Argument: projectName - String. Required. Github project name in the form of `owner/repository`
# Environment: GITHUB_ACCESS_TOKEN
githubLatest() {
  local usage="_${FUNCNAME[0]}"

  __githubAPI "$usage" "." "" "$@"
}
_githubLatest() {
  # _IDENTICAL_ usageDocument 1
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
# Environment: - `GITHUB_ACCESS_TOKEN` - Access to GitHub to publish releases
# Environment: - `GITHUB_ACCESS_TOKEN_EXPIRE` - Date in `YYYY-MM-DD` format which represents the date when `GITHUB_ACCESS_TOKEN` expires (required)
# Environment: - `GITHUB_REPOSITORY_OWNER` - Owner of the repository (`https://github.com/owner`)
# Environment: - `GITHUB_REPOSITORY_NAME` - Name of the repository (`https://github.com/owner/name`)
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
# Environment: GITHUB_ACCESS_TOKEN
githubRelease() {
  local usage="_${FUNCNAME[0]}"
  local start argument descriptionFile releaseName commitish JSON resultsFile accessToken accessTokenExpire repoOwner repoName
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
    argument="$1"
    [ -n "$argument" ] || __throwArgument "$usage" "blank argument" || return $?
    case "$argument" in
      --token)
        shift
        [ -n "${1-}" ] || __throwArgument "$usage" "Blank $argument argument" || return $?
        accessToken="$1"
        ;;
      --owner)
        shift
        [ -n "${1-}" ] || __throwArgument "$usage" "Blank $argument argument" || return $?
        repoOwner="$1"
        ;;
      --name)
        shift
        [ -n "${1-}" ] || __throwArgument "$usage" "Blank $argument argument" || return $?
        repoName="$1"
        ;;
      --expire)
        shift
        [ -n "${1-}" ] || __throwArgument "$usage" "Blank $argument argument" || return $?
        accessTokenExpire="$1"
        ;;
      *)
        extras+=("$1")
        ;;
    esac
    shift || __throwArgument "$usage" "missing argument $(decorate label "$argument")" || return $?
  done

  [ ${#extras[@]} -eq 3 ] || __throwArgument "$usage" "Need: descriptionFile releaseName commitish, found ${#extras[@]} arguments" || return $?

  descriptionFile="${extras[0]}"
  releaseName="${extras[1]}"
  commitish="${extras[2]}"

  isUpToDate --name "GITHUB_ACCESS_TOKEN_EXPIRE" "$accessTokenExpire" 0 || __throwEnvironment "$usage" "Need to update the GitHub access token, expired" || return $?
  # descriptionFile
  [ -f "$descriptionFile" ] || __throwEnvironment "$usage" "Description file $descriptionFile is not a file" || return $?
  [ -n "$repoOwner" ] || __throwArgument "$usage" "Repository owner is blank" || return $?
  [ -n "$repoName" ] || __throwArgument "$usage" "Repository name is blank" || return $?
  [ -n "$accessToken" ] || __throwArgument "$usage" "Access token is blank" || return $?

  #
  # Preflight our environment to make sure we have the basics defined in the calling script
  #
  __catchEnvironment "$usage" packageWhich curl curl || return $?

  host=github.com
  __catchEnvironment "$usage" sshAddKnownHost "$host" || return $?

  if git remote | grep -q github; then
    printf "%s %s %s" "$(decorate info Remote)" "$(decorate magenta github)" "$(decorate info exists, not adding again.) " || :
  else
    __catchEnvironment "$usage" git remote add github "git@github.com:$repoOwner/$repoName.git" || return $?
  fi

  __catchEnvironment "$usage" hookRunOptional github-release-before || return $?

  resultsFile="$(buildCacheDirectory)/results.json" || __throwEnvironment "$usage" "Unable create cache directory" || return $?

  decorate decoration "$(echoBar)" || :
  bigText "$releaseName" | wrapLines "$(decorate magenta)" "$(decorate reset)" || :
  decorate decoration "$(echoBar)" || :
  printf "%s %s (%s) %s\n" "$(decorate green Tagging)" "$(decorate code "$releaseName")" "$(decorate magenta "$commitish")" "$(decorate green "and pushing ... ")" || :

  start=$(timingStart)

  statusMessage decorate warning "Deleting any trace of the $releaseName tag"
  git tag -d "$releaseName" 2>/dev/null || :
  git push origin ":$releaseName" --quiet 2>/dev/null || :
  git push github ":$releaseName" --quiet 2>/dev/null || :

  __catchEnvironment "$usage" git tag "$releaseName" || return $?
  __catchEnvironment "$usage" git push origin --tags --quiet || return $?
  __catchEnvironment "$usage" git push github --tags --force --quiet || return $?
  __catchEnvironment "$usage" git push github --all --force --quiet || return $?
  timingReport "$start" "Completed in" || :

  # passing commitish in the JSON results in a failure, just tag it beforehand and push to all remotes (mostly just github)
  # that's good enough

  JSON='{"draft":false,"prerelease":false,"generate_release_notes":false}'
  JSON="$(echo "$JSON" | jq --arg name "$releaseName" --rawfile desc "$descriptionFile" '. + {body: $desc, tag_name: $name, name: $name}')" || __throwEnvironment "$usage" "Generating JSON" || return $?

  decorate info
  if ! curl -s -L \
    -X POST \
    -H "Accept: application/vnd.github+json" \
    -H "Authorization: token $accessToken" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    "https://api.github.com/repos/$repoOwner/$repoName/releases" \
    -d "$JSON" >"$resultsFile"; then
    decorate error "POST failed to GitHub" 1>&2 || :
    wrapLines "$(decorate info)JSON: $(decorate code)" "$(decorate reset)" <"$JSON" 1>&2 || :
    buildFailed "$resultsFile" 1>&2 || return $?
  fi
  url="$(jq .html_url <"$resultsFile")"
  if [ -z "$url" ] || [ "$url" = "null" ]; then
    decorate error "Results had no html_url" 1>&2 || :
    decorate error "Access token length ${#accessToken}" 1>&2 || :
    printf %s "$JSON" | wrapLines "$(decorate info)Submitted JSON: $(decorate code)" "$(decorate reset)" 1>&2 || :
    buildFailed "$resultsFile" 1>&2 || return $?
  fi
  printf "%s: %s\n" "$(decorate info URL)" "$(decorate orange "$url")" || :

  decorate success "Release $releaseName completed" || :
  rm "$resultsFile" || :
}
_githubRelease() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
