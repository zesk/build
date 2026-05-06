## `documentationIndexGenerate`

> Generate a function index for bash files.

### Usage

    documentationIndexGenerate codePath ... [ --target targetPath ] [ --verbose ]

Generate a function index for bash files.

> Location: `bin/build/tools/documentation.sh`

### Arguments

- `codePath ...` - Directory. Required. OneOrMore. Path where code (`.sh` files) is stored (should remain identical between invocations)
- `--target targetPath` - Optional. Location to store the index file, called `code.index`.
- `--verbose` - Flag. Optional. Talk voluminously.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Requires

- {SEE:__pcregrep}

### See Also

- {SEE:__documentationIndexLookup}

