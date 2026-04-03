## `muzzleReturn`

> Suppress return codes

### Usage

    muzzleReturn command [ ... ]

Suppress return code without piping. Handy when using diff to generate text

### Arguments

- `command` - Callable. Required. Thing to muzzle.
- `...` - Arguments. Optional. Additional arguments.

### Examples

    muzzleReturn diff -U0 "$buildDir"

### Return codes

- `0` - Always

