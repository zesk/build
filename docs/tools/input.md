# Input Functions

Add keyboard shortcuts to your shell.

### `inputConfigurationAdd` - Add configuration to `~/.inputrc` for a key binding

Add configuration to `~/.inputrc` for a key binding

- Location: `bin/build/tools/input.sh`

#### Arguments

- `keyStroke` - Required. String.
- `action` - Required. String.

#### Examples

inputConfigurationAdd "\ep" history-search-backward

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
