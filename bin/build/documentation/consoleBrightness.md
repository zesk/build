### `consoleBrightness`

> Output the brightness of the background color of the console as a number between 0 and 100

#### Usage

    consoleBrightness [ --foreground ] [ --background ]

Fetch the brightness of the console using `consoleGetColor`

> Location: `bin/build/tools/console.sh`

#### Arguments

- `--foreground` - Flag. Optional. Get the console text color.
- `--background` - Flag. Optional. Get the console background color.

#### Sample Output

Integer. between 0 and 100.

#### Return codes

- `0` - Success
- `1` - A problem occurred with `consoleGetColor`

#### See Also

- [consoleGetColor]({rel}tools/console.md#consolegetcolor) - Get the console foreground or background color ([source](https://github.com/zesk/build/blob/main/bin/build/tools/console.sh#L18))

