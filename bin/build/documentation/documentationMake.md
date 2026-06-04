### `documentationMake`

> Make documentation for Bash functions

#### Usage

    documentationMake [ --clean ] --template templateDirectory --source sourceDirectory --target targetDirectory [ --help ]

Must faster than `documentationBuild` and intended to replace it.

Uses cached files at `BUILD_DOCUMENTATION_PATH`, assumes documentation cache structure:

- `$docHome/functionName.md` - Markdown documentation
- `$docHome/SEE/functionName.md` - Markdown documentation for `{SEE:functionName}`
- `$docHome/functionName.sh` - `functionName` settings
- `$docHome/env/environmentName.md` - Markdown documentation for `environmentName` environment variable
- `$docHome/env/environmentName.sh` - `environmentName` environment variable settings
- `$docHome/env/more/environmentName.md` - Additional Markdown documentation for `environmentName` environment variable
- `$docHome/SEE/environmentName.md` - See link to `environmentName`

> Location: `bin/build/tools/documentation.sh`

#### Arguments

- `--clean` - Flag. Optional. Erase the cache before starting.
- `--template templateDirectory` - Directory. Required. Location of additional documentation template files to generate documentation.
- `--source sourceDirectory` - Directory. Required. Location of documentation source markdown.
- `--target targetDirectory` - Directory. Required. Location of documentation build target.
- `--help` - Flag. Optional. Display this help.

#### Return codes

- `0` - Success
- `1` - Issue with environment
- `2` - Argument error

