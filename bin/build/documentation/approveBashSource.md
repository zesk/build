## `approveBashSource`

> Loads files or a directory of `.sh` files using `source`

### Usage

    approveBashSource directoryOrFile [ --info ] [ --no-info ] [ --verbose ] [ --clear ] [ --prefix ]

Loads files or a directory of `.sh` files using `source` to make the code available.
Has security implications. Use with caution and ensure your directory is protected.
Approved sources are stored in a cache structure at `$XDG_STATE_HOME/.interactiveApproved`.
Stale files are ones which no longer are associated with a file's current fingerprint.

### Arguments

- `directoryOrFile` - Exists. Required. Directory or file to `source` `.sh` files found.
- `--info` - Flag. Optional. Show user what they should do (press a key).
- `--no-info` - Flag. Optional. Hide user info (what they should do ... press a key)
- `--verbose` - Flag. Optional. Show what is done as status messages.
- `--clear` - Flag. Optional. Clear the approval status for file given.
- `--prefix` - String. Optional. Display this text before each status messages.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Environment

- {SEE:XDG_STATE_HOME.sh}

### See Also

- {SEE:XDG_STATE_HOME.sh}

