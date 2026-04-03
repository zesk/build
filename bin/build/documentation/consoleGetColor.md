## `consoleGetColor`

> Get the console foreground or background color

### Usage

    consoleGetColor [ --foreground ] [ --background ]

Gets the RGB console color using an `xterm` escape sequence supported by some terminals. (usually for background colors)

### Arguments

- `--foreground` - Flag. Optional. Get the console text color.
- `--background` - Flag. Optional. Get the console background color.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

