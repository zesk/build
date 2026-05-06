## `gitBranchExistsLocal`

> Does a branch exist locally?

### Usage

    gitBranchExistsLocal branch ... [ --help ]

Does a branch exist locally?

> Location: `bin/build/tools/git.sh`

### Arguments

- `branch ...` - String. Required. List of branch names to check.
- `--help` - Flag. Optional. Display this help.

### Return codes

- `0` - All branches exist
- `1` - At least one branch does not exist locally

