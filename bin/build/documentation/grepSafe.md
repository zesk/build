## `grepSafe`

> `grep` but returns 0 when nothing matches

### Usage

    grepSafe [ --help ] [ ... ]

`grep` but returns 0 when nothing matches
Allow blank files or no matches:
- `grep` - returns 1 - no lines selected
- `grep` - returns 0 - lines selected

### Arguments

- `--help` - Flag. Optional. Display this help.
- `...` - Arguments. Passed directly to `grep`.

### Return codes

- `0` - Normal operation

