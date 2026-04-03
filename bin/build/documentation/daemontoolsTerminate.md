## `daemontoolsTerminate`

> Terminate daemontools as gracefully as possible

### Usage

    daemontoolsTerminate [ --timeout seconds ]

Terminate daemontools as gracefully as possible

### Arguments

- `--timeout seconds` - Integer. Optional.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Requires

throwArgument decorate usageArgumentInteger throwEnvironment catchEnvironment validate statusMessage
svscanboot id svc svstat

