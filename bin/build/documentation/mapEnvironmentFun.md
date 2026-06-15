### `mapEnvironmentFun`

> Convert tokens in files to environment variable values

#### Usage

    mapEnvironmentFun [ environmentName ] [ --env-file envFile ] [ --prefix ] [ --suffix ] [ --help ]

Map tokens in the input stream based on environment values with the same names.
Converts tokens in the form `{ENVIRONMENT_VARIABLE}` to the associated value.
Undefined values are not converted.
Uses environment variables passed as arguments or entire exported environment variables are used and mapped to the destination.



> Location: `bin/build/tools/map.sh`

#### Arguments

- `environmentName` - String. Optional. Map this value only. If not specified, all environment variables are mapped.
- `--env-file envFile` - File. Optional. Load this environment file prior to processing input.
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



#### See Also

- [mapEnvironment]({rel}tools/map.md#mapenvironment) - Convert tokens in files to environment variable values ([source](https://github.com/zesk/build/blob/main/bin/build/tools/map.sh#L259))- [mapValue]({rel}tools/map.md#mapvalue) - Maps a string using an environment file ([source](https://github.com/zesk/build/blob/main/bin/build/tools/map.sh#L155))

#### Credits

Thanks to [{credits}]({source}).

#### Review Status

File `bin/build/tools/map.sh`, function `mapEnvironmentFun` was reviewed {reviewed}.

#### Errors

{error}
