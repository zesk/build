### `mapEnvironment`

> Convert tokens in files to environment variable values

#### Usage

    mapEnvironment [ environmentVariableName ] [ --prefix ] [ --suffix ] [ --help ]

Map tokens in the input stream based on environment values with the same names.
Converts tokens in the form `{ENVIRONMENT_VARIABLE}` to the associated value.
Undefined values are not converted.
This one does it like `mapValue`
Environment is accessed via arguments passed or entire exported environment value space are and mapped to the destination.



> Location: `bin/build/tools/map.sh`

#### Arguments

- `environmentVariableName` - String. Optional. Map this value only. If not specified, all environment variables are mapped.
- `--prefix` - String. Optional. Prefix character for tokens, defaults to `{`.
- `--suffix` - String. Optional. Suffix character for tokens, defaults to `}`.
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

    printf %s "{NAME}, {PLACE}.\n" | NAME=Hello PLACE=world mapEnvironment NAME PLACE


#### Sample Output

{output}

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Local cache

{local_cache}

#### Environment

{environment}

#### Requires

- - [environmentVariables]({rel}tools/environment.md#environmentvariables) - Output a list of environment variables and ignore function definitions ([source](https://github.com/zesk/build/blob/main/bin/build/tools/environment.sh#L130))cat

#### See Also

- [mapValue]({rel}tools/map.md#mapvalue) - Maps a string using an environment file ([source](https://github.com/zesk/build/blob/main/bin/build/tools/map.sh#L155))

#### Credits

Thanks to [{credits}]({source}).

#### Review Status

File `bin/build/tools/map.sh`, function `mapEnvironment` was reviewed {reviewed}.

#### Errors

{error}
