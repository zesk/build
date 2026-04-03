## `cursorGet`

> Get the current cursor position

### Usage

    cursorGet

Get the current cursor position
Output is <x> <newline> <y> <newline>

### Arguments

- none

### Writes to standard output

UnsignedInteger

### Examples

    IFS=$'\n' read -r -d '' saveX saveY < <(cursorGet)

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

