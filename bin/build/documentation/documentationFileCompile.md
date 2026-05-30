## `documentationFileCompile`

> Extract and build the documentation settings cache

### Usage

    documentationFileCompile [ --clean ] [ --git ] [ --all ] --source sourcePath [ --derive command ... -- ] [ functionName ... ] [ --help ]

Extract and build the documentation settings cache

> Location: `bin/build/tools/documentation.sh`

### Arguments

- `--clean` - Flag. Optional. Clean everything and then exit.
- `--git` - Flag. Optional. Do some handy `git` changes. (Adding/removing files)
- `--all` - Flag. Optional. Do everything regardless of cache state.
- `--source sourcePath` - Directory. Required. Find function source code definition in this directory.
- `--derive command ... --` - CommandList. Optional. Run this command on each changed settings file to generate derived files.
- `functionName ...` - String. Optional. Specific functions to compile.
- `--help` - Flag. Optional. Display this help.

### Reads standard input

functionName - File with function names one per line.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

