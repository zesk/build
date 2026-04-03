## `bashLint`

> Check bash files for common errors

### Usage

    bashLint [ --help ] [ --fix ] [ --verbose ] [ script ]

Run `shellcheck` and `bash -n` on a set of bash files.
This can be run on any directory tree to test scripts in any application.
Shell comments must not be immediately after a function end, e.g. this is invalid:
    myFunc() {
    }
    # Hey

### Arguments

- `--help` - Flag. Optional. Display this help.
- `--fix` - Flag. Optional. Fix files when possible.
- `--verbose` - Flag. Optional. Be verbose.
- `script` - File. Optional. Shell script to validate

### Examples

    bashLint goo.sh

### Sample Output

This outputs `statusMessage`s to `stdout` and errors to `stderr`.

### Return codes

- `0` - All found files pass `shellcheck` and `bash -n` and shell comment syntax
- `1` - One or more files did not pass

