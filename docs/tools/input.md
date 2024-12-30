# Input Functions

Add keyboard shortcuts to your shell.

### `inputConfigurationAdd` - undocumented

No documentation for `inputConfigurationAdd`.

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
