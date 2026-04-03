## `gitShowStatus`

> Show changed files from HEAD with their status prefix character:

### Usage

    gitShowStatus [ --help ]

Show changed files from HEAD with their status prefix character:
- ' ' = unmodified
- `M` = modified
- `A` = added
- `D` = deleted
- `R` = renamed
- `C` = copied
- `U` = updated but unmerged
(See `man git` for more details on status flags)

### Arguments

- `--help` - Flag. Optional. Display this help.

### Return codes

- `0` - the repo has been modified
- `1` - the repo has NOT bee modified

