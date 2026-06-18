### `gitPreCommitSetup`

> Set up a pre-commit hook and create a cache of

#### Usage

    gitPreCommitSetup [ --help ]

Set up a pre-commit hook and create a cache of our files by extension.

> Location: `bin/build/tools/git.sh`

#### Arguments

- `--help` - Flag. Optional. Display this help.

#### Return codes

- `0` - One or more files are available as part of the commit
- `1` - Error, or zero files are available as part of the commit

#### See Also

- [gitPreCommitCleanup]({rel}tools/git.md#gitprecommitcleanup) - Clean up after our pre-commit (deletes cache directory) ([source](https://github.com/zesk/build/blob/main/bin/build/tools/git.sh#L998))

