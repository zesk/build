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

- {SEE:decorations}
- [`read`]({rel}/guide/builtin.md#read)
- {SEE:inArray}
- {SEE:decorate}
- {SEE:listJoin}

