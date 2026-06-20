### `documentationMaker`

> Generate documentation using source markdown and a mapping function.

#### Usage

    documentationMaker [ --verbose ] [ --default defaultValue ] [ sourcePath ] [ targetPath ] [ mapFunction ... ]

Generate documentation using source markdown and a mapping function.

Tokens are mapped to template paths in `BUILD_DOCUMENTATION_PATH.

> Location: `bin/build/tools/documentation.sh`

#### Arguments

- `--verbose` - Flag. Optional. Be wordy.
- `--default defaultValue` - EmptyString. Optional. Pass `--default` flag to `mapFunction`
- `sourcePath` - Exists. Optional. File or directory to convert. Reads from `stdin` if not provided.
- `targetPath` - FileDirectory. Optional. Outputs to `stdout` if not specified, otherwise outputs mirror.
- `mapFunction ...` - Function. Optional. Mapping function to use, and any arguments.

#### Reads standard input

Text

#### Writes to standard output

Text. Tokens are mapped to template paths in `BUILD_DOCUMENTATION_PATH

#### Return codes

- `0` - Success
- `1` - Template file not found

#### See Also

- [`BUILD_DOCUMENTATION_PATH` Build Documentation Path List]({rel}env/#bash) – **DirectoryList**. Search path for documentation settings file.

