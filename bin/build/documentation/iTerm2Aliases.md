## `iTerm2Aliases`

> Installs iTerm2 aliases which are:

### Usage

    iTerm2Aliases [ --help ]

Installs iTerm2 aliases which are:
- `it2check` - Check compatibility of these scripts (non-zero exit means non-compatible)
- `imgcat` - Take an image file and output it to the console
- `imgls` - List a directory and show thumbnails (in the console)
- `it2attention` - Get attention from the operator
- `it2getvar` - Get a variable value
- `it2dl` - Download a file to the operator system's configured download folder
- `it2ul` - Upload a file from the operator system to the remote
- `it2copy` - Copy to clipboard from file or stdin
- `it2setcolor` - Set console colors interactively
- `it2setkeylabel` - Set key labels interactively
- `it2universion` - Set, push, or pop Unicode version
Internally supported:
- `imgcat` = `iTerm2Image`
- `it2attention` - `iTerm2Attention`
- `it2dl` - `iTerm2Download`
- `it2setcolor` - `iTerm2SetColors`

### Arguments

- `--help` - Flag. Optional. Display this help.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

