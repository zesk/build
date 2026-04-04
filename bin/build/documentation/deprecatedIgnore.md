## `deprecatedIgnore`

> Output a list of tokens for `find` to ignore in

### Usage

    deprecatedIgnore

Output a list of tokens for `find` to ignore in deprecated calls
Skips dot directories and release notes by default and any file named `deprecated.sh` `deprecated.txt` or `deprecated.md`.

### Arguments

- none

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Environment

- {SEE:BUILD_RELEASE_NOTES.sh}

