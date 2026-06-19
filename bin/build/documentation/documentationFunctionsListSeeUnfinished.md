### `documentationFunctionsListSeeUnfinished`

> List files with unresolved `SEE:` tokens in documentation path

#### Usage

    documentationFunctionsListSeeUnfinished [ --help ] path

Generate a list of files which have unresolved `SEE:` tokens in the documentation path.
Searches Markdown (`.md`) files a single level deep.

> Location: `bin/build/tools/documentation.sh`

#### Arguments

- `--help` - Flag. Optional. Display this help.
- `path` - Directory. Required. The documentation path to examine.

#### Writes to standard output

File

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

