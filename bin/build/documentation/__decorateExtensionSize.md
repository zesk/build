### `decorate size`

> Size converted to kilo, mega, giga bytes.

#### Usage

    decorate size [ size ]

Size converted to kilo, mega, giga bytes.

> Location: `bin/build/tools/decorate/size.sh`

#### Arguments

- `size` - UnsignedInteger. Optional. Size to display.

#### Examples

    > decorate size 169204
    165k (169204)
    > decorate size 16920400232
    15G (16920400232)

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Requires

- [`printf`]({rel}guide/builtin.md#printf)
- {SEE:decorate}
- {SEE:isUnsignedInteger}

