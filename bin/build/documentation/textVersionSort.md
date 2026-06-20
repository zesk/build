### `textVersionSort`

> Sort versions in the format v0.0.0

#### Usage

    textVersionSort [ -r | --reverse ] [ --help ]

Sorts semantic versions prefixed with a `v` character; intended to be used as a pipe.

vXXX.XXX.XXX

for sort - -k 1.c,1 - the `c` is the 1-based character index, so 2 means skip the 1st character

Odd you can't globally flip sort order with -r - that only works with non-keyed entries I assume

> Location: `bin/build/tools/text.sh`

#### Arguments

-r |- ` --reverse` - Reverse the sort order (optional)
- `--help` - Flag. Optional. Display this help.

#### Examples

    git tag | grep -e '^v[0-9.]*$' | textVersionSort

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Requires

- [throwArgument]({rel}tools/sugar-core.md#throwargument) - Run \`handler\` with an argument error ([source](https://github.com/zesk/build/blob/main/bin/build/tools/_sugar.sh#L215))
- [`sort`]({rel}guide/command.md#sort)
- [bashDocumentation]({rel}tools/documentation.md#bashdocumentation) - Universal function documentation ([source](https://github.com/zesk/build/blob/main/bin/build/tools/usage.sh#L59))
- [decorate]({rel}tools/decorate.md#decorate) - decorate text using colors and styles ([source](https://github.com/zesk/build/blob/main/bin/build/tools/decorate/core.sh#L144))

