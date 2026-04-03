## `bashDocumentationExtract`

> Generate a set of name/value pairs to document bash functions

### Usage

    bashDocumentationExtract [ --generate ] [ --no-cache | --cache ] [ --help ] handler function sourceFile
    
Extract documentation variables from a comment stripped of the '# ' prefixes.
A few special values are generated/computed:
- `description` - Any line in the comment which is not in variable is appended to the field `description`
- `fn` - The function name (no parenthesis or anything)
- `base` - The basename of the file
- `file` - The relative path name of the file from the application root
- `summary` - Defaults to first ten words of `description`
- `exit_code` - Defaults to `0 - Always succeeds`
- `reviewed`  - Defaults to `Never`
- `environment"  - Defaults to `No environment dependencies or modifications.`
Otherwise the assumed variables (in addition to above) to define functions are:
- `argument` - Individual arguments
- `usage` - Canonical usage example (code)
- `example` - An example of usage (code, many)
- `depends` - Any dependencies (list)

### Arguments

- `handler` - Function. Required.
- `function` - String. Required.
- `sourceFile` - File. Required.
- `--generate` - Flag. Optional. Generate cached files.
- `--no-cache` - Flag. Optional. Skip any attempt to cache anything.
- `--cache` - Flag. Optional. Force use of cache.
- `--help` - Flag. Optional. Display this help.

### Reads standard input

Pipe stripped comments to extract information

### Debugging settings

Append to the value of `BUILD_DEBUG` (a comma-delimited (`,`) list) and add these tokens to enable debugging:

- `usage-cache-skip` - Skip caching by default (override with `--cache`)

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

