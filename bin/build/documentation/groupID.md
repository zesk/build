### `groupID`

> Convert a group name to a group ID

#### Usage

    groupID groupName

Convert a group name to a group ID



> Location: `bin/build/tools/group.sh`

#### Arguments

- `groupName` - String. Required. Group name to convert to a group ID

#### Reads standard input

{stdin}

#### Writes to standard output

`Integer`. One line for each group name passed as an argument.


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

- `0` - All groups were found in the database and IDs were output successfully
- `1` - Any group is not found in the database.
- `2` - Argument errors (blank argument)

#### Local cache

{local_cache}

#### Environment

{environment}

#### Requires

- - [throwArgument]({rel}tools/sugar-core.md#throwargument) - Run \`handler\` with an argument error ([source](https://github.com/zesk/build/blob/main/bin/build/tools/_sugar.sh#L215))getent
- cut
- [`printf`]({rel}/guide/builtin.md#printf)
- - [bashDocumentation]({rel}tools/documentation.md#bashdocumentation) - Universal function documentation ([source](https://github.com/zesk/build/blob/main/bin/build/tools/usage.sh#L59))- [decorate]({rel}tools/decorate.md#decorate) - Singular decoration function ([source](https://github.com/zesk/build/blob/main/bin/build/tools/decorate/core.sh#L89))grep

#### See Also

{see}

#### Credits

Thanks to [{credits}]({source}).

#### Review Status

File `bin/build/tools/group.sh`, function `groupID` was reviewed {reviewed}.

#### Errors

{error}
