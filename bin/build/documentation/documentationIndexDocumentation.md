### `documentationIndexDocumentation`

> Generate the documentation index

#### Arguments

- `--target targetDirectory` - Directory. Optional. Directory where the index will be created. Uses `documentationCache` if not specified.
- `documentationSource ...` - Directory. OneOrMore. Documentation source path to find tokens and their definitions.
- `--verbose` - Flag. Optional. Extrapolate needlessly.
- `--help` - Flag. Optional. Display this help.

#### Return codes

- `0` - If success
- `1` - Issue with file generation
- `2` - Argument error

