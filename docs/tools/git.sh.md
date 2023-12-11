# Git Functions

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)


### `gitInstall` - Install git if needed

Installs the `git` binary

#### Usage

    gitInstall [ package ... ]

#### Arguments

- `package` - Additional packages to install

#### Exit codes

- `0` - Always succeeds

### `veeGitTag` - Given a tag in the form "1.1.3" convert it to

Given a tag in the form "1.1.3" convert it to "v1.1.3" so it has a character prefix "v"
Delete the old tag as well

#### Exit codes

- `0` - Always succeeds

### `gitRemoveFileFromHistory` - Has a lot of caveats

Has a lot of caveats

gitRemoveFileFromHistory path/to/file

usually have to `git push --force`

#### Exit codes

- `0` - Always succeeds

### `gitEnsureSafeDirectory` - When running git operations on a deployment host, at times

When running git operations on a deployment host, at times it's necessary to
add the current directory (or a directory) to the git `safe.directory` directive.

This adds the directory passed to that directory in the local user's environment

#### Usage

    gitEnsureSafeDirectory [ directory ... ]

#### Arguments

- `directory` - The directory to add to the `git` `safe.directory` configuration directive

#### Exit codes

- `0` - Success
- `2` - Argument is not a valid directory
- `Other` - git config error codes

### `gitTagDelete` - Delete git tag locally and at origin

Delete git tag locally and at origin

#### Usage

    gitTagDelete [ tag ... ]

#### Arguments

- `tag` - The tag to delete locally and remote

#### Exit codes

- `2` - Any stage fails will result in this exit code. Partial deletion may occur.

### `gitTagAgain` - Remove a tag everywhere and tag again on the current

Remove a tag everywhere and tag again on the current branch

#### Usage

    gitTagDelete [ tag ... ]

#### Arguments

- `tag` - The tag to delete locally and remote

#### Exit codes

- `2` - Any stage fails will result in this exit code. Partial deletion may occur.

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)
