## `bashLintFiles`

> Check files for the existence of a string

### Usage

    bashLintFiles [ --verbose ] [ --fix ] [ --interactive ] [ --exec binary ] [ --delay ] [ findArgs ]

Run `bashLint` on a set of bash files.

### Arguments

- `--verbose` - Flag. Optional. Verbose mode.
- `--fix` - Flag. Optional. Fix errors when possible.
- `--interactive` - Flag. Optional. Interactive mode on fixing errors.
- `--exec binary` - Run binary with files as an argument for any failed files. Only works if you pass in item names.
- `--delay` - Integer. Optional. Delay between checks in interactive mode.
- `findArgs` - Additional find arguments for .sh files (or exclude directories).

### Examples

    if bashLintFiles; then git commit -m "saving things" -a; fi

### Sample Output

This outputs `statusMessage`s to `stdout` and errors to `stderr`.

### Return codes

- `0` - All found files pass `shellcheck` and `bash -n`
- `1` - One or more files did not pass

### Environment

- This operates in the current working directory

