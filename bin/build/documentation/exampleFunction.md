## `exampleFunction`

> This is a sample function with example code and patterns

### Usage

    exampleFunction [ --help ] [ --handler handler ] [ --easy ] binary remoteUrl [ --target target ] [ --path path ] [ --title title ] [ --name name ] [ --url url ] [ --callable callable ] [ -- ]

This is a sample function with example code and patterns used in Zesk Build.
Without arguments, displays help.

### Arguments

- `--help` - Flag. Optional. Display this help.
- `--handler handler` - Function. Optional. Use this error handler instead of the default error handler.
- `--easy` - Flag. Optional. Easy mode.
- `binary` - String. Required. The binary to look for.
- `remoteUrl` - URL. Required. Remote URL.
- `--target target` - File. Optional. File to create. File must exist.
- `--path path` - Directory. Optional. Directory of path of thing.
- `--title title` - String. Optional. Title of the thing.
- `--name name` - String. Optional. Name of the thing.
- `--url url` - URL. Optional. URL to download.
- `--callable callable` - Callable. Optional. Function to call when url is downloaded.
- `--` - Flag. Optional. Stops command processing to enable arbitrary text to be passed as additional arguments without special meaning.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

