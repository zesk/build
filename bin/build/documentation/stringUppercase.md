## `stringUppercase`

> Convert text to uppercase

### Usage

    stringUppercase [ -- ] [ --help ] text

Convert text to uppercase

### Arguments

- `--` - Flag. Optional. Stops command processing to enable arbitrary text to be passed as additional arguments without special meaning.
- `--help` - Flag. Optional. Display this help.
- `text` - EmptyString. Required. text to convert to uppercase

### Writes to standard output

`String`. The stringUppercase version of the `text`.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Requires

tr

