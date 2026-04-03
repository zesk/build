## `documentationIndexDocumentation`

> Generate the documentation index (e.g. functions defined in the documentation)

### Usage

    documentationIndexDocumentation cacheDirectory [ documentationSource ... ] [ --help ]

Generate the documentation index (e.g. functions defined in the documentation)

### Arguments

- `cacheDirectory` - Required. Cache directory where the index will be created.
- `documentationSource ...` - OneOrMore. Documentation source path to find tokens and their definitions.
- `--help` - Flag. Optional. Display this help.

### Return codes

- `0` - If success
- `1` - Issue with file generation
- `2` - Argument error

