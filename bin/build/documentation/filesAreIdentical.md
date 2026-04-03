## `filesAreIdentical`

> Are files identical?

### Usage

    filesAreIdentical [ -b ] [ -B ] [ -i ] [ -w ] [ -I pattern ] source target ... [ --help ]

Are files identical?

### Arguments

- `-b` - Flag. Causes trailing blanks (spaces and tabs) to be ignored, and other strings of blanks to compare equal.
- `-B` - Flag. Causes chunks that include only blank lines to be ignored.
- `-i` - Flag. Ignores the case of letters.  E.g., "A" will compare equal to "a".
- `-w` - Flag. Ignores all blanks and tabs.
- `-I pattern` - String. Optional. Ignore lines which match extended regular expression `pattern`.
- `source` - File. Required. File to compare to.
- `target ...` - File. Required. Target file to compare to. Additional files are compared to `source`.
- `--help` - Flag. Optional. Display this help.

### Return codes

- `0` - Files are identical
- `1` - Files differ
- `2` - Argument error

