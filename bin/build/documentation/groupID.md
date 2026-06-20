### `groupID`

> Convert a group name to a group ID

#### Usage

    groupID groupName

Convert a group name to a group ID

> Location: `bin/build/tools/group.sh`

#### Arguments

- `groupName` - String. Required. Group name to convert to a group ID

#### Writes to standard output

`Integer`. One line for each group name passed as an argument.

#### Return codes

- `0` - All groups were found in the database and IDs were output successfully
- `1` - Any group is not found in the database.
- `2` - Argument errors (blank argument)

#### Requires

- {SEE:throwArgument}
- getent
- [`cut`]({rel}guide/command.md#cut)
- [`printf`]({rel}guide/builtin.md#printf)
- [bashDocumentation]({rel}tools/documentation.md#bashdocumentation) - Universal function documentation ([source](https://github.com/zesk/build/blob/main/bin/build/tools/usage.sh#L59))
- [decorate]({rel}tools/decorate.md#decorate) - decorate text using colors and styles ([source](https://github.com/zesk/build/blob/main/bin/build/tools/decorate/core.sh#L144))
- [`grep`]({rel}guide/command.md#grep)
- {SEE:quoteGrepPattern}

