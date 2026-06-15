### `jsonField`

> Fetch a non-blank field from a JSON file with error

#### Usage

    jsonField [ --help ] handler jsonFile [ ... ]

Fetch a non-blank field from a JSON file with error handling



> Location: `bin/build/tools/json.sh`

#### Arguments

- `--help` - Flag. Optional. Display this help.
- `handler` - Function. Required. Error handler.
- `jsonFile` - File. Required. A JSON file to parse
- `...` - Arguments. Optional. Passed directly to jq

#### Reads standard input

{stdin}

#### Writes to standard output

selected field


#### Writes to standard error

error messages


#### Debugging settings

Append to the value of `BUILD_DEBUG` (a comma-delimited (`,`) list) and add these tokens to enable debugging:

{build_debug}

#### Examples

{example}

#### Sample Output

{output}

#### Return codes

- `0` - Field was found and was non-blank
- `1` - Field was not found or is blank

#### Local cache

{local_cache}

#### Environment

{environment}

#### Requires

- jq
- - [executableExists]({rel}tools/bash.md#executableexists) - Does a binary exist in the PATH? ([source](https://github.com/zesk/build/blob/main/bin/build/tools/platform.sh#L175))- [throwEnvironment]({rel}tools/sugar-core.md#throwenvironment) - Run \`handler\` with an environment error ([source](https://github.com/zesk/build/blob/main/bin/build/tools/_sugar.sh#L226))[`printf`]({rel}/guide/builtin.md#printf)
- rm
- - [decorate]({rel}tools/decorate.md#decorate) - Singular decoration function ([source](https://github.com/zesk/build/blob/main/bin/build/tools/decorate/core.sh#L89))head

#### See Also

{see}

#### Credits

Thanks to [{credits}]({source}).

#### Review Status

File `bin/build/tools/json.sh`, function `jsonField` was reviewed {reviewed}.

#### Errors

{error}
