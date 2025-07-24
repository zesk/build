#!/usr/bin/env bash
#
# git tools, lame attempts have been made to have each function start with `git`.
#
# Copyright &copy; 2025 Market Acumen, Inc.
# bin: git
#
# Docs: ./documentation/source/tools/git.md
# Test: ./test/bin/git-tests.sh
#

###############################################################################
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~██~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~▀▀~~~~~██~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~▄███▄██~~~████~~~███████~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~██▀  ▀██~~~~~██~~~~~██~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~██    ██~~~~~██~~~~~██~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~▀██▄▄███~~▄▄▄██▄▄▄~~██▄▄▄~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~▄▀▀▀ ██~~▀▀▀▀▀▀▀▀~~~▀▀▀▀~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~▀████▀▀~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#------------------------------------------------------------------------------

#
# Installs the `git` binary
# Usage: gitInstall [ package ... ]
# Argument: package - Additional packages to install
# Summary: Install git if needed
#
gitInstall() {
  __help "_${FUNCNAME[0]}" "$@" || return 0
  packageWhich git git "$@"
}
_gitInstall() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Uninstalls the `git` binary
# Usage: {fn} [ package ... ]
# Argument: package - Additional packages to uninstall
# Summary: Uninstall git
#
gitUninstall() {
  __help "_${FUNCNAME[0]}" "$@" || return 0
  packageWhichUninstall git git "$@"
}
_gitUninstall() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# When running git operations on a deployment host, at times it's necessary to
# add the current directory (or a directory) to the git `safe.directory` directive.
#
# This adds the directory passed to that directory in the local user's environment
#
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: directory - Required. Directory. The directory to add to the `git` `safe.directory` configuration directive
# Exit Code: 0 - Success
# Exit Code: 2 - Argument is not a valid directory
# Exit Code: Other - git config error codes
#
gitEnsureSafeDirectory() {
  local usage="_${FUNCNAME[0]}"
  while [ $# -gt 0 ]; do
    [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
    [ -d "$1" ] || __throwArgument "$usage" "$1 is not a directory" || return $?
    if ! git config --global --get safe.directory | grep -q "$1"; then
      __catchEnvironment "$usage" git config --global --add safe.directory "$1" || return $?
    fi
    shift
  done
}
_gitEnsureSafeDirectory() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Delete git tag locally and at origin
#
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: tag - The tag to delete locally and at origin
# Exit Code: argument - Any stage fails will result in this exit code. Partial deletion may occur.
#
gitTagDelete() {
  local usage="_${FUNCNAME[0]}"
  local exitCode=0
  export GIT_REMOTE

  __catch "$usage" buildEnvironmentLoad GIT_REMOTE || return $?
  usageRequireEnvironment "$usage" GIT_REMOTE || return $?
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
      # Deleting local tag
      __catchArgument "$usage" git tag -d "$argument" || exitCode=$?
      # Deleting remote tag
      __catchArgument "$usage" git push "$GIT_REMOTE" :"$argument" || exitCode=$?
      ;;
    esac
    shift
  done
  return "$exitCode"
}
_gitTagDelete() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Remove a tag everywhere and tag again on the current branch
#
# Usage: gitTagDelete [ tag ... ]
# Argument: tag - The tag to delete locally and remote
# Exit Code: 2 - Any stage fails will result in this exit code. Partial deletion may occur.
#
gitTagAgain() {
  local usage="_${FUNCNAME[0]}" a=("$@")

  [ $# -gt 0 ] || __throwArgument "$usage" "No arguments" || return $?
  while [ $# -gt 0 ]; do
    [ "${1-}" != "--help" ] || __help "$usage" "$@" || return 0
    statusMessage decorate info "Deleting tag $1 ..."
    __catchArgument "$usage" gitTagDelete "$1" || return $?
    statusMessage decorate info "Tagging again $1 ..."
    __catchArgument "$usage" git tag "$1" || return $?
    __catchArgument "$usage" git push --tags || return $?
  done
  statusMessage --last decorate info "All tags completed" "$(decorate orange "${a[@]}")"
}
_gitTagAgain() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Fetches a list of tags from git and filters those which start with v and a digit and returns
# them sorted by version correctly.
#
# Usage: gitVersionList
# Exit Code: 1 - If the `.git` directory does not exist
# Exit Code: 0 - Success
#
gitVersionList() {
  local usage="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$usage" "$@" || return 0
  [ -d "./.git" ] || __throwEnvironment "$usage" "No .git directory at $(pwd), stopping" || return $?
  __catchEnvironment "$usage" git tag | grep -e '^v[0-9.]*$' | versionSort "$@" || return $?
}
_gitVersionList() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Get the last reported version.
# Usage: gitVersionLast [ ignorePattern ]
# Argument: ignorePattern - Optional. Specify a grep pattern to ignore; allows you to ignore current version
gitVersionLast() {
  local usage="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$usage" "$@" || return 0
  local skip
  if [ -n "${1-}" ]; then
    skip="$1"
    shift
    gitVersionList "$@" | grep -v "$skip" | tail -1
  else
    gitVersionList "$@" | tail -1
  fi
}
_gitVersionLast() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Given a tag in the form "1.1.3" convert it to "v1.1.3" so it has a character prefix "v"
# Delete the old tag as well
#
veeGitTag() {
  local usage="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$usage" "$@" || return 0

  local tagName
  tagName=$(usageArgumentString "$usage" "tagName" "${1-}") || return $?

  [ "$tagName" = "${tagName#v}" ] || __throwArgument "$usage" "already v'd': $(decorate value "$tagName")" || return $?
  __catchEnvironment "$usage" git tag "v$tagName" "$tagName" || return $?
  __catchEnvironment "$usage" git tag -d "$tagName" || return $?
  __catchEnvironment "$usage" git push origin "v$tagName" ":$tagName" || return $?
  __catchEnvironment "$usage" git fetch -q --prune --prune-tags || return $?
}
_veeGitTag() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Has a lot of caveats
#
# gitRemoveFileFromHistory path/to/file
#
# usually have to `git push --force`
#
gitRemoveFileFromHistory() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  git filter-branch --index-filter "git rm -rf --cached --ignore-unmatch $1" HEAD
}
_gitRemoveFileFromHistory() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Exit Code: 1 - the repo has NOT been modified
# Exit Code: 0 - the repo has been modified
#
# Has a git repository been changed from HEAD?
# Source: https://stackoverflow.com/questions/3882838/whats-an-easy-way-to-detect-modified-files-in-a-git-workspace/3899339#3899339
# Credit: Chris Johnsen
#
gitRepositoryChanged() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  ! git diff-index --quiet HEAD 2>/dev/null
}
_gitRepositoryChanged() {
  true || gitRepositoryChanged --help
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Usage: gitShowChanges
# Exit Code: 0 - the repo has been modified
# Exit Code: 1 - the repo has NOT bee modified
#
# Show changed files from HEAD
# Source: https://stackoverflow.com/questions/3882838/whats-an-easy-way-to-detect-modified-files-in-a-git-workspace/3899339#3899339
# Credit: Chris Johnsen
#
gitShowChanges() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  git diff-index --name-only HEAD
}
_gitShowChanges() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Usage: gitShowStatus
# Exit Code: 0 - the repo has been modified
# Exit Code: 1 - the repo has NOT bee modified
#
# Show changed files from HEAD with their status prefix character:
#
# - ' ' = unmodified
# - `M` = modified
# - `A` = added
# - `D` = deleted
# - `R` = renamed
# - `C` = copied
# - `U` = updated but unmerged
#
# (See `man git` for more details on status flags)
#
# Source: https://stackoverflow.com/questions/3882838/whats-an-easy-way-to-detect-modified-files-in-a-git-workspace/3899339#3899339
# Credit: Chris Johnsen
#
gitShowStatus() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  git diff-index --name-status "$@" HEAD
}
_gitShowStatus() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Are we currently inside a git hook?
#
# Tests non-blank strings in our environment.
#
# Environment: GIT_EXEC_PATH - Must be set to pass
# Environment: GIT_INDEX_FILE - Must be set to pass
# Exit Code: 0 - We are, semantically, inside a git hook
# Exit Code: 1 - We are NOT, semantically, inside a git hook
#
gitInsideHook() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  [ -n "${GIT_EXEC_PATH-}" ] && [ -n "${GIT_INDEX_FILE-}" ]
}
_gitInsideHook() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# List remote hosts for the current git repository
# Parses `user@host:path/project.git` and extracts `host`
#
gitRemoteHosts() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  local remoteUrl host
  while read -r remoteUrl; do
    host=$(urlParseItem host "$remoteUrl") || host=$(urlParseItem host "git://$remoteUrl") || __throwArgument "$usage" "Unable to extract host from \"$remoteUrl\"" || return $?
    printf -- "%s\n" "$host"
  done < <(git remote -v | awk '{ print $2 }')
}
_gitRemoteHosts() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Generates a git tag for a build version, so `v1.0d1`, `v1.0d2`, for version `v1.0`.
# Tag a version of the software in git and push tags to origin.
# If this fails it will output the installation log.
# When this tool succeeds the git repository contains a tag with the suffix and an index which represents the build index.
#
# Default is: `--suffix rc` **release candidate**
#
# - `d` - for **development**
# - `s` - for **staging**
# - `rc` - for **release candidate**
#
# Usage: {fn} [ --suffix versionSuffix ] Tag version in git
# Argument: --suffix - word to use between version and index as: `{current}rc{nextIndex}`
# Hook: version-current
# Environment: BUILD_VERSION_SUFFIX - String. Version suffix to use as a default. If not specified the default is `rc`.
# Environment: BUILD_MAXIMUM_TAGS_PER_VERSION - Integer. Number of integers to attempt to look for when incrementing.
gitTagVersion() {
  local usage="_${FUNCNAME[0]}"
  local maximumTagsPerVersion

  __catch "$usage" buildEnvironmentLoad BUILD_MAXIMUM_TAGS_PER_VERSION || return $?

  maximumTagsPerVersion="$BUILD_MAXIMUM_TAGS_PER_VERSION"
  local init start versionSuffix

  init=$(timingStart) || return $?
  start=$init
  versionSuffix=""

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
    --suffix)
      shift || __throwArgument "$usage" "missing $argument argument" || return $?
      versionSuffix="${1-}"
      [ -n "$versionSuffix" ] || __throwArgument "$usage" "Blank $argument argument" || return $?
      ;;
    *)
      __throwArgument "$usage" "unknown argument: $argument" || return $?
      ;;
    esac
    shift || __throwArgument "$usage" "shift $argument" || return $?
  done

  statusMessage decorate info "Pulling tags from origin "
  __catchEnvironment "$usage" git pull --tags origin >/dev/null || return $?
  statusMessage timingReport "$start" "Pulled tags in"

  statusMessage decorate info "Pulling tags from origin "
  __catchEnvironment "$usage" git pull --tags origin >/dev/null || return $?
  statusMessage timingReport "$start" "Pulled tags in"

  local currentVersion previousVersion releaseNotes
  local tagPrefix index tryVersion

  currentVersion=$(__catchEnvironment "$usage" hookRun version-current) || return $?
  if ! previousVersion=$(gitVersionLast "$currentVersion"); then
    previousVersion="none"
  fi

  if git show-ref --tags "$currentVersion" --quiet; then
    decorate error "Version $currentVersion already exists, already tagged." 1>&2
    return 16
  fi
  if [ "$previousVersion" = "$currentVersion" ]; then
    decorate error "Version $currentVersion up to date, nothing to do." 1>&2
    return 17
  fi
  printf -- "%s %s\n%s %s\n" \
    "$(decorate label "Previous version is: ")" "$(decorate value "$previousVersion")" \
    "$(decorate label " Release version is: ")" "$(decorate value "$currentVersion")"

  releaseNotes="$(releaseNotes "$currentVersion")" || __throwEnvironment "$usage" "releaseNotes $currentVersion failed" || return $?

  if [ ! -f "$releaseNotes" ]; then
    decorate error "Version $currentVersion no release notes \"$releaseNotes\" found, stopping." 1>&2
    return 18
  fi

  local tagFile clean=()

  tagFile=$(fileTemporaryName "$usage") || return $?
  clean=("$tagFile")
  # rc is for release candidate
  versionSuffix=${versionSuffix:-${BUILD_VERSION_SUFFIX:-rc}}
  tagPrefix="${currentVersion}${versionSuffix}"
  __catchEnvironment "$usage" git show-ref --tags | removeFields 1 | __catchEnvironment "$usage" muzzle tee -a "$tagFile" || returnClean $? "${clean[@]}" || return $?
  index=0
  while true; do
    tryVersion="$tagPrefix$index"
    if ! grep -q "$tryVersion" "$tagFile"; then
      break
    fi
    index=$((index + 1))
    [ $index -lt "$maximumTagsPerVersion" ] || __throwEnvironment "$usage" "Tag version exceeded maximum of $maximumTagsPerVersion" || returnClean $? "${clean[@]}" || return $?
  done
  __catchEnvironment "$usage" rm -rf "${clean[@]}" || return $?

  statusMessage decorate info "Tagging version $(decorate code "$tryVersion") ... " || return $?
  __catchEnvironment "$usage" git tag "$tryVersion" || return $?
  statusMessage decorate info "Pushing version $(decorate code "$tryVersion") ... " || return $?
  __catchEnvironment "$usage" git push --tags --quiet || return $?
  statusMessage decorate info "Fetching version $(decorate code "$tryVersion") ... " || return $?
  __catchEnvironment "$usage" git fetch -q || return $?
  statusMessage --last timingReport "$init" "Tagged version completed in" || return $?
}
_gitTagVersion() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: {fn} startingDirectory
# Finds `.git` directory above or at `startingDirectory`
# See: findFileHome
gitFindHome() {
  local usage="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$usage" "$@" || return 0
  __directoryParent "$usage" --pattern ".git" "$@"
}
_gitFindHome() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Usage: {fn} [ --last ] [ -- ] [ comment ... ]
# Argument: --last - Optional. Flag. Append last comment
# Argument: -- - Optional. Flag. Skip updating release notes with comment.
# Argument: --help - Optional. Flag. I need somebody.
# Argument: comment - Optional. Text. A text comment for release notes and describing in general terms, what was done for a commit message.
# Commits all files added to git and also update release notes with comment
#
# Comment wisely. Does not duplicate comments. Check your release notes.
#
# Example:     c last
# Example:     c --last
# Example:     c --
# Example:
# Example: ... are all equivalent.
gitCommit() {
  local usage="_${FUNCNAME[0]}"

  local appendLast=false updateReleaseNotes=true comment="" home="" openLinks=""
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
    --home)
      shift
      home=$(usageArgumentDirectory "$usage" "home" "${1-}") || return $?
      ;;
    --)
      updateReleaseNotes=false
      ;;
    --last)
      appendLast=true
      ;;
    --open-links)
      openLinks=true
      ;;
    *)
      comment="$*"
      break
      ;;
    esac
    shift
  done

  if ! isBoolean "$openLinks"; then
    openLinks=$(__catch "$usage" buildEnvironmentGet GIT_OPEN_LINKS) || return $?
  fi
  isBoolean "$openLinks" || openLinks=false

  if [ "$comment" = "last" ]; then
    appendLast=true
    comment=
  fi

  local start
  start="$(pwd -P 2>/dev/null)" || __throwEnvironment "$usage" "Failed to get pwd" || return $?
  if [ -z "$home" ]; then
    home=$(gitFindHome "$start") || __throwEnvironment "$usage" "Unable to find git home" || return $?
    buildEnvironmentContext gitCommit --home "$home" "${__saved[@]+"${__saved[@]}"}" || return $?
    return 0
  fi
  __catchEnvironment "$usage" cd "$home" || return $?
  gitRepositoryChanged || __throwEnvironment "$usage" "No changes to commit" || return $?
  local notes
  notes="$(releaseNotes)" || __throwEnvironment "$usage" "No releaseNotes?" || return $?
  if $updateReleaseNotes && [ -n "$comment" ]; then
    statusMessage decorate info "Updating release notes ..."
    __catch "$usage" __gitCommitReleaseNotesUpdate "$usage" "$notes" "$comment" || return $?
  elif [ -z "$comment" ]; then
    comment=$(__gitCommitReleaseNotesGetLastComment "$usage" "$notes") || return $?
    [ -z "$comment" ] || printf -- "%s %s:\n%s\n" "$(decorate info "Using last release note line from")" "$(decorate file "$notes")" "$(boxedHeading "$comment")"
  fi
  outputHandler="cat"
  ! $openLinks || outputHandler="urlOpener"
  if $appendLast || [ -z "$comment" ]; then
    statusMessage decorate info "Using last commit message ... ($(decorate subtle "$outputHandler"))"
    __catchEnvironment "$usage" git commit --reuse-message=HEAD --reset-author -a 2>&1 | "$outputHandler" || return $?
  else
    statusMessage decorate info "Using commit comment \"$comment\" ... ($(decorate subtle "$outputHandler"))"
    __catchEnvironment "$usage" git commit -a -m "$comment" 2>&1 | "$outputHandler" || return $?
  fi
  __catchEnvironment "$usage" cd "$start" || return $?
  return 0
}
__gitCommitReleaseNotesUpdate() {
  local usage="$1" notes="$2" comment="$3"
  local pattern

  home=$(__catch "$usage" buildHome) || return $?
  pattern="$(quoteGrepPattern "$comment")"
  __catchEnvironment "$usage" statusMessage --last printf -- "%s%s\n" "$(lineFill '.' "$(decorate label "Release notes") $(decorate file "$notes") $(decorate decoration --)")" "$(decorate reset --)" || return $?
  if ! grep -q -e "$pattern" "$notes"; then
    __catchEnvironment "$usage" printf -- "%s %s\n" "-" "$comment" >>"$notes" || return $?
    printf -- "%s %s:\n%s\n" "$(decorate info "Adding comment to")" "$(decorate file "$notes")" "$(boxedHeading "$comment")"
    __catchEnvironment "$usage" git add "$notes" || return $?
    __catchEnvironment "$usage" grep -B 10 -e "$pattern" "$notes" | decorate code || return $?
  else
    __catchEnvironment "$usage" statusMessage printf -- "%s %s:\n" "$(decorate info "Comment already added to")" "$(decorate code "$notes")" || return $?
    __catchEnvironment "$usage" grep -q -e "$pattern" "$notes" | decorate code || return $?
  fi
}
__gitCommitReleaseNotesGetLastComment() {
  local usage="$1" notes="$2"
  grep -e '^- ' "$notes" | tail -n 1 | cut -c 3-
}
_gitCommit() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: gitMainly
# Exit Code: 1 - Already in main, staging, or HEAD, or git merge failed
# Exit Code: 0 - git merge succeeded
# Merge `staging` and `main` branches of a git repository into the current branch.
#
# Will merge `origin/staging` and `origin/main` after doing a `--pull` for both of them
#
# Current repository should be clean and have no modified files.
#
gitMainly() {
  local usage="_${FUNCNAME[0]}"
  local argument
  local branch returnCode updateOther
  local verboseFlag remote="origin"
  local errorLog

  verboseFlag=false
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __throwArgument "$usage" "blank argument" || return $?
    case "$argument" in
    # _IDENTICAL_ --help 4
    --help)
      "$usage" 0
      return $?
      ;;
    --remote)
      shift
      remote=$(usageArgumentString "$usage" "$argument" "${1-}") || return $?
      ;;
    --verbose)
      verboseFlag=true
      ;;
    *)
      __throwArgument "$usage" "unknown argument: $(decorate value "$argument")" || return $?
      ;;
    esac
    shift || __throwArgument "$usage" "missing argument $(decorate label "$argument")" || return $?
  done

  errorLog=$(mktemp)
  branch=$(git rev-parse --abbrev-ref HEAD) || _environment "Git not present" || return $?
  case "$branch" in
  main | staging)
    __throwEnvironment "$usage" "Already in branch $(decorate code "$branch")" || return $?
    ;;
  HEAD)
    __throwEnvironment "$usage" "Ignore branches named $(decorate code "$branch")" || return $?
    ;;
  *)
    returnCode=0
    for updateOther in staging main; do
      ! $verboseFlag || decorate info git checkout "$updateOther"
      if ! git checkout "$updateOther" >"$errorLog" 2>&1; then
        printf -- "%s %s\n" "$(decorate error "Unable to checkout branch")" "$(decorate code "$updateOther")" 1>&2
        returnCode=1
        __catchEnvironment "$usage" git status -s || :
        break
      else
        ! $verboseFlag || decorate info git pull "# ($updateOther)"
        if ! __catchEnvironment "$usage" git pull "$remote" "$updateOther" >"$errorLog" 2>&1; then
          printf -- "%s %s\n" "$(decorate error "Unable to pull branch")" "$(decorate code "$updateOther")" 1>&2
          ! $verboseFlag || dumpPipe errors <"$errorLog"
          returnCode=1
          break
        fi
      fi
    done
    if [ "$returnCode" -ne 0 ]; then
      __catchEnvironment "$usage" git checkout -f "$branch" || :
      rm -rf "$errorLog"
      return "$returnCode"
    fi
    ! $verboseFlag || decorate info git checkout "$branch"
    if ! __catchEnvironment "$usage" git checkout "$branch" >"$errorLog" 2>&1; then
      printf -- "%s %s\n" "$(decorate error "Unable to switch BACK to branch")" "$(decorate code "$updateOther")" 1>&2
      rm -rf "$errorLog"
      return 1
    fi
    ! $verboseFlag || decorate info git merge -m
    __catchEnvironment "$usage" muzzle git merge -m "Merging staging and main with $branch" origin/staging origin/main || return $?
    if grep -q 'Already' "$errorLog"; then
      printf -- "%s %s\n" "$(decorate info "Already up to date")" "$(decorate code "$branch")"
    else
      printf -- "%s %s\n" "$(decorate info "Merged staging and main into branch")" "$(decorate code "$branch")"
    fi
    rm -rf "$errorLog"
    ;;
  esac
}
_gitMainly() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Get the commit hash
gitCommitHash() {
  local usage="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || __help --only "$usage" "$@" || return "$(convertValue $? 1 0)"
  __catchEnvironment "$usage" git rev-parse --short HEAD || return $?
}
_gitCommitHash() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Get the current branch name
#
gitCurrentBranch() {
  local usage="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || __help --only "$usage" "$@" || return "$(convertValue $? 1 0)"
  # git rev-parse --abbrev-ref HEAD
  __catchEnvironment "$usage" git symbolic-ref --short HEAD || return $?
}
_gitCurrentBranch() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Does git have any tags?
# May need to `git pull --tags`, or no tags exist.
gitHasAnyRefs() {
  local usage="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || __help --only "$usage" "$@" || return "$(convertValue $? 1 0)"
  local count

  count=$(__catchEnvironment "$usage" git show-ref | grep -c refs/tags) || return $?
  [ $((0 + count)) -gt 0 ]
}
_gitHasAnyRefs() {
  true || gitHasAnyRefs --help
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# List current valid git hook types
# Output: lines:gitHookType
# Hook types:
# - pre-commit
# - pre-push
# - pre-merge-commit
# - pre-rebase
# - pre-receive
# - update
# - post-update
# - post-commit
gitHookTypes() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  printf -- "%s " pre-commit pre-push pre-merge-commit pre-rebase pre-receive update post-update post-commit
}
_gitHookTypes() {
  true || gitHookTypes --help
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Install one or more git hooks from Zesk Build hooks.
# Zesk Build hooks are named `git-hookName.sh` in `bin/hooks/` so `git-pre-commit.sh` will be installed as the `pre-commit` hook for git.
#
# Argument: --copy - Flag. Optional. Copy the hook but do not execute it.
# Argument: --verbose - Flag. Optional. Be verbose about what is done.
# Argument: --application home - Directory. Optional. Set the application home directory to this prior to looking for hooks.
# Argument: hookName - String. Optional. A hook or hook names to install. See `gitHookTypes`
# Hook types:
# - pre-commit
# - pre-push
# - pre-merge-commit
# - pre-rebase
# - pre-receive
# - update
# - post-update
# - post-commit
# See: gitHookTypes
gitInstallHooks() {
  local hook
  local argument
  local usage="_${FUNCNAME[0]}"
  local types home

  home=$(__catch "$usage" buildHome) || return $?

  local verbose=false hookNames=()

  read -r -a types < <(gitHookTypes) || :
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
    --copy)
      execute=false
      ;;
    --verbose)
      verbose=true
      ;;
    --application)
      shift || __throwArgument "$usage" "missing $argument argument" || return $?
      home=$(usageArgumentDirectory "$usage" "applicationHome" "$1") || return $?
      ;;
    *)
      hook="$argument"
      if inArray "$hook" "${types[@]}"; then
        hookNames+=("$hook")
      else
        __throwArgument "$usage" "Unknown hook:" "$argument" "Allowed:" "${types[@]}" || return $?
      fi
      ;;
    esac
    shift
  done
  if [ ${#hookNames[@]} -eq 0 ]; then
    hookNames=("${types[@]}")
  fi
  for hook in "${hookNames[@]}"; do
    if hasHook --application "$home" "git-$hook"; then
      __catchEnvironment "$usage" gitInstallHook --application "$home" --copy "$hook" || return $?
      ! $verbose || decorate success "Installed $(decorate value "$hook")" || :
    fi
  done
}
_gitInstallHooks() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: {fn} [ --application applicationHome ] [ --copy ] hook
# Argument: hook - A hook to install. Maps to `git-hook` internally. Will be executed in-place if it has changed from the original.
# Argument: --application - Optional. Directory. Path to application home.
# Install the most recent version of this hook and RUN IT in place if it has changed.
# Argument: --copy - Optional. Flag. Do not execute the hook if it has changed.
# You should ONLY run this from within your hook, or provide the `--copy` flag to just copy.
# When running within your hook, pass additional arguments so they can be preserved:
#
#     gitInstallHook --application "$myHome" pre-commit "$@" || return $?
#
# Exit code: 0 - the file was not updated
# Exit code: 1 - Environment error
# Exit code: 2 - Argument error
# Environment: BUILD-HOME - The default application home directory used for `.git` and build hooks.
gitInstallHook() {
  local argument fromTo relFromTo item home execute verbose
  local usage="_${FUNCNAME[0]}"
  local types

  read -r -a types < <(gitHookTypes) || :
  home=$(__catch "$usage" buildHome) || return $?
  execute=true
  verbose=false
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __throwArgument "$usage" "blank argument" || return $?
    case "$argument" in
    --copy)
      execute=false
      ;;
    --verbose)
      verbose=true
      ;;
    # _IDENTICAL_ --help 4
    --help)
      "$usage" 0
      return $?
      ;;
    --application)
      shift || __throwArgument "$usage" "missing $argument argument" || return $?
      home=$(usageArgumentDirectory "$usage" "applicationHome" "$1") || return $?
      ;;
    *)
      if inArray "$argument" "${types[@]}"; then
        hasHook --application "$home" "git-$argument" || __throwArgument "$usage" "Hook git-$argument does not exist (Home: $home)" || return $?
        fromTo=("$(whichHook --application "$home" "git-$argument")" "$home/.git/hooks/$argument") || __throwEnvironment "$usage" "Unable to whichHook git-$argument (Home: $home)" || rewturn $?
        relFromTo=()
        home="${home%/}/"
        for item in "${fromTo[@]}"; do
          item="${item#"$home"}"
          relFromTo+=("./$item")
        done
        if [ -f "${fromTo[1]}" ]; then
          if diff -q "${fromTo[@]}" >/dev/null; then
            ! $verbose || decorate pair 15 "No changes:" "${relFromTo[@]}"
            return 0
          fi
          ! $verbose || decorate pair 15 "Changed:" "${relFromTo[@]}"
        else
          ! $verbose || decorate pair 15 "Installing" "${relFromTo[1]}"
        fi
        statusMessage --last printf "%s %s -> %s\n" "$(decorate success "git hook:")" "$(decorate warning "${relFromTo[0]}")" "$(decorate code "${relFromTo[1]}")" || :
        __catchEnvironment "$usage" cp -f "${fromTo[@]}" || return $?
        ! $execute || __catchEnvironment "$usage" exec "${fromTo[1]}" "$@" || return $?
        return 0
      else
        __throwArgument "$usage" "Unknown hook:" "$argument" "Allowed:" "${types[@]}" || return $?
      fi
      ;;
    esac
    shift
  done
}
_gitInstallHook() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__gitPreCommitCache() {
  local directory create="${1-}" name
  name="pre-commit.$(whoami)" || _environment whoami || return $?
  directory=$(buildCacheDirectory "$name") || _environment buildCacheDirectory "$name" || return $?
  [ "$create" != "true" ] || [ -d "$directory" ] || __environment mkdir -p "$directory" || return $?
  printf "%s\n" "$directory"
}

# Set up a pre-commit hook
gitPreCommitSetup() {
  local usage="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$usage" "$@" || return 0

  local directory total=0

  directory=$(__catch "$usage" __gitPreCommitCache true) || return $?
  __catchEnvironment "$usage" git diff --name-only --cached --diff-filter=ACMR | __catchEnvironment "$usage" extensionLists --clean "$directory" || return $?
  total=$(__catch "$usage" fileLineCount "$directory/@") || return $?
  [ "$total" -ge 0 ]
}
_gitPreCommitSetup() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Output a display for pre-commit files changed
gitPreCommitHeader() {
  local usage="_${FUNCNAME[0]}" width=5
  [ "${1-}" != "--help" ] || __help "$usage" "$@" || return 0

  local directory total color

  directory=$(__catch "$usage" __gitPreCommitCache true) || return $?
  [ -f "$directory/@" ] || __throwEnvironment "$usage" "$directory/@ missing" || return $?
  total=$(__catch "$usage" fileLineCount "$directory/@") || return $?
  statusMessage --last printf -- "%s: %s\n" "$(decorate success "$(alignRight "$width" "all")")" "$(decorate info "$total $(plural "$total" file files) changed")"
  while [ $# -gt 0 ]; do
    total=0
    color="warning"
    if [ -f "$directory/$1" ]; then
      total=$(__catch "$usage" fileLineCount "$directory/$1") || return $?
      color="success"
    fi
    # shellcheck disable=SC2015
    printf "%s: %s\n" "$(decorate "$color" "$(alignRight "$width" "$1")")" "$(decorate info "$total $(plural "$total" file files) changed")"
    shift
  done
}
_gitPreCommitHeader() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Does this commit have the following file extensions?
gitPreCommitHasExtension() {
  local usage="_${FUNCNAME[0]}"
  local directory
  directory=$(__catch "$usage" __gitPreCommitCache true) || return $?
  while [ $# -gt 0 ]; do
    [ "${1-}" != "--help" ] || __help "$usage" "$@" || return 0
    [ -f "$directory/$1" ] || return 1
    shift
  done
}
_gitPreCommitHasExtension() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# List the file(s) of an extension
gitPreCommitListExtension() {
  local usage="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$usage" "$@" || return 0
  local directory
  directory=$(__catch "$usage" __gitPreCommitCache true) || return $?
  while [ $# -gt 0 ]; do
    [ -f "$directory/$1" ] || __throwEnvironment "$usage" "No files with extension $1" || return $?
    __catchEnvironment "$usage" cat "$directory/$1" || return $?
    shift
  done | sort
}
_gitPreCommitListExtension() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Clean up after our pre-commit (deletes cache directory)
gitPreCommitCleanup() {
  local usage="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || __help --only "$usage" "$@" || return "$(convertValue $? 1 0)"
  local directory
  directory=$(__catch "$usage" __gitPreCommitCache) || return $?
  [ ! -d "$directory" ] || __catchEnvironment "$usage" rm -rf "$directory" || return $?
}
_gitPreCommitCleanup() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Does a branch exist locally or remotely?
# Usage: {fn} branch ...
# Argument: branch ... - String. Required. List of branch names to check.
# Exit Code: 0 - All branches passed exist
# Exit Code: 1 - At least one branch does not exist locally or remotely
gitBranchExists() {
  local usage="_${FUNCNAME[0]}"

  [ $# -gt 0 ] || __throwArgument "$usage" "Requires at least one branch name" || return $?
  while [ $# -gt 0 ]; do
    [ "${1-}" != "--help" ] || __help "$usage" "$@" || return 0
    if ! gitBranchExistsLocal "$1" && ! gitBranchExistsRemote "$1"; then
      return 1
    fi
    shift
  done
}
_gitBranchExists() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Does a branch exist locally?
# Usage: {fn} branch ...
# Argument: branch ... - String. Required. List of branch names to check.
# Exit Code: 0 - All branches passed exist
# Exit Code: 1 - At least one branch does not exist locally
gitBranchExistsLocal() {
  local usage="_${FUNCNAME[0]}"
  local branch

  [ $# -gt 0 ] || __throwArgument "$usage" "Requires at least one branch name" || return $?
  while [ $# -gt 0 ]; do
    [ "${1-}" != "--help" ] || __help "$usage" "$@" || return 0
    branch=$(__catchEnvironment "$usage" git branch --list "$1") || return $?
    [ -n "$branch" ] || return 1
    shift
  done
}
_gitBranchExistsLocal() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Does a branch exist remotely?
# Usage: {fn} branch ...
# Argument: branch ... - String. Required. List of branch names to check.
# Exit Code: 0 - All branches passed exist
# Exit Code: 1 - At least one branch does not exist remotely
gitBranchExistsRemote() {
  local usage="_${FUNCNAME[0]}"
  local branch

  export GIT_REMOTE

  __catch "$usage" buildEnvironmentLoad GIT_REMOTE || return $?
  [ -n "$GIT_REMOTE" ] || __catchEnvironment "$usage" "GIT_REMOTE requires a value" || return $?

  [ $# -gt 0 ] || __throwArgument "$usage" "Requires at least one branch name" || return $?
  while [ $# -gt 0 ]; do
    [ "${1-}" != "--help" ] || __help "$usage" "$@" || return 0
    branch=$(__catchEnvironment "$usage" git ls-remote --heads "$GIT_REMOTE" "$1") || return $?
    [ -n "$branch" ] || return 1
    shift
  done
}
_gitBranchExistsRemote() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Check out a branch with the current version and optional formatting
#
# `BUILD_BRANCH_FORMAT` is a string which can contain tokens in the form `{user}` and `{version}`
#
# The default value is `{version}-{user}`
#
# Environment: BUILD_BRANCH_FORMAT
#
gitBranchify() {
  local usage="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$usage" "$@" || return 0
  local version user format branchName currentBranch

  export GIT_BRANCH_FORMAT GIT_REMOTE

  usageRequireBinary "$usage" whoami || return $?
  __catch "$usage" buildEnvironmentLoad GIT_BRANCH_FORMAT GIT_REMOTE || return $?
  [ -n "$GIT_REMOTE" ] || __catchEnvironment "$usage" "GIT_REMOTE requires a value" || return $?

  version=$(__catchEnvironment "$usage" hookVersionCurrent) || return $?
  user=$(__catchEnvironment "$usage" whoami) || return $?

  format="${BUILD_BRANCH_FORMAT-}"
  [ -n "$format" ] || format="{version}-{user}"
  branchName="$(version=$version user=$user mapEnvironment < <(printf "%s\n" "$format"))"
  [ -n "$branchName" ] || __throwEnvironment "$usage" "BUILD_BRANCH_FORMAT=\"$BUILD_BRANCH_FORMAT\" -> \"$format\" made blank branch (user=$user version=$version)" || return $?

  if gitBranchExists "$branchName"; then
    currentBranch=$(__catchEnvironment "$usage" gitCurrentBranch) || return $?
    if [ "$currentBranch" != "$branchName" ]; then
      if ! muzzle git checkout "$branchName" 2>&1; then
        __throwEnvironment "$usage" "Local changes in $(decorate value "$currentBranch") prevent switching to $(decorate code "$branchName") due to local changes" || return $?
      fi
      decorate success "Switched to $(decorate code "$branchName")"
    else
      decorate success "Branch is $(decorate code "$branchName")"
    fi
  else
    __catchEnvironment "$usage" git checkout -b "$branchName" || return $?
    __catchEnvironment "$usage" git push -u "$GIT_REMOTE" "$branchName" || return $?
    printf "%s %s %s%s%s\n" "$(decorate success "Branch is")" "$(decorate code "$branchName")" "$(decorate info "(pushed to ")" "$(decorate value "$GIT_REMOTE")" "$(decorate info ")")"
  fi

}
_gitBranchify() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Merge the current branch with another, push to remote, and then return to the original branch.
# Argument: branch - String. Required. Branch to merge the current branch with.
# Argument: --skip-ip - Boolean. Optional. Do not add the IP address to the comment.
# Argument: --comment - String. Optional. Comment for merge commit.
gitBranchMergeCurrent() {
  local usage="_${FUNCNAME[0]}"

  local targetBranch="" comment="" addIP=true

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
    --skip-ip)
      addIP=false
      ;;
    --comment)
      shift
      comment=$(usageArgumentString "$usage" "$argument" "${1-}") || return $?
      ;;
    *)
      targetBranch="$(usageArgumentString "$usage" "$argument" "$1")" || return $?
      ;;
    esac
    shift
  done

  [ -n "$targetBranch" ] || __throwArgument "$usage" "branch required" || return $?
  if [ -z "$comment" ]; then
    comment="${FUNCNAME[0]} by $(whoami) on $(hostname)"
  fi
  if $addIP; then
    comment="$comment @ $(ipLookup || printf "%s" "$? <- ipLookup failed")" 2>/dev/null
  fi
  local currentBranch
  currentBranch=$(__catchEnvironment "$usage" gitCurrentBranch) || return $?
  if [ "$currentBranch" = "$targetBranch" ]; then
    __throwEnvironment "$usage" "Already on $(decorate code "$targetBranch") branch" || return $?
  fi
  __catchEnvironment "$usage" git checkout "$targetBranch" || return $?
  __catchEnvironment "$usage" git merge -m "$comment" "$branch" || returnUndo $? git checkout --force "$branch" || return $?
  __catchEnvironment "$usage" git push || returnUndo $? git checkout --force "$branch" || return $?
  __catchEnvironment "$usage" git checkout "$branch" || return $?
}
_gitBranchMergeCurrent() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# ----------------------------------------------------------------------------------------------------
# ----------------------------------------------------------------------------------------------------
# ----------------------------------------------------------------------------------------------------
#
# Various git environment samples from codebase

# GIT_AUTHOR_DATE=@1702851863 +0000
# GIT_AUTHOR_EMAIL=dude@example.com
# GIT_AUTHOR_NAME=root
# GIT_EDITOR=:
# GIT_EXEC_PATH=/usr/lib/git-core
# GIT_INDEX_FILE=/opt/atlassian/bitbucketci/agent/build/.git/index.lock
# GIT_PREFIX=

#
# HomeBrew
#
# GIT_ASKPASS=/Applications/Visual Studio Code.app/Contents/Resources/app/extensions/git/dist/askpass.sh
# GIT_AUTHOR_DATE=@1702851303 -0500
# GIT_AUTHOR_EMAIL=dude@example.com
# GIT_AUTHOR_NAME=The Dude
# GIT_EDITOR=:
# GIT_EXEC_PATH=/usr/local/Cellar/git/2.28.0/libexec/git-core
# GIT_INDEX_FILE=/Users/dude/marketacumen/build/.git/index.lock
# GIT_PREFIX=
# GIT_REFLOG_ACTION=pull
