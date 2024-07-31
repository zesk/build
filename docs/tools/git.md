# Git Functions

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

## git Installation


### `gitInstall` - Install git if needed

Installs the `git` binary

#### Usage

    gitInstall [ package ... ]
    

#### Arguments



#### Exit codes

- `0` - Always succeeds

### `gitEnsureSafeDirectory` - When running git operations on a deployment host, at times

When running git operations on a deployment host, at times it's necessary to
add the current directory (or a directory) to the git `safe.directory` directive.

This adds the directory passed to that directory in the local user's environment

#### Usage

    gitEnsureSafeDirectory [ directory ... ]
    

#### Arguments



#### Exit codes

- `0` - Success
- `2` - Argument is not a valid directory
- `Other` - git config error codes

## git Tags


### `gitTagDelete` - Delete git tag locally and at origin

Delete git tag locally and at origin

#### Usage

    gitTagDelete [ tag ... ]
    

#### Arguments



#### Exit codes

- `argument` - Any stage fails will result in this exit code. Partial deletion may occur.

### `gitTagAgain` - Remove a tag everywhere and tag again on the current

Remove a tag everywhere and tag again on the current branch

#### Usage

    gitTagDelete [ tag ... ]
    

#### Arguments



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

#### Usage

    gitTagVersion [ --suffix versionSuffix ] Tag version in git
    

#### Arguments



#### Exit codes

- `0` - Always succeeds

#### Environment

BUILD_VERSION_SUFFIX - String. Version suffix to use as a default. If not specified the default is `rc`.
BUILD_MAXIMUM_TAGS_PER_VERSION - Integer. Number of integers to attempt to look for when incrementing.

### `gitVersionList` - Fetches a list of tags from git and filters those

Fetches a list of tags from git and filters those which start with v and a digit and returns
them sorted by version correctly.

#### Usage

    gitVersionList
    

#### Exit codes

- `1` - If the `.git` directory does not exist
- `0` - Success

### `gitVersionLast` - Get the last reported version.

Get the last reported version.

#### Usage

    gitVersionLast [ ignorePattern ]
    

#### Arguments



#### Exit codes

- `0` - Always succeeds

### `veeGitTag` - Given a tag in the form "1.1.3" convert it to

Given a tag in the form "1.1.3" convert it to "v1.1.3" so it has a character prefix "v"
Delete the old tag as well

#### Exit codes

- `0` - Always succeeds

## git Development


### `gitCommit` - Commits all files added to git and also update release

Commits all files added to git and also update release notes with comment

Comment wisely. Does not duplicate comments. Check your release notes.

#### Usage

    gitCommit [ --last ] [ -- ] [ comment ... ]
    

#### Arguments



#### Examples

    c last
    c --last
    c --
... are all equivalent.

#### Exit codes

- `0` - Always succeeds

### `gitMainly` - Merge `staging` and `main` branches of a Git repository into

Merge `staging` and `main` branches of a Git repository into the current branch.

Will merge `origin/staging` and `origin/main` after doing a `--pull` for both of them

Current repository should be clean and have no modified files.

#### Usage

    gitMainly
    

#### Exit codes

- `1` - Already in main, staging, or HEAD, or git merge failed
- `0` - git merge succeeded

### `gitPreCommitShellFiles` - Run pre-commit checks on shell-files

Run pre-commit checks on shell-files

#### Usage

    gitPreCommitShellFiles [ --help ] [ --interactive ] [ --check checkDirectory ] ...
    

#### Arguments



#### Exit codes

- `0` - Always succeeds

### `gitFindHome` - Finds .git directory above or in current one.

Finds .git directory above or in current one.

#### Usage

    gitFindHome startingDirectory
    

#### Exit codes

- `0` - Always succeeds

### `gitHookTypes` - GIT_AUTHOR_DATE=@1702851863 +0000

GIT_AUTHOR_DATE=@1702851863 +0000
GIT_AUTHOR_EMAIL=kent@example.com
GIT_AUTHOR_NAME=root
GIT_EDITOR=:
GIT_EXEC_PATH=/usr/lib/git-core
GIT_INDEX_FILE=/opt/atlassian/bitbucketci/agent/build/.git/index.lock
GIT_PREFIX=

#### Exit codes

- `0` - Always succeeds

### `gitInstallHook` - Install the most recent version of this hook and RUN

Install the most recent version of this hook and RUN IT in place if it has changed.
You should ONLY run this from within your hook, or provide the `--copy` flag to just copy.
When running within your hook, pass additional arguments so they can be preserved:

    gitInstallHook --application "$myHome" pre-commit "$@" || return $?

#### Usage

    gitInstallHook [ --application applicationHome ] [ --copy ] hook
    

#### Arguments



#### Exit codes

- `0` - the file was not updated
- `1` - Environment error
- `2` - Argument error
- `3 - --copy` - the file was changed

#### Environment

BUILD-HOME - The default application home directory used for `.git` and build hooks.

#### Exit codes

- `0` - Always succeeds

## git History


### `gitRemoveFileFromHistory` - Has a lot of caveats

Has a lot of caveats

gitRemoveFileFromHistory path/to/file

usually have to `git push --force`

#### Exit codes

- `0` - Always succeeds

## git Working Tree State


### `gitRepositoryChanged` - Has a git repository been changed from HEAD?

Has a git repository been changed from HEAD?

#### Exit codes

- `1` - the repo has NOT been modified
- `0` - the repo has been modified

### `gitShowChanges` - Show changed files from HEAD

Show changed files from HEAD

#### Usage

    gitShowChanges
    

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

#### Usage

    gitShowStatus
    

#### Exit codes

- `0` - the repo has been modified
- `1` - the repo has NOT bee modified

### `gitInsideHook` - Are we currently inside a git hook?

Are we currently inside a git hook?

Tests non-blank strings in our environment.

#### Exit codes

- `0` - We are, semantically, inside a git hook
- `1` - We are NOT, semantically, inside a git hook

#### Environment

GIT_EXEC_PATH - Must be set to pass
GIT_INDEX_FILE - Must be set to pass

### `gitRemoteHosts` - List remote hosts for the current git repository

List remote hosts for the current git repository

#### Exit codes

- `0` - Always succeeds

### `gitCurrentBranch` - Get the current branch name

Get the current branch name

#### Exit codes

- `0` - Always succeeds

## git pre-commit hook


### `gitPreCommitSetup` - Set up a pre-commit hook

Set up a pre-commit hook

#### Exit codes

- `0` - Always succeeds 

### `gitPreCommitHeader` - Output a display for pre-commit files changed

Output a display for pre-commit files changed

#### Exit codes

- `0` - Always succeeds 

### `gitPreCommitHasExtension` - Does this commit have the following file extensions?

Does this commit have the following file extensions?

#### Exit codes

- `0` - Always succeeds 

### `gitPreCommitListExtension` - List the file(s) of an extension

List the file(s) of an extension

#### Exit codes

- `0` - Always succeeds 

### `gitPreCommitCleanup` - Clean up after our pre-commit (deletes cache directory)

Clean up after our pre-commit (deletes cache directory)

#### Exit codes

- `0` - Always succeeds
