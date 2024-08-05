#!/usr/bin/env bash
#
# git tools, lame attempts have been made to have each function start with `git`.
#
# Copyright &copy; 2024 Market Acumen, Inc.
# bin: git
#
# Docs: contextOpen ./docs/_templates/tools/git.md
# Test: contextOpen ./test/bin/git-tests.sh
#

###############################################################################
#
#            ██
#            ▀▀       ██
#   ▄███▄██   ████     ███████
#  ██▀  ▀██     ██       ██
#  ██    ██     ██       ██
#  ▀██▄▄███  ▄▄▄██▄▄▄    ██▄▄▄
#   ▄▀▀▀ ██  ▀▀▀▀▀▀▀▀     ▀▀▀▀
#   ▀████▀▀
#
#------------------------------------------------------------------------------

#
# Installs the `git` binary
# Usage: gitInstall [ package ... ]
# Argument: package - Additional packages to install
# Summary: Install git if needed
#
gitInstall() {
  whichApt git git "$@"
}

#
# Uninstalls the `git` binary
# Usage: {fn} [ package ... ]
# Argument: package - Additional packages to uninstall
# Summary: Uninstall git
#
gitUninstall() {
  whichAptUninstall git git "$@"
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
  while [ $# -gt 0 ]; do
    # Deleting local tag
    __usageArgument "$usage" git tag -d "$1" || exitCode=$?
    # Deleting remote tag
    __usageArgument "$usage" git push origin :"$1" || exitCode=$?
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
    statusMessage consoleInfo "Deleting tag $1 ..."
    __usageArgument "$usage" gitTagDelete "$1" || return $?
    statusMessage consoleInfo "Tagging again $1 ..."
    __usageArgument "$usage" git tag "$1" || return $?
    __usageArgument "$usage" git push --tags || return $?
  done
  statusMessage consoleInfo "All tags completed" "$(consoleOrange "${a[@]}")"
  clearLine
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

  [ "$tagName" = "${tagName#v}" ] || __failArgument "$usage" "already v'd': $(consoleValue "$tagName")" || return $?
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
  ! git diff-index --quiet HEAD
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
    printf "%s\n" "$host"
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

  statusMessage consoleInfo "Pulling tags from origin "
  git pull --tags origin >/dev/null || __failEnvironment "$usage" "Pulling tags failed" || return $?
  reportTiming "$start" || :

  currentVersion=$(runHook version-current) || __failEnvironment "$usage" "runHook version-current" || return $?
  if ! previousVersion=$(gitVersionLast "$currentVersion"); then
    previousVersion="none"
  fi

  if git show-ref --tags "$currentVersion" --quiet; then
    consoleError "Version $currentVersion already exists, already tagged." 1>&2
    return 16
  fi
  if [ "$previousVersion" = "$currentVersion" ]; then
    consoleError "Version $currentVersion up to date, nothing to do." 1>&2
    return 17
  fi
  printf "%s %s\n%s %s\n" \
    "$(consoleLabel "Previous version is: ")" "$(consoleValue "$previousVersion")" \
    "$(consoleLabel " Release version is: ")" "$(consoleValue "$currentVersion")"

  releaseNotes="$(releaseNotes "$currentVersion")" || __failEnvironment "$usage" "releaseNotes $currentVersion failed" || return $?

  if [ ! -f "$releaseNotes" ]; then
    consoleError "Version $currentVersion no release notes \"$releaseNotes\" found, stopping." 1>&2
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
      consoleError "Tag version exceeded maximum of $maximumTagsPerVersion" 1>&2
      return 19
    fi
  done

  consoleInfo "Tagging version $tryVersion and pushing ... " || :
  if ! git tag "$tryVersion"; then
    consoleError "Failed to tag $tryVersion"
    return 20
  fi
  if ! git push --tags --quiet; then
    consoleError "git push --tags failed"
    return 21
  fi
  if ! git fetch -q; then
    consoleError "git fetch failed"
    return 22
  fi

  reportTiming "$init" "Tagged version completed in" || :
}
_gitTagVersion() {
  usageTemplate "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Usage: {fn} startingDirectory
# Finds .git directory above or in current one.
gitFindHome() {
  local usage="_${FUNCNAME[0]}"
  local argument directory gitDirectory

  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __failArgument "$usage" "blank argument" || return $?
    case "$argument" in
      # IDENTICAL --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      *)
        directory="$(usageArgumentDirectory "$usage" "directory" "$argument")" || return $?
        directory=$(realPath "$directory") || __failEnvironment "$usage" "realPath $directory" || return $?
        lastDirectory=
        while [ "$directory" != "$lastDirectory" ]; do
          gitDirectory="$directory/.git"
          if [ -d "$gitDirectory" ]; then
            printf "%s\n" "$directory"
            return 0
          fi
          lastDirectory="$directory"
          directory="$(dirname "$directory")"
        done
        __failEnvironment "$usage" "No .git found above \"$argument\"" || return $?
        ;;
    esac
    shift || __failArgument "$usage" shift || return $?
  done
}
_gitFindHome() {
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
#
# Example: ... are all equivalent.
gitCommit() {
  local usage="_${FUNCNAME[0]}"
  local updateReleaseNotes appendLast argument start notes comment home

  appendLast=false
  updateReleaseNotes=true
  comment=
  home=
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __failArgument "$usage" "blank argument" || return $?
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
      *)
        comment="$*"
        break
        ;;
    esac
    shift
  done

  appendLast=
  if [ "$comment" = "last" ]; then
    appendLast=true
    comment=
  fi

  start="$(pwd -P 2>/dev/null)" || __failEnvironment "$usage" "Failed to get pwd" || return $?
  if [ -z "$home" ]; then
    home=$(gitFindHome "$start") || __failEnvironment "$usage" "Unable to find git home" || return $?
  fi
  __usageEnvironment "$usage" cd "$home" || return $?
  gitRepositoryChanged || __failEnvironment "$usage" "No changes to commit" || return $?
  if $updateReleaseNotes && [ -n "$comment" ]; then
    statusMessage consoleInfo "Updating release notes ..."
    notes="$(releaseNotes)" || __failEnvironment "$usage" "No releaseNotes?" || return $?
    __usageEnvironment "$usage" __gitCommitReleaseNotesUpdate "$comment" "$notes" || return $?
  fi
  if $appendLast || [ -z "$comment" ]; then
    statusMessage consoleInfo "Using last commit message ..."
    __usageEnvironment "$usage" git commit --reuse-message=HEAD --reset-author -a || return $?
  else
    statusMessage consoleInfo "Using commit comment \"$comment\" ..."
    __usageEnvironment "$usage" git commit -a -m "$comment" || return $?
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
  __usageEnvironment "$usage" clearLine || return $?
  __usageEnvironment "$usage" printf "%s%s\n" "$(lineFill '.' "$(consoleLabel "Release notes") $(consoleValue "$displayNotes") $(consoleDecoration)")" "$(consoleReset)" || return $?
  if ! grep -q -e "$pattern" "$notes"; then
    __usageEnvironment "$usage" printf -- "%s %s\n" "-" "$comment" >>"$notes" || return $?
    __usageEnvironment "$usage" printf -- "%s to %s:\n%s\n" "$(consoleInfo "Adding comment")" "$(consoleCode "$displayNotes")" "$(boxedHeading "$comment")" || return $?
    __usageEnvironment "$usage" git add "$notes" || return $?
    __usageEnvironment "$usage" grep -B 10 -e "$pattern" "$notes" | wrapLines "$(consoleCode)" "$(consoleReset)" || return $?
  else
    __usageEnvironment "$usage" clearLine || return $?
    __usageEnvironment "$usage" printf -- "%s %s:\n" "$(consoleInfo "Comment already added to")" "$(consoleCode "$notes")" || return $?
    __usageEnvironment "$usage" grep -q -e "$pattern" "$notes" | wrapLines "$(consoleCode)" "$(consoleReset)" || return $?
  fi
}
_gitCommit() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: gitMainly
# Exit Code: 1 - Already in main, staging, or HEAD, or git merge failed
# Exit Code: 0 - git merge succeeded
# Merge `staging` and `main` branches of a Git repository into the current branch.
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
        __failArgument "$usage" "unknown argument: $(consoleValue "$argument")" || return $?
        ;;
    esac
    shift || __failArgument "$usage" "missing argument $(consoleLabel "$argument")" || return $?
  done

  errorLog=$(mktemp)
  branch=$(git rev-parse --abbrev-ref HEAD) || _environment "Git not present" || return $?
  case "$branch" in
    main | staging)
      __failEnvironment "$usage" "Already in branch $(consoleCode "$branch")" || return $?
      ;;
    HEAD)
      __failEnvironment "$usage" "Ignore branches named $(consoleCode "$branch")" || return $?
      ;;
    *)
      returnCode=0
      for updateOther in staging main; do
        ! $verboseFlag || consoleInfo git checkout "$updateOther"
        if ! git checkout "$updateOther" >"$errorLog" 2>&1; then
          printf "%s %s\n" "$(consoleError "Unable to checkout branch")" "$(consoleCode "$updateOther")" 1>&2
          returnCode=1
          __environment git status -s || :
          break
        else
          ! $verboseFlag || consoleInfo git pull "# ($updateOther)"
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
      ! $verboseFlag || consoleInfo git checkout "$branch"
      if ! __environment git checkout "$branch" >"$errorLog" 2>&1; then
        printf "%s %s\n" "$(consoleError "Unable to switch BACK to branch")" "$(consoleCode "$updateOther")" 1>&2
        rm -rf "$errorLog"
        return 1
      fi
      ! $verboseFlag || consoleInfo git merge -m
      __environment git merge -m "Merging staging and main with $branch" origin/staging origin/main || return $?
      if grep -q 'Already' "$errorLog"; then
        printf "%s %s\n" "$(consoleInfo "Already up to date")" "$(consoleCode "$branch")"
      else
        printf "%s %s\n" "$(consoleInfo "Merged staging and main into branch")" "$(consoleCode "$branch")"
      fi
      rm -rf "$errorLog"
      ;;
  esac
}
_gitMainly() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Get the current branch name
#
gitCurrentBranch() {
  local usage

  usage="_${FUNCNAME[0]}"

  # git rev-parse --abbrev-ref HEAD
  __usageEnvironment "$usage" git symbolic-ref --short HEAD || return $?
}
_gitCurrentBranch() {
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
  printf "%s " pre-commit pre-push pre-merge-commit pre-rebase pre-receive update post-update post-commit
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
  read -r -a types < <(gitHookTypes)
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
          __usageEnvironment "$usage" gitInstallHook --application "$home" --copy "$hook" || return $?
          ! $verbose || consoleSuccess "Installed $(consoleValue "$hook")" || :
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
        ! $verbose || consoleSuccess "Installed $(consoleValue "$hook")" || :
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

  read -r -a types < <(gitHookTypes)
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
            relFromTo+=(".${item#"$home"}")
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
          printf "%s %s -> %s\n" "$(consoleSuccess "git hook:")" "$(consoleWarning "${relFromTo[0]}")" "$(consoleCode "${relFromTo[1]}")" || :
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

#
# Run pre-commit checks on shell-files
# Usage: {fn} [ --help ] [ --interactive ] [ --check checkDirectory ] ...
# Argument: --singles singlesFiles - Optional. File. One or more files which contain a list of allowed `IDENTICAL` singles, one per line.
# Argument: --help - Flag. Optional. I need somebody.
# Argument: --interactive - Flag. Optional. Interactive mode on fixing errors.
# Argument: --check checkDirectory - Optional. Directory. Check shell scripts in this directory for common errors.
# Argument: ... - Additional arguments are passed to `validateShellScripts` `validateFileContents`
gitPreCommitShellFiles() {
  local usage="_${FUNCNAME[0]}"
  local argument directory checkAssertions file

  set -eou pipefail
  checkAssertions=()
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __failArgument "$usage" "blank argument" || return $?
    case "$argument" in
      --check)
        shift || __failArgument "$usage" "shift $argument" || return $?
        checkAssertions+=("$(usageArgumentDirectory "$usage" "checkDirectory" "$1")") || return $?
        ;;
      # IDENTICAL --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      *)
        break
        ;;
    esac
    shift || :
  done

  statusMessage consoleSuccess Making shell files executable ...
  __usageEnvironment "$usage" makeShellFilesExecutable || return $?

  statusMessage consoleSuccess "Running shellcheck ..." || :
  __usageEnvironment "$usage" validateShellScripts --exec contextOpen "$@" || return $?

  export BUILD_COMPANY
  year="$(date +%Y)"
  __usageEnvironment "$usage" buildEnvironmentLoad BUILD_COMPANY || return $?
  statusMessage consoleWarning "Checking $year and $BUILD_COMPANY ..." || :
  __usageEnvironment "$usage" validateFileContents --exec contextOpen "$@" -- "Copyright &copy; $year" "$BUILD_COMPANY" || return $?

  for directory in "${checkAssertions[@]+${checkAssertions[@]}}"; do
    statusMessage consoleWarning "Checking assertions in $(consoleCode "${directory}") - " || :
    if ! findUncaughtAssertions "$directory" --list; then
      findUncaughtAssertions "$directory" --exec contextOpen &
      __failEnvironment "$usage" findUncaughtAssertions || return $?
    fi
  done
  if __fileMatches 'set ["]\?-x' 'debugging found' bin/build/install-bin-build.sh bin/build/tools/debug.sh -- "$@"; then
    __failEnvironment "$usage" found debugging || return $?
  fi
}
_gitPreCommitShellFiles() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: {fn} pattern displayError exception ... -- file ...
__fileMatches() {
  local file pattern="$1" error="$2" found=false exceptions=()
  shift 2 || _argument "missing arguments" || return $?
  [ $# -gt 0 ] || return 0
  while [ $# -gt 0 ]; do
    if [ "$1" = "--" ]; then
      break
    fi
    exceptions+=("$1")
    shift
  done
  [ $# -gt 0 ] || _argument "missing files" || return $?
  while read -r file; do
    if [ "${#exceptions[@]}" -gt 0 ] && substringFound "$file" "${exceptions[@]}"; then
      continue
    fi
    printf "%s%s\n" "$(lineFill "!" "$(printf "%s - %s %s" "$(consoleInfo "$file")" "$(consoleError "$error")" "$(consoleDecoration)")")" "$(consoleReset)"
    grep -n -e "$pattern" "$file"
    found=true
  done < <(grep -l -e "$pattern" "$@")
  $found
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
  printf "%s%s: %s\n" "$(clearLine)" "$(consoleSuccess "$(alignRight "$width" "all")")" "$(consoleInfo "$total $(plural "$total" file files) changed")"
  while [ $# -gt 0 ]; do
    total=0
    color=consoleWarning
    if [ -f "$directory/$1" ]; then
      total=$(($(wc -l <"$directory/$1") + 0))
      color=consoleSuccess
    fi
    # shellcheck disable=SC2015
    printf "%s: %s\n" "$("$color" "$(alignRight "$width" "$1")")" "$(consoleInfo "$total $(plural "$total" file files) changed")"
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
