#!/usr/bin/env bash
#
# git tools, lame attempts have been made to have each function start with `git`.
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Depends: colors.sh documentation.sh
# bin: git
#
# Docs: contextOpen ./docs/_templates/tools/git.md
# Test: contextOpen ./test/bin/git-tests.sh
#

# IDENTICAL errorEnvironment 1
errorEnvironment=1

# IDENTICAL errorArgument 1
errorArgument=2

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
  whichApt git git "%@"
}

#
# When running git operations on a deployment host, at times it's necessary to
# add the current directory (or a directory) to the git `safe.directory` directive.
#
# This adds the directory passed to that directory in the local user's environment
#
# Usage: gitEnsureSafeDirectory [ directory ... ]
# Argument: directory - The directory to add to the `git` `safe.directory` configuration directive
# Exit Code: 0 - Success
# Exit Code: 2 - Argument is not a valid directory
# Exit Code: Other - git config error codes
#
gitEnsureSafeDirectory() {
  while [ $# -gt 0 ]; do
    if [ ! -d "$1" ]; then
      consoleError "$1 is not a directory"
      return "$errorArgument"
    fi
    if ! git config --global --get safe.directory | grep -q "$1"; then
      git config --global --add safe.directory "$1"
    fi
    shift
  done
}

#
# Delete git tag locally and at origin
#
# Usage: gitTagDelete [ tag ... ]
# Argument: tag - The tag to delete locally and remote
# Exit Code: 2 - Any stage fails will result in this exit code. Partial deletion may occur.
#
gitTagDelete() {
  local exitCode=0

  while [ $# -gt 0 ]; do
    if ! git tag -d "$1"; then
      printf "%s %s" "$(consoleError "Error deleting local tag")" "$(consoleCode "$1")" 1>&2
      exitCode=$errorArgument
    elif ! git push origin :"$1"; then
      printf "%s %s" "$(consoleError "Error deleting remote tag")" "$(consoleCode "$1")" 1>&2
      exitCode=$errorArgument
    fi
    shift
  done
  return "$exitCode"
}

#
# Remove a tag everywhere and tag again on the current branch
#
# Usage: gitTagDelete [ tag ... ]
# Argument: tag - The tag to delete locally and remote
# Exit Code: 2 - Any stage fails will result in this exit code. Partial deletion may occur.
#
gitTagAgain() {
  gitTagDelete "$1" || :
  if ! git tag "$1"; then
    printf "%s %s" "$(consoleError "Unable to tag")" "$(consoleCode "$1")" 1>&2
    return $errorArgument
  fi
  if ! git push --tags; then
    printf "%s %s %s" "$(consoleError "Unable to push")" "$(consoleCode "$1")" "$(consoleError "to remote")" 1>&2
    return $errorArgument
  fi
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
  if [ ! -d "./.git" ]; then
    echo "No .git directory at $(pwd), stopping" 1>&2
    return $errorEnvironment
  fi

  # versionSort works on vMMM.NNN.PPP
  # skip any versions with extensions like v1.0.1d2
  git tag | grep -e '^v[0-9.]*$' | versionSort "$@"
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
  local t="$1"

  if [ "$t" != "${t##v}" ]; then
    consoleError "Tag is already veed: $t" 1>&2
    return 1
  fi
  git tag "v$t" "$t"
  git tag -d "$t"
  git push origin "v$t" ":$t"
  git fetch -q --prune --prune-tags
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
# Not really test
#
gitRemoteHosts() {
  local remoteUrl host
  git remote -v | awk '{ print $2 }' | while read -r remoteUrl; do
    if ! host=$(urlParseItem host "$remoteUrl") &&
      ! host=$(urlParseItem host "git://$remoteUrl"); then
      consoleError "Unable to parse $remoteUrl" 1>&2
      return $errorArgument
    fi
    printf "%s\n" "$host"
  done
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
  local tagPrefix index tryVersion maximumTagsPerVersion

  if ! buildEnvironmentLoad BUILD_MAXIMUM_TAGS_PER_VERSION; then
    return 1
  fi

  maximumTagsPerVersion="$BUILD_MAXIMUM_TAGS_PER_VERSION"
  init=$(beginTiming)

  start=$(beginTiming)
  versionSuffix=
  while [ $# -gt 0 ]; do
    case $1 in
      --suffix)
        shift || :
        versionSuffix="${1-}"
        if [ -z "$versionSuffix" ]; then
          _gitTagVersion $errorArgument "--suffix is blank" || return $?
        fi
        shift
        ;;
      *)
        _gitTagVersion $errorArgument "Unknown argument: $1" || return $?
        ;;
    esac
  done

  consoleInfo -n "Pulling tags from origin "
  if ! git pull --tags origin >/dev/null; then
    _gitTagVersion "$errorEnvironment" "Pulling tags failed" || return $?
  fi

  reportTiming "$start" || :

  if ! currentVersion=$(runHook version-current); then
    _gitTagVersion "$errorEnvironment" "runHook version-current" || return $?
  fi
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
  echo "$(consoleLabel -n "Previous version is: ") $(consoleValue -n "$previousVersion")"
  echo "$(consoleLabel -n " Release version is: ") $(consoleValue -n "$currentVersion")"

  if ! releaseNotes="$(releaseNotes "$currentVersion")"; then
    _gitTagVersion "$errorEnvironment" "releaseNotes $currentVersion failed" || return $?
  fi

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
    return 212
  fi

  reportTiming "$init" "Tagged version completed in" || :
}
_gitTagVersion() {
  usageTemplate "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
  return $?
}

#
# Usage: {fn} [ --last ] [ -- ] [ comment ... ]
#
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
  local updateReleaseNotes appendLast argument start current next notes comment
  local this usage

  this="${FUNCNAME[0]}"
  usage="_$this"

  appendLast=false
  updateReleaseNotes=false
  comment=
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __failArgumebt "$usage" "Blank argument" || return $?
    case "$argument" in
      --)
        updateReleaseNotes=false
        ;;
      --last)
        appendLast=true
        ;;
      *)
        comment="$*"
        ;;
    esac
    shift || __failArgumebt "$usage" "Shift $argument failed" || return $?
  done

  appendLast=
  if [ "$comment" = "last" ]; then
    appendLast=true
  fi
  start="$(pwd -P 2>/dev/null)" || __failEnvironment "$usage" "Failed to get pwd" || return $?
  current="$start"
  while [ "$current" != "/" ]; do
    if [ ! -d "$current/.git" ]; then
      cd .. && next="$(pwd)" || __failArgument "$usage" "Failed to traverse up from $current" || return $?
      if [ "$current" = "$next" ]; then
        break
      fi
      current="$next"
    else
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
    fi
  done

  cd "$start" || :
  __failEnvironment "$usage" "Unable to find git repository" || return $?
}
__gitCommitReleaseNotesUpdate() {
  local comment="$1" notes="$2"

  if ! grep -q "$comment" "$notes"; then
    __usageEnvironment "$usage" printf -- "%s %s\n" "-" "$comment" >>"$notes" || return $?
    __usageEnvironment "$usage" printf -- "%s to %s: %s\n" "$(consoleInfo "Adding comment")" "$(consoleCode "$notes")" "$(consoleMagenta "$comment")" || return $?
    __usageEnvironment "$usage" git add "$notes" || return $?
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
  local branch returnCode updateOther

  if ! branch=$(git rev-parse --abbrev-ref HEAD); then
    consoleError "Git not present" 1>&2
    return "$errorEnvironment"
  fi
  case "$branch" in
    main | staging)
      _gitMainly "$errorEnvironment" "Already in branch $(consoleCode "$branch")" || return $?
      ;;
    HEAD)
      _gitMainly "$errorEnvironment" "Ignore branches named $(consoleCode "$branch")" || return $?
      ;;
    *)
      returnCode=0
      for updateOther in staging main; do
        if ! git checkout "$updateOther" 2>/dev/null; then
          printf "%s %s\n" "$(consoleError "Unable to update branch")" "$(consoleCode "$updateOther")" 1>&2
          git status -s || consoleError "git status failed?" || :
          returnCode="$errorEnvironment"
          break
        elif ! git pull; then
          consoleError "Unable to update $updateOther" 1>&2
          returnCode="$errorEnvironment"
        fi
      done
      if [ "$returnCode" -ne 0 ]; then
        return "$returnCode"
      fi
      if ! git checkout "$branch"; then
        consoleError "Unable to switch bach to $branch" 1>&2
        returnCode="$errorEnvironment"
      fi
      if git merge -m "Merging staging and main with $branch" origin/staging origin/main; then
        printf "%s %s\n" "$(consoleInfo "Merged staging and main into branch")" "$(consoleCode "$branch")"
        return "$returnCode"
      fi
      return $errorEnvironment
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
  # git rev-parse --abbrev-ref HEAD
  git symbolic-ref --short HEAD
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
