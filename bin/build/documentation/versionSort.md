## `versionSort`

> Sort versions in the format v0.0.0

### Usage

    versionSort [ -r | --reverse ] [ --help ]

Sorts semantic versions prefixed with a `v` character; intended to be used as a pipe.
vXXX.XXX.XXX
for sort - -k 1.c,1 - the `c` is the 1-based character index, so 2 means skip the 1st character
Odd you can't globally flip sort order with -r - that only works with non-keyed entries I assume

### Arguments

-r |- ` --reverse` - Reverse the sort order (optional)
- `--help` - Flag. Optional. Display this help.

### Examples

    git tag | grep -e '^v[0-9.]*$' | versionSort

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Requires

throwArgument sort usageDocument decorate

