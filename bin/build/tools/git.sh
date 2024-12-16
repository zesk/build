#!/usr/bin/env bash
#
# git tools, lame attempts have been made to have each function start with `git`.
#
# Copyright &copy; 2024 Market Acumen, Inc.
# bin: git
#
# Docs: ./docs/_templates/tools/git.md
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
  packageWhich git git "$@"
}

#
# Uninstalls the `git` binary
# Usage: {fn} [ package ... ]
# Argument: package - Additional packages to uninstall
# Summary: Uninstall git
#
gitUninstall() {
  packageWhichUninstall git git "$@"
}

#
# When running git operations on a deployment host, at times it's necessary to
# add the current directory (or a directory) to the git `safe.directory` directive.
#
# This adds the directory passed to that directory in the local user's environment
#
# Usage: gitEnsureSafeDirectory [ directory ... ]
# Argument: directory - Required. Directory. The directory to add to the `git` `safe.directory` configuration directive
# Exit Code: 0 - Success
# Exit Code: 2 - Argument is not a valid directory
# Exit Code: Other - git config error codes
#
gitEnsureSafeDirectory() {
  local usage="_${FUNCNAME[0]}"
  while [ $# -gt 0 ]; do
    [ -d "$1" ] || __failArgument "$usage" "$1 is not a directory" || return $?
    if ! git config --global --get safe.directory | grep -q "$1"; then
      __usageEnvironment "$usage" git config --global --add safe.directory "$1" || return $?
    fi
    shift
  done
}
_gitEnsureSafeDirectory() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Delete git tag locally and at origin
#
# Usage: gitTagDelete [ tag ... ]
# Argument: tag - The tag to delete locally and at origin
# Exit Code: argument - Any stage fails will result in this exit code. Partial deletion may occur.
#
gitTagDelete() {
  local usage="_${FUNCNAME[0]}"
  local exitCode=0
  export GIT_REMOTE

  __usageEnvironment "$usage" buildEnvironmentLoad GIT_REMOTE || return $?
  usageRequireEnvironment "$usage" GIT_REMOTE || return $?
  while [ $# -gt 0 ]; do
    # Deleting local tag
    __usageArgument "$usage" git tag -d "$1" || exitCode=$?
    # Deleting remote tag
    __usageArgument "$usage" git push "$GIT_REMOTE" :"$1" || exitCode=$?
    shift
  done
  return "$exitCode"
}
_gitTagDelete() {
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
  [ $# -eq 0 ] || __failArgument "$usage" "No arguments" || return $?
  while [ $# -gt 0 ]; do
    statusMessage decorate info "Deleting tag $1 ..."
    __usageArgument "$usage" gitTagDelete "$1" || return $?
    statusMessage decorate info "Tagging again $1 ..."
    __usageArgument "$usage" git tag "$1" || return $?
    __usageArgument "$usage" git push --tags || return $?
  done
  statusMessage --last decorate info "All tags completed" "$(decorate orange "${a[@]}")"
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
  [ -d "./.git" ] || __failEnvironment "$usage" "No .git directory at $(pwd), stopping" || return $?
  __usageEnvironment "$usage" git tag | grep -e '^v[0-9.]*$' | versionSort "$@"
}
_gitVersionList() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Get the last reported version.
# Usage: gitVersionLast [ ignorePattern ]
# Argument: ignorePattern - Optional. Specify a grep pattern to ignore; allows you to ignore current version
gitVersionLast() {
  local skip
  if [ -n "${1-}" ]; then
    skip="$1"
    shift
    gitVersionList "$@" | grep -v "$skip" | tail -1
  else
    gitVersionList "$@" | tail -1
  fi
}

#
# Given a tag in the form "1.1.3" convert it to "v1.1.3" so it has a character prefix "v"
# Delete the old tag as well
#
veeGitTag() {
  local usage="_${FUNCNAME[0]}"
  local tagName="$1"

  [ "$tagName" = "${tagName#v}" ] || __failArgument "$usage" "already v'd': $(decorate value "$tagName")" || return $?
  __usageEnvironment "$usage" git tag "v$tagName" "$tagName" || return $?
  __usageEnvironment "$usage" git tag -d "$tagName" || return $?
  __usageEnvironment "$usage" git push origin "v$tagName" ":$tagName" || return $?
  __usageEnvironment "$usage" git fetch -q --prune --prune-tags || return $?
}
_veeGitTag() {
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
  git filter-branch --index-filter "git rm -rf --cached --ignore-unmatch $1" HEAD
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
  ! git diff-index --quiet HEAD 2>/dev/null
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
  git diff-index --name-only HEAD
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
  git diff-index --name-status "$@" HEAD
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
  [ -n "${GIT_EXEC_PATH-}" ] && [ -n "${GIT_INDEX_FILE-}" ]
}

#
# List remote hosts for the current git repository
# Parses `user@host:path/project.git` and extracts `host`
#
gitRemoteHosts() {
  local remoteUrl host
  while read -r remoteUrl; do
    host=$(urlParseItem host "$remoteUrl") || host=$(urlParseItem host "git://$remoteUrl") || __failArgument "$usage" "Unable to extract host from \"$remoteUrl\"" || return $?
    printf -- "%s\n" "$host"
  done < <(git remote -v | awk '{ print $2 }')
}
_gitRemoteHosts() {
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
  local versionSuffix start currentVersion previousVersion releaseNotes
  local argument tagPrefix index tryVersion maximumTagsPerVersion
  local usage

  usage="_${FUNCNAME[0]}"

  __usageEnvironment "$usage" buildEnvironmentLoad BUILD_MAXIMUM_TAGS_PER_VERSION || return $?

  maximumTagsPerVersion="$BUILD_MAXIMUM_TAGS_PER_VERSION"
  init=$(beginTiming) || __failEnvironment beginTiming || return $?

  start=$(beginTiming) || __failEnvironment beginTiming || return $?
  versionSuffix=
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __failArgument "$usage" "blank argument" || return $?
    case "$argument" in
      --suffix)
        shift || __failArgument "$usage" "missing $argument argument" || return $?
        versionSuffix="${1-}"
        [ -n "$versionSuffix" ] || __failArgument "$usage" "Blank $argument argument" || return $?
        ;;
      *)
        __failArgument "$usage" "unknown argument: $argument" || return $?
        ;;
    esac
    shift || __failArgument "$usage" "shift $argument" || return $?
  done

  statusMessage decorate info "Pulling tags from origin "
  git pull --tags origin >/dev/null || __failEnvironment "$usage" "Pulling tags failed" || return $?
  reportTiming "$start" || :

  currentVersion=$(runHook version-current) || __failEnvironment "$usage" "runHook version-current" || return $?
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

  releaseNotes="$(releaseNotes "$currentVersion")" || __failEnvironment "$usage" "releaseNotes $currentVersion failed" || return $?

  if [ ! -f "$releaseNotes" ]; then
    decorate error "Version $currentVersion no release notes \"$releaseNotes\" found, stopping." 1>&2
    return 18
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
      decorate error "Tag version exceeded maximum of $maximumTagsPerVersion" 1>&2
      return 19
    fi
  done

  decorate info "Tagging version $tryVersion and pushing ... " || :
  if ! git tag "$tryVersion"; then
    decorate error "Failed to tag $tryVersion"
    return 20
  fi
  if ! git push --tags --quiet; then
    decorate error "git push --tags failed"
    return 21
  fi
  if ! git fetch -q; then
    decorate error "git fetch failed"
    return 22
  fi

  reportTiming "$init" "Tagged version completed in" || :
}
_gitTagVersion() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: {fn} startingDirectory
# Finds `.git` directory above or at `startingDirectory`
# See: findFileHome
gitFindHome() {
  __directoryParent "_${FUNCNAME[0]}" --pattern ".git" "$@"
}
_gitFindHome() {
  # IDENTICAL usageDocument 1
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
  local saved=("$@") nArguments=$#
  while [ $# -gt 0 ]; do
    local argument argumentIndex=$((nArguments - $# + 1))
    argument="$(usageArgumentString "$usage" "argument #$argumentIndex (Arguments: $(_command "${usage#_}" "${saved[@]}"))" "$1")" || return $?
    case "$argument" in
      # IDENTICAL --help 4
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
    openLinks=$(__usageEnvironment "$usage" buildEnvironmentGet GIT_OPEN_LINKS) || return $?
  fi
  isBoolean "$openLinks" || openLinks=false

  if [ "$comment" = "last" ]; then
    appendLast=true
    comment=
  fi

  local start
  start="$(pwd -P 2>/dev/null)" || __failEnvironment "$usage" "Failed to get pwd" || return $?
  if [ -z "$home" ]; then
    home=$(gitFindHome "$start") || __failEnvironment "$usage" "Unable to find git home" || return $?
    buildEnvironmentContext gitCommit --home "$home" "${saved[@]}" || return $?
    return 0
  fi
  __usageEnvironment "$usage" cd "$home" || return $?
  gitRepositoryChanged || __failEnvironment "$usage" "No changes to commit" || return $?
  if $updateReleaseNotes && [ -n "$comment" ]; then
    local notes
    statusMessage decorate info "Updating release notes ..."
    notes="$(releaseNotes)" || __failEnvironment "$usage" "No releaseNotes?" || return $?
    __usageEnvironment "$usage" __gitCommitReleaseNotesUpdate "$comment" "$notes" || return $?
  fi
  outputHandler="cat"
  ! $openLinks || outputHandler="urlOpener"
  if $appendLast || [ -z "$comment" ]; then
    statusMessage decorate info "Using last commit message ... ($(decorate subtle "$outputHandler"))"
    __usageEnvironment "$usage" git commit --reuse-message=HEAD --reset-author -a 2>&1 | "$outputHandler" || return $?
  else
    statusMessage decorate info "Using commit comment \"$comment\" ... ($(decorate subtle "$outputHandler"))"
    __usageEnvironment "$usage" git commit -a -m "$comment" 2>&1 | "$outputHandler" || return $?
  fi
  __usageEnvironment "$usage" cd "$start" || return $?
  return 0
}
__gitCommitReleaseNotesUpdate() {
  local usage="_gitCommit"
  local comment="$1" notes="$2" pattern displayNotes

  home=$(__usageEnvironment "$usage" buildHome)
  displayNotes="${notes#"$home"/}"
  pattern="$(quoteGrepPattern "$comment")"
  __usageEnvironment "$usage" statusMessage --last printf -- "%s%s\n" "$(lineFill '.' "$(decorate label "Release notes") $(decorate value "$displayNotes") $(decorate decoration)")" "$(decorate reset)" || return $?
  if ! grep -q -e "$pattern" "$notes"; then
    __usageEnvironment "$usage" printf -- "%s %s\n" "-" "$comment" >>"$notes" || return $?
    __usageEnvironment "$usage" printf -- "%s to %s:\n%s\n" "$(decorate info "Adding comment")" "$(decorate code "$displayNotes")" "$(boxedHeading "$comment")" || return $?
    __usageEnvironment "$usage" git add "$notes" || return $?
    __usageEnvironment "$usage" grep -B 10 -e "$pattern" "$notes" | wrapLines "$(decorate code)" "$(decorate reset)" || return $?
  else
    __usageEnvironment "$usage" statusMessage printf -- "%s %s:\n" "$(decorate info "Comment already added to")" "$(decorate code "$notes")" || return $?
    __usageEnvironment "$usage" grep -q -e "$pattern" "$notes" | wrapLines "$(decorate code)" "$(decorate reset)" || return $?
  fi
}
_gitCommit() {
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
  local verboseFlag
  local errorLog

  verboseFlag=false
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __failArgument "$usage" "blank argument" || return $?
    case "$argument" in
      # IDENTICAL --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --verbose)
        verboseFlag=true
        ;;
      *)
        __failArgument "$usage" "unknown argument: $(decorate value "$argument")" || return $?
        ;;
    esac
    shift || __failArgument "$usage" "missing argument $(decorate label "$argument")" || return $?
  done

  errorLog=$(mktemp)
  branch=$(git rev-parse --abbrev-ref HEAD) || _environment "Git not present" || return $?
  case "$branch" in
    main | staging)
      __failEnvironment "$usage" "Already in branch $(decorate code "$branch")" || return $?
      ;;
    HEAD)
      __failEnvironment "$usage" "Ignore branches named $(decorate code "$branch")" || return $?
      ;;
    *)
      returnCode=0
      for updateOther in staging main; do
        ! $verboseFlag || decorate info git checkout "$updateOther"
        if ! git checkout "$updateOther" >"$errorLog" 2>&1; then
          printf -- "%s %s\n" "$(decorate error "Unable to checkout branch")" "$(decorate code "$updateOther")" 1>&2
          returnCode=1
          __environment git status -s || :
          break
        else
          ! $verboseFlag || decorate info git pull "# ($updateOther)"
          if ! __environment git pull >"$errorLog" 2>&1; then
            returnCode=1
            break
          fi
        fi
      done
      if [ "$returnCode" -ne 0 ]; then
        __environment git checkout -f "$branch" || :
        return "$returnCode"
      fi
      ! $verboseFlag || decorate info git checkout "$branch"
      if ! __environment git checkout "$branch" >"$errorLog" 2>&1; then
        printf -- "%s %s\n" "$(decorate error "Unable to switch BACK to branch")" "$(decorate code "$updateOther")" 1>&2
        rm -rf "$errorLog"
        return 1
      fi
      ! $verboseFlag || decorate info git merge -m
      __environment git merge -m "Merging staging and main with $branch" origin/staging origin/main || return $?
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
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Get the commit hash
gitCommitHash() {
  local usage="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || __failArgument "$usage" "No arguments allowed" || return $?
  __usageEnvironment "$usage" git rev-parse --short HEAD || return $?
}
_gitCommitHash() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Get the current branch name
#
gitCurrentBranch() {
  local usage="_${FUNCNAME[0]}"

  # git rev-parse --abbrev-ref HEAD
  __usageEnvironment "$usage" git symbolic-ref --short HEAD || return $?
}
_gitCurrentBranch() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Does git have any tags?
# May need to `git pull --tags`, or no tags exist.
gitHasAnyRefs() {
  local usage="_${FUNCNAME[0]}"
  local count

  count=$(__usageEnvironment "$usage" git show-ref | grep -c refs/tags) || return $?
  [ $((0 + count)) -gt 0 ]
}
_gitHasAnyRefs() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# ----------------------------------------------------------------------------------------------------
# ----------------------------------------------------------------------------------------------------
# ----------------------------------------------------------------------------------------------------
#
# Various git environment samples from codebase

# GIT_AUTHOR_DATE=@1702851863 +0000
# GIT_AUTHOR_EMAIL=kent@example.com
# GIT_AUTHOR_NAME=root
# GIT_EDITOR=:
# GIT_EXEC_PATH=/usr/lib/git-core
# GIT_INDEX_FILE=/opt/atlassian/bitbucketci/agent/build/.git/index.lock
# GIT_PREFIX=
gitHookTypes() {
  printf -- "%s " pre-commit pre-push pre-merge-commit pre-rebase pre-receive update post-update post-commit
}

#
# HomeBrew
#
# GIT_ASKPASS=/Applications/Visual Studio Code.app/Contents/Resources/app/extensions/git/dist/askpass.sh
# GIT_AUTHOR_DATE=@1702851303 -0500
# GIT_AUTHOR_EMAIL=kent@example.com
# GIT_AUTHOR_NAME=Kent Davidson
# GIT_EDITOR=:
# GIT_EXEC_PATH=/usr/local/Cellar/git/2.28.0/libexec/git-core
# GIT_INDEX_FILE=/Users/kent/marketacumen/build/.git/index.lock
# GIT_PREFIX=
# GIT_REFLOG_ACTION=pull

gitInstallHooks() {
  local hook
  local argument
  local usage="_${FUNCNAME[0]}"
  local types didOne home

  home=$(__usageEnvironment "$usage" buildHome) || return $?
  verbose=false
  didOne=false
  read -r -a types < <(gitHookTypes) || :
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __failArgument "$usage" "blank argument" || return $?
    case "$argument" in
      --copy)
        execute=false
        ;;
      --verbose)
        verbose=true
        ;;
      # IDENTICAL --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --application)
        shift || __failArgument "$usage" "missing $argument argument" || return $?
        home=$(usageArgumentDirectory "$usage" "applicationHome" "$1") || return $?
        ;;
      *)
        hook="$argument"
        if inArray "$hook" "${types[@]}"; then
          __usageEnvironment "$usage" gitInstallHook --application "$home" --copy "$hook" || return $?
          ! $verbose || decorate success "Installed $(decorate value "$hook")" || :
          didOne=true
        else
          __failArgument "$usage" "Unknown hook:" "$argument" "Allowed:" "${types[@]}" || return $?
        fi
        ;;
    esac
    shift || :
  done
  if ! $didOne; then
    for hook in pre-commit pre-push pre-merge-commit pre-rebase pre-receive update post-update post-commit; do
      if hasHook --application "$home" "git-$hook"; then
        __usageEnvironment "$usage" gitInstallHook --application "$home" --copy "$hook" || return $?
        ! $verbose || decorate success "Installed $(decorate value "$hook")" || :
      fi
    done
  fi
}
_gitInstallHooks() {
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
# Exit code: 3 - `--copy` - the file was changed
# Environment: BUILD-HOME - The default application home directory used for `.git` and build hooks.
gitInstallHook() {
  local argument fromTo relFromTo item home execute verbose
  local usage="_${FUNCNAME[0]}"
  local types

  read -r -a types < <(gitHookTypes) || :
  home=$(__usageEnvironment "$usage" buildHome) || return $?
  execute=true
  verbose=false
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __failArgument "$usage" "blank argument" || return $?
    case "$argument" in
      --copy)
        execute=false
        ;;
      --verbose)
        verbose=true
        ;;
      # IDENTICAL --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --application)
        shift || __failArgument "$usage" "missing $argument argument" || return $?
        home=$(usageArgumentDirectory "$usage" "applicationHome" "$1") || return $?
        ;;
      *)
        if inArray "$argument" "${types[@]}"; then
          hasHook --application "$home" "git-$argument" || __failArgument "$usage" "Hook git-$argument does not exist (Home: $home)" || return $?
          fromTo=("$(whichHook --application "$home" "git-$argument")" "$home/.git/hooks/$argument") || __failEnvironment "$usage" "Unable to whichHook git-$argument (Home: $home)" || rewturn $?
          relFromTo=()
          for item in "${fromTo[@]}"; do
            relFromTo+=("./${item#"$home"}")
          done
          if [ -f "${fromTo[1]}" ]; then
            if diff -q "${fromTo[@]}" >/dev/null; then
              ! $verbose || consoleNameValue 5 "No changes:" "$(_list "" "${relFromTo[@]}")" || :
              return 0
            fi
            ! $verbose || consoleNameValue 5 "Changed:" "$(_list "" "${relFromTo[@]}")" || :
          else
            ! $verbose || consoleNameValue 5 "Installing" "${relFromTo[1]}" || :
          fi
          statusMessage --last printf "%s %s -> %s\n" "$(decorate success "git hook:")" "$(decorate warning "${relFromTo[0]}")" "$(decorate code "${relFromTo[1]}")" || :
          __usageEnvironment "$usage" cp -f "${fromTo[@]}" || return $?
          ! $execute || __usageEnvironment "$usage" exec "${fromTo[1]}" "$@" || return $?
          return 3
        else
          __failArgument "$usage" "Unknown hook:" "$argument" "Allowed:" "${types[@]}" || return $?
        fi
        ;;
    esac
    shift || :
  done
}
_gitInstallHook() {
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
  local directory total=0

  directory=$(__gitPreCommitCache true) || return $?
  __usageEnvironment "$usage" git diff --name-only --cached --diff-filter=ACMR | __usageEnvironment "$usage" extensionLists --clean "$directory" || return $?
  total=$(($(wc -l <"$directory/@") + 0)) || __failEnvironment "$usage" "wc -l" || return $?
  [ $total -ne 0 ]
}
_gitPreCommitSetup() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Output a display for pre-commit files changed
gitPreCommitHeader() {
  local usage="_${FUNCNAME[0]}" width=5
  local directory total color

  directory=$(__gitPreCommitCache true) || return $?

  total=$(($(wc -l <"$directory/@") + 0)) || __failEnvironment "$usage" "wc -l" || return $?
  statusMessage --last printf -- "%s: %s\n" "$(decorate success "$(alignRight "$width" "all")")" "$(decorate info "$total $(plural "$total" file files) changed")"
  while [ $# -gt 0 ]; do
    total=0
    color="warning"
    if [ -f "$directory/$1" ]; then
      total=$(($(wc -l <"$directory/$1") + 0))
      color="success"
    fi
    # shellcheck disable=SC2015
    printf "%s: %s\n" "$(decorate "$color" "$(alignRight "$width" "$1")")" "$(decorate info "$total $(plural "$total" file files) changed")"
    shift
  done
}

# Does this commit have the following file extensions?
gitPreCommitHasExtension() {
  local directory
  directory=$(__gitPreCommitCache true) || return $?
  while [ $# -gt 0 ]; do
    [ -f "$directory/$1" ] || return 1
    shift
  done
}

# List the file(s) of an extension
gitPreCommitListExtension() {
  local directory
  directory=$(__gitPreCommitCache true) || return $?
  while [ $# -gt 0 ]; do
    [ -f "$directory/$1" ] || _environment "No files with extension $1" || return $?
    cat "$directory/$1" || return $?
    shift
  done
}

# Clean up after our pre-commit (deletes cache directory)
gitPreCommitCleanup() {
  local directory
  directory=$(__gitPreCommitCache) || return $?
  [ ! -d "$directory" ] || __environment rm -rf "$directory" || return $?
}

# Does a branch exist locally or remotely?
# Usage: {fn} branch ...
# Argument: branch ... - String. Required. List of branch names to check.
# Exit Code: 0 - All branches passed exist
# Exit Code: 1 - At least one branch does not exist locally or remotely
gitBranchExists() {
  local usage="_${FUNCNAME[0]}"

  [ $# -gt 0 ] || __failArgument "$usage" "Requires at least one branch name" || return $?
  while [ $# -gt 0 ]; do
    if ! gitBranchExistsLocal "$1" && ! gitBranchExistsRemote "$1"; then
      return 1
    fi
    shift
  done
}
_gitBranchExists() {
  # IDENTICAL usageDocument 1
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

  [ $# -gt 0 ] || __failArgument "$usage" "Requires at least one branch name" || return $?
  while [ $# -gt 0 ]; do
    branch=$(__usageEnvironment "$usage" git branch --list "$1") || return $?
    [ -n "$branch" ] || return 1
    shift
  done
}
_gitBranchExistsLocal() {
  # IDENTICAL usageDocument 1
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

  __usageEnvironment "$usage" buildEnvironmentLoad GIT_REMOTE || return $?
  [ -n "$GIT_REMOTE" ] || __usageEnvironment "$usage" "GIT_REMOTE requires a value" || return $?

  [ $# -gt 0 ] || __failArgument "$usage" "Requires at least one branch name" || return $?
  while [ $# -gt 0 ]; do
    branch=$(__usageEnvironment "$usage" git ls-remote --heads "$GIT_REMOTE" "$1") || return $?
    [ -n "$branch" ] || return 1
    shift
  done
}
_gitBranchExistsRemote() {
  # IDENTICAL usageDocument 1
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
  local version user format branchName currentBranch

  export GIT_BRANCH_FORMAT GIT_REMOTE

  usageRequireBinary "$usage" whoami || return $?
  __usageEnvironment "$usage" buildEnvironmentLoad GIT_BRANCH_FORMAT GIT_REMOTE || return $?
  [ -n "$GIT_REMOTE" ] || __usageEnvironment "$usage" "GIT_REMOTE requires a value" || return $?

  version=$(__usageEnvironment "$usage" hookVersionCurrent) || return $?
  user=$(__usageEnvironment "$usage" whoami) || return $?

  format="${BUILD_BRANCH_FORMAT-}"
  [ -n "$format" ] || format="{version}-{user}"
  branchName="$(version=$version user=$user mapEnvironment < <(printf "%s\n" "$format"))"
  [ -n "$branchName" ] || __failEnvironment "$usage" "BUILD_BRANCH_FORMAT=\"$BUILD_BRANCH_FORMAT\" -> \"$format\" made blank branch (user=$user version=$version)" || return $?

  if gitBranchExists "$branchName"; then
    currentBranch=$(__usageEnvironment "$usage" gitCurrentBranch) || return $?
    if [ "$currentBranch" != "$branchName" ]; then
      if ! muzzle git checkout "$branchName" 2>&1; then
        __failEnvironment "$usage" "Local changes in $(decorate value "$currentBranch") prevent switching to $(decorate code "$branchName") due to local changes" || return $?
      fi
      decorate success "Switched to $(decorate code "$branchName")"
    else
      decorate success "Branch is $(decorate code "$branchName")"
    fi
  else
    __usageEnvironment "$usage" git checkout -b "$branchName" || return $?
    __usageEnvironment "$usage" git push -u "$GIT_REMOTE" "$branchName" || return $?
    printf "%s %s %s%s%s\n" "$(decorate success "Branch is")" "$(decorate code "$branchName")" "$(decorate info "(pushed to ")" "$(decorate value "$GIT_REMOTE")" "$(decorate info ")")"
  fi

}
_gitBranchify() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Merge the current branch with another, push to remote, and then return to the original branch.
# Argument: branch - String. Required. Branch to merge the current branch with.
# Argument: --skip-ip - Boolean. Optional. Do not add the IP address to the comment.
# Argument: --comment - String. Optional. Comment for merge commit.
gitBranchMergeCurrent() {
  local usage="_${FUNCNAME[0]}"

  local targetBranch="" comment="" addIP=true

  local saved=("$@") nArguments=$#
  while [ $# -gt 0 ]; do
    local argument argumentIndex=$((nArguments - $# + 1))
    argument="$(usageArgumentString "$usage" "argument #$argumentIndex (Arguments: $(_command "${usage#_}" "${saved[@]}"))" "$1")" || return $?
    case "$argument" in
      # IDENTICAL --help 4
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
    # IDENTICAL argument-esac-shift 1
    shift || __failArgument "$usage" "missing argument #$argumentIndex: $argument (Arguments: $(_command "${usage#_}" "${saved[@]}"))" || return $?
  done

  [ -n "$targetBranch" ] || __failArgument "$usage" "branch required" || return $?
  if [ -z "$comment" ]; then
    comment="${FUNCNAME[0]} by $(whoami) on $(hostname)"
  fi
  if $addIP; then
    comment="$comment @ $(ipLookup || printf "%s" "$? <- ipLookup failed")" 2>/dev/null
  fi
  local currentBranch
  currentBranch=$(__usageEnvironment "$usage" gitCurrentBranch) || return $?
  if [ "$currentBranch" = "$targetBranch" ]; then
    __failEnvironment "$usage" "Already on $(decorate code "$targetBranch") branch" || return $?
  fi
  __usageEnvironment "$usage" git checkout "$targetBranch" || return $?
  __usageEnvironment "$usage" git merge -m "$comment" "$branch" || _undo $? git checkout --force "$branch" || return $?
  __usageEnvironment "$usage" git push || _undo $? git checkout --force "$branch" || return $?
  __usageEnvironment "$usage" git checkout "$branch" || return $?
}
_gitUpdateBranch() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
