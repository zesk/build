## `stringOffsetInsensitive`

> Outputs the integer offset of `needle` if found as substring

### Usage

    stringOffsetInsensitive needle haystack

Outputs the integer offset of `needle` if found as substring in `haystack` (case-insensitive)
If `haystack` is not found, -1 is output

### Arguments

- `needle` - String. Required.
- `haystack` - String. Required.

### Writes to standard output

`Integer`. The offset at which the `needle` was found in `haystack`. Outputs -1 if not found.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

