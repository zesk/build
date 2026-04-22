## `buildFunctionsDerivedCompile`

> Extract and build the documentation settings cache and generate derived

### Usage

    buildFunctionsDerivedCompile [ --clean ] [ --git ] [ --all ] [ --fingerprint ]

Extract and build the documentation settings cache and generate derived files

### Arguments

- `--clean` - Flag. Optional. Clean everything and then exit.
- `--git` - Flag. Optional. Do some handy `git` changes. (Adding/removing files)
- `--all` - Flag. Optional. Do everything regardless of cache state.
- `--fingerprint` - Flag. Optional. Use fingerprint to ensure results are up to date.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

