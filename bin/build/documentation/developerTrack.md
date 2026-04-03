## `developerTrack`

> Track changes to the bash environment. WIth no arguments this

### Usage

    developerTrack [ --verbose ] [ --list ] [ --profile ] [ --developer ]

Track changes to the bash environment. WIth no arguments this function returns the new or changed bash functions, variables, or aliases since marks occurred.
In general, you will add `developerTrack --profile` at the end of your `.bashrc` file, and you will add `developerTrack --developer` at the *start* of your `developer.sh` before you define anything.

### Arguments

- `--verbose` - Flag. Optional. Be verbose about what the function is doing.
- `--list` - Flag. Optional. Show the list of what has changed since the first invocation.
- `--profile` - Flag. Optional. Mark the end of profile definitions.
- `--developer` - Flag. Optional. Mark the start of developer definitions.

### Writes to standard output

list of function|alias|environment

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

