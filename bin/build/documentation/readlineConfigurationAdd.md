## `readlineConfigurationAdd`

> Add configuration to `~/.inputrc` for a key binding

### Usage

    readlineConfigurationAdd [ --help ] keyStroke action

Add configuration to `~/.inputrc` for a key binding

> Location: `bin/build/tools/readline.sh`

### Arguments

- `--help` - Flag. Optional. Display this help.
- `keyStroke` - String. Required.
- `action` - String. Required.

### Examples

readlineConfigurationAdd "\ep" history-search-backward

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

