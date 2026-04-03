## `isErrorExit`

> Returns whether the shell has the error exit flag set

### Usage

    isErrorExit

Returns whether the shell has the error exit flag set
Useful if you need to temporarily enable or disable it.
October 2024 - Does appear to be inherited by subshells
    set -e
    printf "$(isErrorExit; printf %d $?)"
Outputs `1` always

### Arguments

- none

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Requires

-

