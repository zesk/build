## `documentationFunctionCompile`

> - `--documentation` is required for `SEE:` files

### Usage

    documentationFunctionCompile [ --clean ] --source codeSource [ --documentation documentationSource ] [ --all ] [ --fingerprint ] [ functionName ... ]

- `--documentation` is required for `SEE:` files

> Location: `bin/build/tools/documentation.sh`

### Arguments

- `--clean` - Flag. Optional. Clean everything and then exit.
- `--source codeSource` - Directory. Required. Code source to find functions.
- `--documentation documentationSource` - Directory. Documentation source to find documentation links.
- `--all` - Flag. Optional. Do everything regardless of cache state.
- `--fingerprint` - Flag. Optional. Use fingerprint to ensure results are up to date.
- `functionName ...` - String. Optional. Specific functions to compile.

### Reads standard input

functionName - File with function names one per line.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

