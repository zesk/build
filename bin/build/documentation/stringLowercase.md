## `stringLowercase`

> Convert text to stringLowercase

### Usage

    stringLowercase [ -- ] [ --help ] text

Convert text to stringLowercase

### Arguments

- `--` - Flag. Optional. Stops command processing to enable arbitrary text to be passed as additional arguments without special meaning.
- `--help` - Flag. Optional. Display this help.
- `text` - EmptyString. Required. Text to convert to stringLowercase

### Writes to standard output

`String`. The stringLowercase version of the `text`.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Requires

- tr

