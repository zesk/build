
## Usage

    identicalCheck --extension extension0 --prefix prefix0  [ --cd directory ] [ --extension extension1 ... ] [ --prefix prefix1 ... ]

## Arguments

--extension - `extension` - Required. One or more extensions to search for in the current directory.
--prefix - `prefix` - Required. One or more string prefixes to search for in matching files.
--cd - `directory` - Optional. Change to this directory before running.

## Exit codes

- `2` - Argument error
- `0` - Success, everything matches
- `100` - Failures
