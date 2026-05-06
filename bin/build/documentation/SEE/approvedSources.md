## `approvedSources`

> List approved Bash script sources which can be loaded automatically

### Usage

    approvedSources [ --debug ] [ --no-delete ] [ --delete ]

List approved Bash script sources which can be loaded automatically by project hooks.

Approved sources are stored in a cache structure at `$XDG_STATE_HOME/.interactiveApproved`.
Stale files are ones which no longer are associated with a file's current fingerprint.

> Location: `bin/build/tools/interactive.sh`

