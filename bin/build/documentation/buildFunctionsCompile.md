## `buildFunctionsCompile`

> Extract and build the documentation settings cache

### Usage

    buildFunctionsCompile [ --clean ] [ --git ] [ --all ] [ --derive command ... -- ] [ --help ]

Extract and build the documentation settings cache

### Arguments

- `--clean` - Flag. Optional. Clean everything and then exit.
- `--git` - Flag. Optional. Do some handy `git` changes. (Adding/removing files)
- `--all` - Flag. Optional. Do everything regardless of cache state.
- `--derive command ... --` - CommandList. Optional. Run this command on each changed settings file to generate derived files.
- `--help` - Flag. Optional. Display this help.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

