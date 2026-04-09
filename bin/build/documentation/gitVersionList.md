## `gitVersionList`

> Fetches a list of tags from git and filters those

### Usage

    gitVersionList [ --help ]

Fetches a list of tags from git and filters those which start with v and a digit and returns
them sorted by version correctly.

### Arguments

- `--help` - Flag. Optional. Display this help.

### Return codes

- `1` - If the `.git` directory does not exist
- `0` - Success

