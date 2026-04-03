## `tools`

> Run a Zesk Build command or load it

### Usage

    tools [ --help ] [ --start startDirectory ] [ --verbose ] [ ... ]

Run a Zesk Build command or load it

### Arguments

- `--help` - Flag. Optional. Display this help.
- `--start startDirectory` - Directory. Optional. Start searching for a build installation at this location and searching upwards in the file hierarchy.
- `--verbose` - Flag. Optional. Be verbose.
- `...` - Callable. Optional. Run this command after loading in the current build context.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

