### `buildEnvironmentContext`

> Run a command and ensure the build tools context matches

#### Usage

    buildEnvironmentContext startDirectory command [ ... ]

Run a command and ensure the build tools context matches the current project.

Useful when you need to ensure the command is run with the correct version of Zesk Build.

Avoid infinite loops here, call down.

> Location: `bin/build/tools/build.sh`

#### Arguments

- `startDirectory` - Directory. Required. Context in which the command should run.
- `command` - Callable. Required. Command to run in new context.
- `...` - Arguments. Optional. Arguments to the `command`.

#### Examples

    buildEnvironmentContext "$(pwd)" environmentFileLoad "$(pwd)/.env" --execute timing --slow 500 "$(pwd)/bin/ping.py"

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

