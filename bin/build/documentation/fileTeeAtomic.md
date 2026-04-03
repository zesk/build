## `fileTeeAtomic`

> tee but atomic (EXPERIMENTAL)

### Usage

    fileTeeAtomic [ -a ] target [ --help ]

Write to a file in a single operation to avoid invalid files
EXPERIMENTAL not a lot of testing of this don't use quite yet.

### Arguments

- `-a` - Flag. Optional. Append target (atomically as well).
- `target` - File. Required. File to target
- `--help` - Flag. Optional. Display this help.

### Reads standard input

Piped to a temporary file until EOF and then moved to target

### Writes to standard output

A copy of stdin

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

