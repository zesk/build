### `daemontoolsTerminate`

> Terminate daemontools as gracefully as possible

#### Usage

    daemontoolsTerminate [ --timeout seconds ]

Terminate daemontools as gracefully as possible

> Location: `bin/build/tools/daemontools.sh`

#### Arguments

- `--timeout seconds` - Integer. Optional.

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Requires

- {SEE:throwArgument}
- {SEE:decorate}
- usageArgumentInteger
- {SEE:throwEnvironment}
- {SEE:catchEnvironment}
- {SEE:validate}
- {SEE:statusMessage}
- svscanboot
- id
- svc
- svstat

