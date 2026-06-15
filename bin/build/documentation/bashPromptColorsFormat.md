### `bashPromptColorsFormat`

> Convert colors to escape codes

#### Usage

    bashPromptColorsFormat text

Given a list of color names, generate the color codes in a colon separated list.

> Location: `bin/build/tools/prompt.sh`

#### Arguments

- `text` - String. Required. List of color names in a colon separated list.

#### Writes to standard output

Outputs color *codes* separated by colons.

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Requires

- [decorations]({rel}tools/decorate.md#decorations) - Output a list of build-in decoration styles, one per line ([source](https://github.com/zesk/build/blob/main/bin/build/tools/decorate/core.sh#L66))[`read`]({rel}/guide/builtin.md#read)
- [inArray]({rel}tools/text.md#inarray) - Check if an element exists in an array ([source](https://github.com/zesk/build/blob/main/bin/build/tools/text.sh#L393))[decorate]({rel}tools/decorate.md#decorate) - Singular decoration function ([source](https://github.com/zesk/build/blob/main/bin/build/tools/decorate/core.sh#L89))[listJoin]({rel}tools/list.md#listjoin) - Output a list of items joined by a character ([source](https://github.com/zesk/build/blob/main/bin/build/tools/list.sh#L25))

