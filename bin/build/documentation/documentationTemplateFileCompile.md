## `documentationTemplateFileCompile`

> Convert a template file to a documentation file using templates

### Usage

    documentationTemplateFileCompile [ --env-file envFile ] [ --md-cache markdownCacheDirectory ] cacheDirectory sourceFile functionTemplate targetFile [ --help ]

Convert a template which contains bash functions into full-fledged documentation.
The process:
1. `documentTemplate` is scanned for tokens which are assumed to represent Bash functions
1. `functionTemplate` is used to generate the documentation for each function
1. Functions are looked up in `cacheDirectory` using indexing functions and
1. Template used to generate documentation and compiled to `targetFile`
`cacheDirectory` is required - build an index using `documentationIndexIndex` prior to using this.

### Arguments

- `--env-file envFile` - File. Optional. One (or more) environment files used to map `documentTemplate` prior to scanning, as defaults prior to each function generation, and after file generation.
- `--md-cache markdownCacheDirectory` - Directory. Optional. Cache directory where the markdown cache is stored.
- `cacheDirectory` - Directory. Required. Cache directory where the indexes live.
- `sourceFile` - File. Directory. Required. The document template containing functions to define
- `functionTemplate` - File. Required. The template for individual functions defined in the `documentTemplate`.
- `targetFile` - FileDirectory. Required. Target file to generate
- `--help` - Flag. Optional. Display this help.

### Return codes

- `0` - If success
- `1` - Issue with file generation
- `2` - Argument error

