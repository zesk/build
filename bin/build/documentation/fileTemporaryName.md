### `fileTemporaryName`

> Wrapper for `mktemp`. Generate a temporary file name, and fail

#### Usage

    fileTemporaryName handler [ --help ] [ ... ]

Wrapper for `mktemp`. Generate a temporary file name, and fail using a function



> Location: `bin/build/tools/file.sh`

#### Arguments

- `handler` - Function. Required. Function to call on failure. Function Type: returnMessage
- `--help` - Flag. Optional. Display this help.
- `...` - Arguments. Optional. Any additional arguments are passed through.

#### Reads standard input

{stdin}

#### Writes to standard output

{stdout}

#### Writes to standard error

{stderr}

#### Debugging settings

Append to the value of `BUILD_DEBUG` (a comma-delimited (`,`) list) and add these tokens to enable debugging:

- `temp` - Logs backtrace of all temporary files to a file in application root named after this function to detect and clean up leaks

#### Examples

{example}

#### Sample Output

{output}

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Local cache

{local_cache}

#### Environment

- [`BUILD_DEBUG` Debugging Flag]({rel}env/#build_configuration) – **CommaDelimitedList**. Constant for turning debugging on during build to find errors

#### Requires

- mktemp

#### See Also

{see}

#### Credits

Thanks to [{credits}]({source}).

#### Review Status

File `bin/build/tools/file.sh`, function `fileTemporaryName` was reviewed {reviewed}.

#### Errors

{error}
