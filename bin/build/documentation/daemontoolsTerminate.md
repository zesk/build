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

- [throwArgument]({rel}tools/sugar-core.md#throwargument) - Run \`handler\` with an argument error ([source](https://github.com/zesk/build/blob/main/bin/build/tools/_sugar.sh#L215))[decorate]({rel}tools/decorate.md#decorate) - Singular decoration function ([source](https://github.com/zesk/build/blob/main/bin/build/tools/decorate/core.sh#L89))usageArgumentInteger
- [throwEnvironment]({rel}tools/sugar-core.md#throwenvironment) - Run \`handler\` with an environment error ([source](https://github.com/zesk/build/blob/main/bin/build/tools/_sugar.sh#L226))[catchEnvironment]({rel}tools/sugar-core.md#catchenvironment) - Run \`command\`, upon failure run \`handler\` with an environment error ([source](https://github.com/zesk/build/blob/main/bin/build/tools/_sugar.sh#L247))[validate]({rel}tools/validate.md#validate) - Validate a value by type ([source](https://github.com/zesk/build/blob/main/bin/build/tools/validate.sh#L95))[statusMessage]({rel}tools/decorate.md#statusmessage) - Output a status message and display correctly on consoles with animation and in log files ([source](https://github.com/zesk/build/blob/main/bin/build/tools/colors.sh#L316))svscanboot
- id
- svc
- svstat

