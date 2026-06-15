### `mapFunction`

> Convert tokens in input to values

#### Usage

    mapFunction [ --env-file envFile ] [ --default defaultString ] [ --prefix prefixString ] [ --suffix suffixString ]  mapFunction ... [ --help ]

Map tokens in the input stream based on some heuristic.

Converts tokens in the form `{VARIABLE}` to the associated value.

Undefined values are not converted.

`mapFunction` should return non-zero to have the default behavior occur. If a zero exit code is output then some replacement value is assumed to be written to `stdout` by the `mapFunction`.
The special return code 120 is used to terminate the calling function immediately.



> Location: `bin/build/tools/map.sh`

#### Arguments

- `--env-file envFile` - File. Optional. Load this environment file prior to processing input.
- `--default defaultString` - String. Optional. Default string for tokens. Can use additional tokens: `{prefix}` `{suffix}` `{tokenName}` and ``. Set to `--` to output `token`.
- `--prefix prefixString` - String. Optional. Prefix character for tokens, defaults to `{`.
- `--suffix suffixString` - String. Optional. Suffix character for tokens, defaults to `}`.
- ` mapFunction ...` - Function. Required. Replacement function with arguments. Called as is with three additional arguments: `tokenName` `offset` `total`
- `--help` - Flag. Optional. Display this help.

#### Reads standard input

{stdin}

#### Writes to standard output

{stdout}

#### Writes to standard error

{stderr}

#### Debugging settings

Append to the value of `BUILD_DEBUG` (a comma-delimited (`,`) list) and add these tokens to enable debugging:

{build_debug}

#### Examples

{example}

#### Sample Output

{output}

#### Return codes

- `120` - Map function exited early
- `130` - User interrupt (exits early)
- `141` - System interrupt (exits early)

#### Local cache

{local_cache}

#### Environment

{environment}

#### Requires

- cat

#### See Also

- [mapValue]({rel}tools/map.md#mapvalue) - Maps a string using an environment file ([source](https://github.com/zesk/build/blob/main/bin/build/tools/map.sh#L155))[mapEnvironment]({rel}tools/map.md#mapenvironment) - Convert tokens in files to environment variable values ([source](https://github.com/zesk/build/blob/main/bin/build/tools/map.sh#L259))

#### Credits

Thanks to [{credits}]({source}).

#### Review Status

File `bin/build/tools/map.sh`, function `mapFunction` was reviewed {reviewed}.

#### Errors

{error}
