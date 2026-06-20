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
- [catchEnvironment]({rel}tools/sugar-core.md#catchenvironment) - Run \`command\`, upon failure run \`handler\` with an environment error ([source](https://github.com/zesk/build/blob/main/bin/build/tools/_sugar.sh#L247))
- {SEE:validate}
- {SEE:statusMessage}
- svscanboot
- [`id`]({rel}guide/command.md#id)
- svc
- svstat

