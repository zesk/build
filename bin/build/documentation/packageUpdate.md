## `packageUpdate`

> Update packages lists and sources

### Usage

    packageUpdate [ --help ] [ --verbose ] [ --manager packageManager ] [ --force ]

Update packages lists and sources

### Arguments

- `--help` - Flag. Optional. Display this help.
- `--verbose` - Flag. Optional. Display progress to the terminal.
- `--manager packageManager` - String. Optional. Package manager to use. (apk, apt, brew)
- `--force` - Flag. Optional. Force even if it was updated recently.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

