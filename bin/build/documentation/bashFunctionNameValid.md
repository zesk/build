### `bashFunctionNameValid`

> Is a string a valid function name?

#### Usage

    bashFunctionNameValid [ --help ]

Does not check if a function is defined, just whether the name would be acceptable as a function name in Bash.

> Location: `bin/build/tools/bash.sh`

#### Arguments

- `--help` - Flag. Optional. Display this help.

#### Return codes

- `0` - All values passed are valid function names for bash functions
- `1` - One or more values passed are NOT valid function names for bash functions

