### `documentationFunctionsCompile`

> Extract and build the documentation settings cache and generate derived

#### Usage

    documentationFunctionsCompile [ --clean ] [ --all | --stdin- Flag. Optional. Read function names from stdin for examination. ] [ --fingerprint ] --source [ --key fingerprintKey ] [ functionName ... ]

Extract and build the documentation settings cache and generate derived files

> Location: `bin/build/tools/documentation.sh`

#### Arguments

- `--clean` - Flag. Optional. Clean everything and then exit.
--all | --stdin- Flag. Optional. Read function names from stdin for examination.
- `--fingerprint` - Flag. Optional. Use fingerprint to ensure results are up to date.
- `--source` - DirectoryList. Required. Lists of directories where functions are defined (`:`-separated)
- `--key fingerprintKey` - String. Optional. Use this name to cache results in application JSON file if available.
- `functionName ...` - String. Optional. Specific functions to compile.

#### Reads standard input

Function. Name of functions, one per line to compile if `--all` is not specified.

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

