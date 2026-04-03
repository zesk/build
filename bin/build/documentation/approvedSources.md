## `approvedSources`

> List approved Bash script sources which can be loaded automatically

### Usage

    approvedSources [ --debug ] [ --no-delete ] [ --delete ]

List approved Bash script sources which can be loaded automatically by project hooks.
Approved sources are stored in a cache structure at `$XDG_STATE_HOME/.interactiveApproved`.
Stale files are ones which no longer are associated with a file's current fingerprint.

### Arguments

- `--debug` - Flag. Optional. Show a lot of information about the approved cache.
- `--no-delete` - Flag. Optional. Do not delete stale approval files.
- `--delete` - Flag. Optional. Delete stale approval files.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Environment

- {SEE:XDG_STATE_HOME.sh}

### See Also

- {SEE:XDG_STATE_HOME.sh}

