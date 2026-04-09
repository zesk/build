## `fileFieldMaximum`

> Given an input file, determine the maximum length of fieldIndex,

### Usage

    fileFieldMaximum fieldIndex [ separatorChar ]

Given an input file, determine the maximum length of fieldIndex, using separatorChar as a delimiter between fields
Defaults to first field (fieldIndex of `1`), space separator (separatorChar is ` `)

### Arguments

- `fieldIndex` - UnsignedInteger. Required. The field to compute the maximum length for
- `separatorChar` - String. Optional. The separator character to delineate fields. Uses space if not supplied.

### Reads standard input

Lines are read from standard in and line length is computed for each line

### Writes to standard output

`UnsignedInteger`

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

