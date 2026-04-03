## `gitBranchExists`

> Does a branch exist locally or remotely?

### Usage

    gitBranchExists branch ... [ --help ]

Does a branch exist locally or remotely?

### Arguments

- `branch ...` - String. Required. List of branch names to check.
- `--help` - Flag. Optional. Display this help.

### Return codes

- `0` - All branches passed exist
- `1` - At least one branch does not exist locally or remotely

