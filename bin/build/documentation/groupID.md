## `groupID`

> Convert a group name to a group ID

### Usage

    groupID groupName

Convert a group name to a group ID

### Arguments

- `groupName` - String. Required. Group name to convert to a group ID

### Writes to standard output

`Integer`. One line for each group name passed as an argument.

### Return codes

- `0` - All groups were found in the database and IDs were output successfully
- `1` - Any group is not found in the database.
- `2` - Argument errors (blank argument)

### Requires

throwArgument getent cut printf bashDocumentation decorate grep  quoteGrepPattern

