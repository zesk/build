## `decorate pair`

> Output a name value pair (decorate extension)

### Usage

    decorate pair [ characterWidth ] name [ value ... ]

The name is output left-aligned to the `characterWidth` given and colored using `decorate label`; the value colored using `decorate value`.

### Arguments

- `characterWidth` - UnsignedInteger. Optional. Number of characters to format the value for spacing. Uses environment variable BUILD_PAIR_WIDTH if not set.
- `name` - String. Required. Name to output
- `value ...` - String. Optional. One or more Values to output as values for `name` (single line)

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Environment

- {SEE:BUILD_PAIR_WIDTH.sh}

