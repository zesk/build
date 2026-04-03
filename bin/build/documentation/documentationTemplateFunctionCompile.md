## `documentationTemplateFunctionCompile`

> Generate a function documentation block using `functionTemplate` for `functionName`

### Usage

    documentationTemplateFunctionCompile [ --env-file envFile ] functionName functionTemplate [ --help ]

Requires function indexes to be generated in the documentation cache.
Generate documentation for a single function.
Template is output to stdout.

### Arguments

- `--env-file envFile` - File. Optional. One (or more) environment files used during map of `functionTemplate`
- `functionName` - Required. The function name to document.
- `functionTemplate` - Required. The template for individual functions.
- `--help` - Flag. Optional. Display this help.

### Return codes

- `0` - If success
- `1` - Issue with file generation
- `2` - Argument error

