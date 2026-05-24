## `contextOpen`

> Open a file in a shell using the program we

### Usage

    contextOpen [ --help ]

Open a file in a shell using the program we are using. Supports VSCode and PHPStorm.

> Location: `bin/build/tools/vendor.sh`

### Arguments

- `--help` - Flag. Optional. Display this help.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Environment

- {SEE:EDITOR} - Used as a default editor (first)
- {SEE:VISUAL} - Used as another default editor (last)

