## `isCharacterClass`

> Poor-man's bash character class matching

### Usage

    isCharacterClass className [ character ... ] [ --help ]

Poor-man's bash character class matching
Returns true if all `characters` are of `className`
`className` can be one of:
    alnum   alpha   ascii   blank   cntrl   digit   graph   lower
    print   punct   space   upper   word    xdigit

### Arguments

- `className` - String. Required. Class to check.
- `character ...` - String. Optional. Characters to test.
- `--help` - Flag. Optional. Display this help.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

