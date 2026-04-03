## `gitBranchMergeCurrent`

> Merge the current branch with another, push to remote, and

### Usage

    gitBranchMergeCurrent branch [ --skip-ip ] [ --comment ] [ --help ]

Merge the current branch with another, push to remote, and then return to the original branch.

### Arguments

- `branch` - String. Required. Branch to merge the current branch with.
- `--skip-ip` - Boolean. Optional. Do not add the IP address to the comment.
- `--comment` - String. Optional. Comment for merge commit.
- `--help` - Flag. Optional. Display this help.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

