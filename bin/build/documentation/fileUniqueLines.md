### `fileUniqueLines`

> Sorts and makes all file lines unique

#### Usage

    fileUniqueLines [ -n ] [ --verbose ] file [ --help ]

Remove duplicate lines from an input stream and sort.

> Location: `bin/build/tools/text.sh`

#### Arguments

- `-n` - Flag. Optional. Numeric sort.
- `--verbose` - Flag. Optional. Be exceptionally wordy.
- `file` - File. Required. File to modify in-place.
- `--help` - Flag. Optional. Display this help.

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

