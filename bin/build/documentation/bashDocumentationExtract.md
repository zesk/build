### `bashDocumentationExtract`

> Extract documentation from bash commentsGenerate a set of name/value pairs to document bash entities

#### Usage

    bashDocumentationExtract [ --generate ] [ --no-cache | --cache ] [ --help ] [ --function | --environment ] itemName sourceFile [ sourceLine ]
    
Extract documentation variables from a comment stripped of the `# ` prefixes.

A few special values are generated/computed:

- `description` - Any line in the comment which is not in variable is appended to the field `description`
- `original` - `itemName` unmodified
- `fn` - The function name (no parenthesis or anything) (can be changed from `itemName`)
- `base` - The basename of the file
- `file` - The relative path name of the file from the application root
- `summary` - Defaults to first ten words of `description`
- `exit_code` - Defaults to standard value
- `reviewed`  - No default
- `environment"  - No default
- `usage` - Computed based on arguments

Otherwise the assumed variables (in addition to above) to define functions are:

- `argument` - Individual arguments
- `example` - An example of usage (code, many)
- `depends` - Any dependencies (list)

> Location: `bin/build/tools/documentation.sh`

#### Arguments

- `itemName` - String. Required. Name of item we are documenting. Usually a function name or environment variable name.
- `sourceFile` - File. Required.
- `sourceLine` - PositiveInteger. Optional. The line in the source file where the item is defined.
- `--generate` - Flag. Optional. Generate cached files.
- `--no-cache` - Flag. Optional. Skip any attempt to cache anything.
- `--cache` - Flag. Optional. Force use of cache.
- `--function` - Flag. Optional. Function derivations `return_code` `fn` `lowerFn` `fnMarker` `argument` `usage`
- `--environment` - Flag. Optional. Environment variable derivations `env` `envMarker`
- `--help` - Flag. Optional. Display this help.

#### Reads standard input

Pipe stripped comments to extract information

#### Debugging settings

Append to the value of `BUILD_DEBUG` (a comma-delimited (`,`) list) and add these tokens to enable debugging:

- `usage-cache-skip` - Skip caching by default (override with `--cache`)

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### See Also

- [bashFunctionComment]({rel}tools/bash.md#bashfunctioncomment) - Output the comment for a function in a file ([source](https://github.com/zesk/build/blob/main/bin/build/tools/bash.sh#L631))
- [bashFirstComment]({rel}tools/bash.md#bashfirstcomment) - Extract first comment from a stream ([source](https://github.com/zesk/build/blob/main/bin/build/tools/bash.sh#L588))

