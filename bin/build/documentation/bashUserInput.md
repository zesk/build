## `bashUserInput`

> Prompt the user properly honoring any attached console.

### Usage

    bashUserInput [ --help ] [ ... ]

Prompt the user properly honoring any attached console.
Arguments are the same as `read`, except:
`-r` is implied and does not need to be specified

### Arguments

- `--help` - Flag. Optional. Display this help.
- `...` - Arguments. Optional. Identical arguments to `read` (but includes `-r`)

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

