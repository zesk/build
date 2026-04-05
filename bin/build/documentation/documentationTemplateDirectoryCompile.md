## `documentationTemplateDirectoryCompile`

> Convert a directory of templates into documentation for Bash functions

### Usage

    documentationTemplateDirectoryCompile [ --filter filterArgs ... --  ] [ --force ] [ --verbose ] [ --env-file envFile ] [ --md-cache markdownCacheDirectory ] cacheDirectory templateDirectory functionTemplate targetDirectory [ --help ]

Convert a directory of templates for bash functions into full-fledged documentation.
The process:
1. `templateDirectory` is scanned for files which look like `*.md`
1. `documentationTemplateDirectoryCompile` is called for each one
If the `cacheDirectory` is supplied, it's used to store values and hashes of the various files to avoid having
to regenerate each time.

### Arguments

- `--filter filterArgs ... -- ` - Arguments. Optional. Passed to `find` and allows filtering list.
- `--force` - Flag. Optional. Force generation of files.
- `--verbose` - Flag. Optional. Output more messages.
- `--env-file envFile` - File. Optional. One (or more) environment files used during map of `functionTemplate`
- `--md-cache markdownCacheDirectory` - Directory. Optional. Cache directory where the markdown cache is stored.
- `cacheDirectory` - Required. The directory where function index exists and additional cache files can be stored.
- `templateDirectory` - Required. Directory containing documentation templates
- `functionTemplate` - Required. Function template file to generate documentation for functions
- `targetDirectory` - Required. Directory to create generated documentation
- `--help` - Flag. Optional. Display this help.

### Return codes

- `0` - If success
- `1` - Any template file failed to generate for any reason
- `2` - Argument error

