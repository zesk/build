# Git Functions

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)

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

- `2` - Any stage fails will result in this exit code. Partial deletion may occur.

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
Not really test

#### Exit codes

- `0` - Always succeeds

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)
