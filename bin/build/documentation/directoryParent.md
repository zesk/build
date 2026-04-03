## `directoryParent`

> Finds a file above `startingDirectory`, uses `testExpression` to test (defaults

### Usage

    directoryParent startingDirectory --pattern filePattern [ --test testExpression ]

Finds a file above `startingDirectory`, uses `testExpression` to test (defaults to `-d`)

### Arguments

- `startingDirectory` - Required. EmptyString|RealDirectory. Uses the current directory if blank.
- `--pattern filePattern` - RelativePath. Required. The file or directory to find the home for.
- `--test testExpression` - String. Optional. Zero or more. The `test` argument to test the targeted `filePattern`. By default uses `-d`.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

