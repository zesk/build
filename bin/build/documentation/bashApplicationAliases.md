### `bashApplicationAliases`

> Create aliases for projects

#### Usage

    bashApplicationAliases [ --help ]

Reads from `stdin` lines which is broken into three tokens by spaces:
    alias pathName projectName
The directories which exist at $HOME/$pathName will have aliases created for the project in Bash:
- `g-alias` - Change directory to this project (temporary)
- `G-alias` - Change directory and set application home to this project (survives logout)
The `projectName` is optional as it is extracted from the target project using the `APPLICATION_NAME`.

> Location: `bin/build/tools/bash.sh`

#### Arguments

- `--help` - Flag. Optional. Display this help.

#### Reads standard input

String Directory String:line

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

- {SEE:APPLICATION_NAME}

