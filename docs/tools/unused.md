# Unused functions

Hides these from [New and uncategorized functions](./todo.md)

### `consoleBlackBackground` - undocumented

No documentation for `consoleBlackBackground`.

- Location: `bin/build/tools/colors.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error























#############################################################################

  ▄▄      ▗▄▖
 █▀▀▌     ▝▜▌
▐▛    ▟█▙  ▐▌   ▟█▙  █▟█▌▗▟██▖
▐▌   ▐▛ ▜▌ ▐▌  ▐▛ ▜▌ █▘  ▐▙▄▖▘
▐▙   ▐▌ ▐▌ ▐▌  ▐▌ ▐▌ █    ▀▀█▖
 █▄▄▌▝█▄█▘ ▐▙▄ ▝█▄█▘ █   ▐▄▄▟▌
  ▀▀  ▝▀▘   ▀▀  ▝▀▘  ▀    ▀▀▀

Reset the color

This is typically appended after most `consoleAction` calls to reset the state of the console to default color and style.

It does *not* take the optional `-n` argument ever, and outputs the reset escape sequence to standard out.

- Location: `bin/build/tools/colors.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error







### `exampleFunction` - This is a sample function with example code and patterns

This is a sample function with example code and patterns used in Zesk Build.

- Location: `bin/build/tools/example.sh`

#### Arguments

- `--help` - Optional. Flag. Display this help.
- `--easy` - Optional. Flag. Easy mode.
- `binary` - Required. String. The binary to look for.
- `remoteUrl` - Required. URL. Remote URL.
- `--target target` - Optional. File. File to create. File must exist.
- `--path path` - Optional. Directory. Directory of path of thing.
- `--title title` - Optional. String. Title of the thing.
- `--name name` - Optional. String. Name of the thing.
- `--url url` - Optional. URL. URL to download.
- `--callable callable` - Optional. Callable. Function to call when url is downloaded.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
