### `bashApplicationAlias`

> Create alias for project

#### Usage

    bashApplicationAlias [ --help ] alias path [ name ]

This creates an alias for a project:
- `g-alias` - Change directory to this project (temporary)
- `G-alias` - Change directory and set application home to this project (survives logout)

> Location: `bin/build/tools/bash.sh`

#### Arguments

- `--help` - Flag. Optional. Display this help.
- `alias` - String. Required. Alias to generate.
- `path` - UserDirectory. Required. Project path relative to user home (or absolute)
- `name` - String. Optional. Project name to use

#### Writes to standard output

ConsoleText

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

