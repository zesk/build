## `documentationMaker`

> Generate documentation using source markdown and a mapping function.

### Usage

    documentationMaker [ --verbose ] [ --default defaultValue ] sourcePath [ targetPath ] [ mapFunction ... ]

Generate documentation using source markdown and a mapping function.

> Location: `bin/build/tools/documentation.sh`

### Arguments

- `--verbose` - Flag. Optional. Be wordy.
- `--default defaultValue` - EmptyString. Optional. Pass `--default` flag to `mapFunction`
- `sourcePath` - Exists. Required. File or directory to convert.
- `targetPath` - FileDirectory. Optional. Outputs to `stdout` if not specified, otherwise outputs mirror.
- `mapFunction ...` - Function. Optional. Mapping function to use, and any arguments.

### Return codes

- `0` - Success
- `1` - Template file not found

