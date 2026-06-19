### `documentationFunctionsSeeLoop`

> Interactively watch count of unresolved `SEE:` tokens in documentation

#### Usage

    documentationFunctionsSeeLoop [ --help ] path

Runs an infinite loop in the console until there are zero unresolved `SEE:` tokens in the documentation path.
Searches Markdown (`.md`) files a single level deep.
You can fix tokens by running `documentationFunctionsCompile` or building the documentation which usually updates environment templates.
Delays 10 seconds between checks.

> Location: `bin/build/tools/documentation.sh`

#### Arguments

- `--help` - Flag. Optional. Display this help.
- `path` - Directory. Required. The documentation path to examine.

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

