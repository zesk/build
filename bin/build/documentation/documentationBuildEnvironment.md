## `documentationBuildEnvironment`

> Build documentation for ./bin/env (or bin/build/env) directory.

### Usage

    documentationBuildEnvironment [ --documentation documentationPath ] [ --source sourcePath ] [ --help ]

Build documentation for ./bin/env (or bin/build/env) directory.
Creates a cache at `documentationBuildCache`

### Arguments

- `--documentation documentationPath` - Directory. Optional. Path to documentation root. Default is `./documentation/source`.
- `--source sourcePath` - Directory. Optional. Path to source environment files. Defaults to `$(buildHome)/bin/env` if not specified.
- `--help` - Flag. Optional. Display this help.

### Return codes

- `0` - Success
- `1` - Issue with environment
- `2` - Argument error

