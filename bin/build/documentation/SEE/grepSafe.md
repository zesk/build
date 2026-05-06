## `grepSafe`

> `grep` but returns 0 when nothing matches

### Usage

    grepSafe [ --help ] [ ... ]

`grep` but returns 0 when nothing matches

Allow blank files or no matches:

- `grep` - returns 1 - no lines selected
- `grep` - returns 0 - lines selected

> Location: `bin/build/tools/text.sh`

### Arguments

- `--help` - Flag. Optional. Display this help.
- `...` - Arguments. Passed directly to `grep`.

### Return codes

- `0` - Normal operation

### Requires

- grep
- {SEE:returnMap}

### See Also

- {SEE:grep}

