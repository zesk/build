## `assertStatistics`

> Output assertion counts

### Usage

    assertStatistics [ --reset ] [ --total ] [ --help ]

Output the total number of assertion failures and assertion successes, separated by a space and terminated with a newline

### Arguments

- `--reset` - Flag. Optional. Reset statistics to zero.
- `--total` - Flag. Optional. Just output the total.
- `--help` - Flag. Optional. Display this help.

### Writes to standard output

UnsignedInteger. 2 lines.

### Examples

    read -r failures successes < <(assertStatistics) || return $?

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

