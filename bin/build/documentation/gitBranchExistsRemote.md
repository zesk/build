### `gitBranchExistsRemote`

> Does a branch exist remotely?

#### Usage

    gitBranchExistsRemote branch ... [ --help ]

Does a branch exist remotely?

> Location: `bin/build/tools/git.sh`

#### Arguments

- `branch ...` - String. Required. List of branch names to check.
- `--help` - Flag. Optional. Display this help.

#### Return codes

- `0` - All branches exist on the remote
- `1` - At least one branch does not exist remotely

