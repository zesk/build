# Console Tools

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

### `isTTYAvailable` - Quiet test for a TTY.

Quiet test for a TTY.

- Location: `bin/build/tools/colors.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

- __BUILD_HAS_TTY - Cached value of `false` or `true`. Any other value forces computation during this call.
### `consoleGetColor` - Get the console foreground or background color

Gets the RGB console color using an `xterm` escape sequence supported by some terminals. (usually for background colors)

- Location: `bin/build/tools/console.sh`

#### Arguments

- `--foreground` - Optional. Flag. Get the console text color.
- `--background` - Optional. Flag. Get the console background color.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `consoleConfigureColorMode` - Print the suggested color mode for the current environment

Print the suggested color mode for the current environment

- Location: `bin/build/tools/console.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `consoleColumns` - Column count in current console

Column count in current console

Output the number of columns in the terminal. Default is 80 if not able to be determined from `TERM`.

- Location: `bin/build/tools/colors.sh`

#### Arguments

- No arguments.

#### Examples

    repeat $(consoleColumns)

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

Uses the `tput cols` tool to find the value if `TERM` is non-blank.
COLUMNS - May be defined after calling this
LINES - May be defined after calling this
### `consoleRows` - Row count in current console

Row count in current console

Output the number of columns in the terminal. Default is 60 if not able to be determined from `TERM`.

- Location: `bin/build/tools/colors.sh`

#### Arguments

- No arguments.

#### Examples

    tail -n $(consoleRows) "$file"

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

Uses the `tput lines` tool to find the value if `TERM` is non-blank.
COLUMNS - May be defined after calling this
LINES - May be defined after calling this
### `consoleBrightness` - Fetch the brightness of the console using `consoleGetColor`

Fetch the brightness of the console using `consoleGetColor`

- Location: `bin/build/tools/console.sh`

#### Arguments

- `--foreground` - Optional. Flag. Get the console text color.
- `--background` - Optional. Flag. Get the console background color.

#### Sample Output

    Integer. between 0 and 100.
    

#### Exit codes

- `0` - Success
- `1` - A problem occurred with `consoleGetColor`
### `consoleSetTitle` - Set the title of the window for the console

Set the title of the window for the console

- Location: `bin/build/tools/console.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `consoleDefaultTitle` - undocumented

No documentation for `consoleDefaultTitle`.

- Location: `bin/build/tools/console.sh`

#### Arguments

- None

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `consoleLink` - Output a hyperlink to the console

Output a hyperlink to the console
OSC 8 standard for terminals
No way to test ability, I think. Maybe `tput`.

- Location: `bin/build/tools/console.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `consoleFileLink` - Output a local file link to the console

Output a local file link to the console

- Location: `bin/build/tools/console.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `consoleLinksSupported` - Are console links (likely) supported?

Are console links (likely) supported?
Unfortunately there's no way to test for this feature currently

- Location: `bin/build/tools/console.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
