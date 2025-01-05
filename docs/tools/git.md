# Git Functions

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

## git Installation

### `gitInstall` - Install git if needed

Installs the `git` binary

- Location: `bin/build/tools/git.sh`

#### Usage

    gitInstall [ package ... ]
    

#### Arguments

- `package` - Additional packages to install

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `gitEnsureSafeDirectory` - When running git operations on a deployment host, at times

When running git operations on a deployment host, at times it's necessary to
add the current directory (or a directory) to the git `safe.directory` directive.

This adds the directory passed to that directory in the local user's environment

- Location: `bin/build/tools/git.sh`

#### Usage

    gitEnsureSafeDirectory [ directory ... ]
    

#### Arguments

- `directory` - Required. Directory. The directory to add to the `git` `safe.directory` configuration directive

#### Exit codes

- `0` - Success
- `2` - Argument is not a valid directory
- `Other` - git config error codes

## git Tags

### `gitTagDelete` - Delete git tag locally and at origin

Delete git tag locally and at origin

- Location: `bin/build/tools/git.sh`

#### Usage

    gitTagDelete [ tag ... ]
    

#### Arguments

- `tag` - The tag to delete locally and at origin

#### Exit codes

- `argument` - Any stage fails will result in this exit code. Partial deletion may occur.
### `gitTagAgain` - Remove a tag everywhere and tag again on the current

Remove a tag everywhere and tag again on the current branch

- Location: `bin/build/tools/git.sh`

#### Usage

    gitTagDelete [ tag ... ]
    

#### Arguments

- `tag` - The tag to delete locally and remote

#### Exit codes

- `2` - Any stage fails will result in this exit code. Partial deletion may occur.
### `gitTagVersion` - Generates a git tag for a build version, so `v1.0d1`,

Generates a git tag for a build version, so `v1.0d1`, `v1.0d2`, for version `v1.0`.
Tag a version of the software in git and push tags to origin.
If this fails it will output the installation log.
When this tool succeeds the git repository contains a tag with the suffix and an index which represents the build index.


- `d` - for **development**
- `s` - for **staging**
- `rc` - for **release candidate**

- Location: `bin/build/tools/git.sh`

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

BUILD_VERSION_SUFFIX - String. Version suffix to use as a default. If not specified the default is `rc`.
BUILD_MAXIMUM_TAGS_PER_VERSION - Integer. Number of integers to attempt to look for when incrementing.
### `gitVersionList` - Fetches a list of tags from git and filters those

Fetches a list of tags from git and filters those which start with v and a digit and returns
them sorted by version correctly.

- Location: `bin/build/tools/git.sh`

#### Usage

    gitVersionList
    

#### Arguments

- No arguments.

#### Exit codes

- `1` - If the `.git` directory does not exist
- `0` - Success
### `gitVersionLast` - Get the last reported version.

Get the last reported version.

- Location: `bin/build/tools/git.sh`

#### Usage

    gitVersionLast [ ignorePattern ]
    

#### Arguments

- `ignorePattern` - Optional. Specify a grep pattern to ignore; allows you to ignore current version

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `veeGitTag` - Given a tag in the form "1.1.3" convert it to

Given a tag in the form "1.1.3" convert it to "v1.1.3" so it has a character prefix "v"
Delete the old tag as well

- Location: `bin/build/tools/git.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

## git Branches

### `gitBranchExists` - Does a branch exist locally or remotely?

Does a branch exist locally or remotely?

- Location: `bin/build/tools/git.sh`

#### Arguments

- `branch ...` - String. Required. List of branch names to check.

#### Exit codes

- `0` - All branches passed exist
- `1` - At least one branch does not exist locally or remotely
### `gitBranchExistsRemote` - Does a branch exist remotely?

Does a branch exist remotely?

- Location: `bin/build/tools/git.sh`

#### Arguments

- `branch ...` - String. Required. List of branch names to check.

#### Exit codes

- `0` - All branches passed exist
- `1` - At least one branch does not exist remotely
### `gitBranchExistsLocal` - Does a branch exist locally?

Does a branch exist locally?

- Location: `bin/build/tools/git.sh`

#### Arguments

- `branch ...` - String. Required. List of branch names to check.

#### Exit codes

- `0` - All branches passed exist
- `1` - At least one branch does not exist locally
#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

BUILD_BRANCH_FORMAT
### `gitBranchMergeCurrent` - Merge the current branch with another, push to remote, and

Merge the current branch with another, push to remote, and then return to the original branch.

- Location: `bin/build/tools/git.sh`

#### Arguments

- `branch` - String. Required. Branch to merge the current branch with.
- `--skip-ip` - Boolean. Optional. Do not add the IP address to the comment.
- `--comment` - String. Optional. Comment for merge commit.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

## git Development

### `gitCommitHash` - Get the commit hash

Get the commit hash

- Location: `bin/build/tools/git.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `gitCommit` - Commits all files added to git and also update release

Commits all files added to git and also update release notes with comment

Comment wisely. Does not duplicate comments. Check your release notes.

Example:

- Location: `bin/build/tools/git.sh`

#### Arguments

- `--last` - Optional. Flag. Append last comment
- `--` - Optional. Flag. Skip updating release notes with comment.
- `--help` - Optional. Flag. I need somebody.
- `comment` - Optional. Text. A text comment for release notes and describing in general terms, what was done for a commit message.

#### Examples

    c last
    c --last
    c --
... are all equivalent.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `gitMainly` - Merge `staging` and `main` branches of a git repository into

Merge `staging` and `main` branches of a git repository into the current branch.

Will merge `origin/staging` and `origin/main` after doing a `--pull` for both of them

Current repository should be clean and have no modified files.

- Location: `bin/build/tools/git.sh`

#### Usage

    gitMainly
    

#### Arguments

- No arguments.

#### Exit codes

- `1` - Already in main, staging, or HEAD, or git merge failed
- `0` - git merge succeeded
### `gitFindHome` - Finds `.git` directory above or at `startingDirectory`

Finds `.git` directory above or at `startingDirectory`

- Location: `bin/build/tools/git.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `gitHookTypes` - List current valid git hook types

List current valid git hook types
Hook types:
- pre-commit
- pre-push
- pre-merge-commit
- pre-rebase
- pre-receive
- update
- post-update
- post-commit

- Location: `bin/build/tools/git.sh`

#### Arguments

- No arguments.

#### Sample Output

    lines:gitHookType
    

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `gitInstallHook` - Install the most recent version of this hook and RUN

Install the most recent version of this hook and RUN IT in place if it has changed.
You should ONLY run this from within your hook, or provide the `--copy` flag to just copy.
When running within your hook, pass additional arguments so they can be preserved:

    gitInstallHook --application "$myHome" pre-commit "$@" || return $?

- Location: `bin/build/tools/git.sh`

#### Arguments

- `hook` - A hook to install. Maps to `git-hook` internally. Will be executed in-place if it has changed from the original.
- `--application` - Optional. Directory. Path to application home.
- `--copy` - Optional. Flag. Do not execute the hook if it has changed.

#### Exit codes

- `0` - the file was not updated
- `1` - Environment error
- `2` - Argument error

#### Environment

BUILD-HOME - The default application home directory used for `.git` and build hooks.
### `gitInstallHooks` - Install one or more git hooks from Zesk Build hooks.

Install one or more git hooks from Zesk Build hooks.
Zesk Build hooks are named `git-hookName.sh` in `bin/hooks/` so `git-pre-commit.sh` will be installed as the `pre-commit` hook for git.

Hook types:
- pre-commit
- pre-push
- pre-merge-commit
- pre-rebase
- pre-receive
- update
- post-update
- post-commit

- Location: `bin/build/tools/git.sh`

#### Arguments

- `--copy` - Flag. Optional. Copy the hook but do not execute it.
- `--verbose` - Flag. Optional. Be verbose about what is done.
- `--application home` - Directory. Optional. Set the application home directory to this prior to looking for hooks.
- `hookName` - String. Optional. A hook or hook names to install. See `gitHookTypes`

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

## git History

### `gitRemoveFileFromHistory` - Has a lot of caveats

Has a lot of caveats

gitRemoveFileFromHistory path/to/file

usually have to `git push --force`

- Location: `bin/build/tools/git.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

## git Working Tree State

### `gitRepositoryChanged` - Has a git repository been changed from HEAD?

Has a git repository been changed from HEAD?

- Location: `bin/build/tools/git.sh`

#### Arguments

- No arguments.

#### Exit codes

- `1` - the repo has NOT been modified
- `0` - the repo has been modified
### `gitShowChanges` - Show changed files from HEAD

Show changed files from HEAD

- Location: `bin/build/tools/git.sh`

#### Usage

    gitShowChanges
    

#### Arguments

- No arguments.

#### Exit codes

- `0` - the repo has been modified
- `1` - the repo has NOT bee modified
### `gitShowStatus` - Show changed files from HEAD with their status prefix character:

Show changed files from HEAD with their status prefix character:

- ' ' = unmodified
- `M` = modified
- `A` = added
- `D` = deleted
- `R` = renamed
- `C` = copied
- `U` = updated but unmerged

(See `man git` for more details on status flags)

- Location: `bin/build/tools/git.sh`

#### Usage

    gitShowStatus
    

#### Arguments

- No arguments.

#### Exit codes

- `0` - the repo has been modified
- `1` - the repo has NOT bee modified
### `gitInsideHook` - Are we currently inside a git hook?

Are we currently inside a git hook?

Tests non-blank strings in our environment.

- Location: `bin/build/tools/git.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - We are, semantically, inside a git hook
- `1` - We are NOT, semantically, inside a git hook

#### Environment

GIT_EXEC_PATH - Must be set to pass
GIT_INDEX_FILE - Must be set to pass
### `gitRemoteHosts` - List remote hosts for the current git repository

List remote hosts for the current git repository

- Location: `bin/build/tools/git.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `gitCurrentBranch` - Get the current branch name

Get the current branch name

- Location: `bin/build/tools/git.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `gitHasAnyRefs` - Does git have any tags?

Does git have any tags?
May need to `git pull --tags`, or no tags exist.

- Location: `bin/build/tools/git.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

## git pre-commit hook

### `gitPreCommitSetup` - Set up a pre-commit hook

Set up a pre-commit hook

- Location: `bin/build/tools/git.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error 
### `gitPreCommitHeader` - Output a display for pre-commit files changed

Output a display for pre-commit files changed

- Location: `bin/build/tools/git.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error 
### `gitPreCommitHasExtension` - Does this commit have the following file extensions?

Does this commit have the following file extensions?

- Location: `bin/build/tools/git.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error 
### `gitPreCommitListExtension` - List the file(s) of an extension

List the file(s) of an extension

- Location: `bin/build/tools/git.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error 
### `gitPreCommitCleanup` - Clean up after our pre-commit (deletes cache directory)

Clean up after our pre-commit (deletes cache directory)

- Location: `bin/build/tools/git.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
