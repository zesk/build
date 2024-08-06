# Binaries

These are found in the `bin/build` directory and have equivalent functions.

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />


### `cannon.sh` - See `cannon` for arguments and usage.

See `cannon` for arguments and usage.

#### Exit codes

- `0` - Always succeeds

#### See Also

- [function {fn}]({documentationPath}) - [{summary}]({sourceLink})

### `chmod-sh.sh` - See `makeShellFilesExecutable` for arguments and usage.

See `makeShellFilesExecutable` for arguments and usage.

#### Exit codes

- `0` - Always succeeds

#### See Also

- [function {fn}]({documentationPath}) - [{summary}]({sourceLink})

### `deprecated.sh` - Clean up deprecated code automatically. This can be dangerous (uses

Clean up deprecated code automatically. This can be dangerous (uses `cannon`) so use it on
a clean build checkout and examine changes manually each time.

Does various checks for deprecated code and updates code.

#### Exit codes

- `0` - All cleaned up
- `1` - If fails or validation fails

### `identical-check.sh` - See `identicalCheck` for arguments and usage.

See `identicalCheck` for arguments and usage.

#### Exit codes

- `0` - Always succeeds

#### See Also

- [function {fn}]({documentationPath}) - [{summary}]({sourceLink})

### `identical-repair.sh` - By default will add any directory named `identical` as repair

By default will add any directory named `identical` as repair source and any file
at `identical/singles.txt` as a singles file.

Failures will be opened using `contextOpen`.

See `identicalCheckShell` for additional arguments and usage.

#### Exit codes

- `0` - Always succeeds

#### See Also

- [function {fn}]({documentationPath}) - [{summary}]({sourceLink})

### `install-bin-build.sh` - Installs a remote package system in a local project directory

Installs a remote package system in a local project directory if not installed. Also
will overwrite the installation binary with the latest version after installation.

Determines the most recent version using GitHub API unless --url or --local is specified

#### Arguments



#### Exit codes

- `1` - Environment error
- `2` - Argument error

#### Environment

Needs internet access and creates a directory `./bin/build`

### `bitbucket-container.sh` - See `bitbucketContainer` for arguments and usage.

See `bitbucketContainer` for arguments and usage.

#### Exit codes

- `0` - Always succeeds

#### See Also

- [function {fn}]({documentationPath}) - [{summary}]({sourceLink})

### `local-container.sh` - See `dockerLocalContainer` for arguments and usage.

See `dockerLocalContainer` for arguments and usage.

#### Exit codes

- `0` - Always succeeds

#### See Also

- [function {fn}]({documentationPath}) - [{summary}]({sourceLink})

### `map.sh` - See `mapEnvironment` for arguments and usage.

See `mapEnvironment` for arguments and usage.

#### Exit codes

- `0` - Always succeeds

#### See Also

- [function {fn}]({documentationPath}) - [{summary}]({sourceLink})

### `new-release.sh` - See `newRelease` for arguments and usage.

See `newRelease` for arguments and usage.

#### Exit codes

- `0` - Always succeeds

#### See Also

- [function {fn}]({documentationPath}) - [{summary}]({sourceLink})

### `release-notes.sh` - See `releaseNotes` for arguments and usage.

See `releaseNotes` for arguments and usage.

#### Exit codes

- `0` - Always succeeds

#### See Also

- [function {fn}]({documentationPath}) - [{summary}]({sourceLink})

### `version-last.sh` - See `gitVersionLast` for arguments and usage.

See `gitVersionLast` for arguments and usage.

#### Exit codes

- `0` - Always succeeds

#### See Also

- [function {fn}]({documentationPath}) - [{summary}]({sourceLink})

### `version-list.sh` - See `gitVersionLast` for arguments and usage.

See `gitVersionLast` for arguments and usage.

#### Exit codes

- `0` - Always succeeds

#### See Also

- [function {fn}]({documentationPath}) - [{summary}]({sourceLink})
