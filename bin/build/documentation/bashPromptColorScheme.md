### `bashPromptColorScheme`

> Color scheme values for prompts

#### Usage

    bashPromptColorScheme [ colorScheme ] [ --help ]

Color schemes for prompts. Use this as an argument to `bashPrompt --colors`.

Options are:

- forest
- light (default)
- dark

> Location: `bin/build/tools/prompt.sh`

#### Arguments

- `colorScheme` - String. Optional. Color scheme to choose: `light`, `dark`, `forest`
- `--help` - Flag. Optional. Display this help.

#### Examples

    bashPrompt --colors "$(bashPromptColorScheme dark)"

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

