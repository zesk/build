## `bashSanitize`

> Sanitize bash files for code quality.

### Usage

    bashSanitize [ --help ] [ -- ] [ --home home ] [ --interactive ] [ --check checkDirectory ] [ ... ]

Sanitize bash files for code quality.
used in find `find ... ! -path '*LINE*'` and in grep -e 'LINE'
TODO - use one mechanism for bashSanitize.conf format

### Arguments

- `--help` - Flag. Optional. Display this help.
- `--` - Flag. Optional. Interactive mode on fixing errors.
- `--home home` - Directory. Optional. Sanitize files starting here. (Defaults to `buildHome`)
- `--interactive` - Flag. Optional. Interactive mode on fixing errors.
- `--check checkDirectory` - Directory. Optional. Check shell scripts in this directory for common errors.
- `...` - Additional arguments are passed to `bashLintFiles` `validateFileContents`

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

