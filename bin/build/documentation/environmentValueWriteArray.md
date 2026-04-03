## `environmentValueWriteArray`

> Write an array value as NAME=([0]="a" [1]="b" [2]="c")

### Usage

    environmentValueWriteArray [ --help ] [ value ... ] [ --help ]

Write an array value as NAME=([0]="a" [1]="b" [2]="c")
Supports empty arrays
Bash outputs on different versions:
    declare -a foo='([0]="a" [1]="b" [2]="c")'
    declare -a foo=([0]="a" [1]="b" [2]="c")

### Arguments

- `--help` - Flag. Optional. Display this help.
- `value ...` - Arguments. Optional. Array values as arguments.
- `--help` - Flag. Optional. Display this help.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

