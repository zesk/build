## `documentationFunctionCompile`

> Extract and build the documentation settings cache and generate derived

### Usage

    documentationFunctionCompile [ --clean ] [ --git ] [ --all ] [ --fingerprint ] [ functionName ... ]

Extract and build the documentation settings cache and generate derived files

> Location: `bin/build/tools/documentation.sh`

### Arguments

- `--clean` - Flag. Optional. Clean everything and then exit.
- `--git` - Flag. Optional. Do some handy `git` changes. (Adding/removing files)
- `--all` - Flag. Optional. Do everything regardless of cache state.
- `--fingerprint` - Flag. Optional. Use fingerprint to ensure results are up to date.
- `functionName ...` - String. Optional. Specific functions to compile.

### Reads standard input

functionName - File with function names one per line.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

