## `identicalRepair`

> Repair an identical `token` in `destination` from `source`

### Usage

    identicalRepair --prefix prefix token source destination [ --stdout ]

Repair an identical `token` in `destination` from `source`

> Location: `bin/build/tools/identical.sh`

### Arguments

- `--prefix prefix` - Required. A text prefix to search for to identify identical sections (e.g. `# IDENTICAL}`) (may specify more than one)
- `token` - String. Required. The token to repair.
- `source` - File. Required. The token file source. First occurrence is used.
- `destination` - File. Required. The token file to repair. Can be same as `source`.
- `--stdout` - Flag. Optional. Output changed file to `stdout`

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

