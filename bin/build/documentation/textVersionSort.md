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

#### Reads standard input

{stdin}

#### Writes to standard output

{stdout}

#### Writes to standard error

{stderr}

#### Debugging settings

Append to the value of `BUILD_DEBUG` (a comma-delimited (`,`) list) and add these tokens to enable debugging:

{build_debug}

#### Examples

    git tag | grep -e '^v[0-9.]*$' | textVersionSort


#### Sample Output

{output}

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Local cache

{local_cache}

#### Environment

{environment}

#### Requires

- - [throwArgument]({rel}tools/sugar-core.md#throwargument) - Run \`handler\` with an argument error ([source](https://github.com/zesk/build/blob/main/bin/build/tools/_sugar.sh#L215))sort

#### See Also

{see}

#### Credits

Thanks to [{credits}]({source}).

#### Review Status

File `bin/build/tools/text.sh`, function `textVersionSort` was reviewed {reviewed}.

#### Errors

{error}
