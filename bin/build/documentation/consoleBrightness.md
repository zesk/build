## `consoleBrightness`

> Output the brightness of the background color of the console as a number between 0 and 100

### Usage

    consoleBrightness [ --foreground ] [ --background ]

Fetch the brightness of the console using `consoleGetColor`

### Arguments

- `--foreground` - Flag. Optional. Get the console text color.
- `--background` - Flag. Optional. Get the console background color.

### Sample Output

Integer. between 0 and 100.

### Return codes

- `0` - Success
- `1` - A problem occurred with `consoleGetColor`

