# Cursor Tools

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

### `cursorGet` - Get the current cursor position

Get the current cursor position
Output is <x> <newline> <y> <newline>

- Location: `bin/build/tools/cursor.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `cursorSet` - Move the cursor to x y

Move the cursor to x y

- Location: `bin/build/tools/cursor.sh`

#### Arguments

- `x` - Required. UnsignedInteger. Column to place the cursor.
- `y` - Required. UnsignedInteger. Row to place the cursor.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
