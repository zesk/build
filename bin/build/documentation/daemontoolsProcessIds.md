### `daemontoolsProcessIds`

> List any processes associated with daemontools supervisors

#### Usage

    daemontoolsProcessIds

List any processes associated with daemontools supervisors

> Location: `bin/build/tools/daemontools.sh`

#### Arguments

- none

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Requires

- pgrep
- [`read`]({rel}/guide/builtin.md#read)
- [`printf`]({rel}/guide/builtin.md#printf)

