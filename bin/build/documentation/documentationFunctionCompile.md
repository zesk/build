### `documentationFunctionCompile`

> Build function documentation

#### Usage

    documentationFunctionCompile [ --force ] [ --clean ] --source codeSource [ --documentation documentationSource ] [ --all ] [ --fingerprint ] [ functionName ... ]

Extract and build the documentation settings cache and generate derived files:

- `--documentation` is required for `SEE:` files

Internally calls `documentationFileCompile`.

> Location: `bin/build/tools/documentation.sh`

#### Arguments

- `--force` - Flag. Optional. Create files regardless of cache status.
- `--clean` - Flag. Optional. Clean everything and then exit.
- `--source codeSource` - DirectoryList. Required. Code source to find functions.
- `--documentation documentationSource` - Directory. Documentation source to find documentation links.
- `--all` - Flag. Optional. Check all functions.
- `--fingerprint` - Flag. Optional. Use fingerprint to ensure results are up to date.
- `functionName ...` - String. Optional. Specific functions to compile.

#### Reads standard input

functionName - File with function names one per line.

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### See Also

- [documentationFileCompile]({rel}tools/documentation.md#documentationfilecompile) - Extract and build the documentation settings cache ([source](https://github.com/zesk/build/blob/main/bin/build/tools/documentation.sh#L660))

