## `gitEnsureSafeDirectory`

> When running git operations on a deployment host, at times

### Usage

    gitEnsureSafeDirectory [ --help ] directory

When running git operations on a deployment host, at times it's necessary to
add the current directory (or a directory) to the git `safe.directory` directive.
This adds the directory passed to that directory in the local user's environment

### Arguments

- `--help` - Flag. Optional. Display this help.
- `directory` - Directory. Required. The directory to add to the `git` `safe.directory` configuration directive

### Return codes

- `0` - Success
- `2` - Argument is not a valid directory
- `Other` - git config error codes

