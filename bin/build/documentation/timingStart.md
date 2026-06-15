### `timingStart`

> Start a timer

#### Usage

    timingStart [ --help ]

Outputs the offset in milliseconds from midnight UTC January 1, 1970.

Only fails if `date` is not installed



> Location: `bin/build/tools/timing.sh`

#### Arguments

- `--help` - Flag. Optional. Display this help.

#### Reads standard input

{stdin}

#### Writes to standard output

UnsignedInteger


#### Writes to standard error

{stderr}

#### Debugging settings

Append to the value of `BUILD_DEBUG` (a comma-delimited (`,`) list) and add these tokens to enable debugging:

{build_debug}

#### Examples

    init=$(timingStart)
    ...
    timingReport "$init" "Completed in"
    start=$(timingStart) {example}{example} printf "%d\n" "$start"
    1777501474602


#### Sample Output

1777501474602


#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Local cache

{local_cache}

#### Environment

{environment}

#### Requires

- __timestamp,
- - [returnEnvironment]({rel}tools/sugar-core.md#returnenvironment) - Return \`environment\` error code. Outputs \`message ...\` to \`stderr\`. ([source](https://github.com/zesk/build/blob/main/bin/build/tools/_sugar.sh#L265))date

#### See Also

{see}

#### Credits

Thanks to [{credits}]({source}).

#### Review Status

File `bin/build/tools/timing.sh`, function `timingStart` was reviewed {reviewed}.

#### Errors

{error}
