### `bashDebugInterruptFile`

> Output debugging stack on program termination

#### Usage

    bashDebugInterruptFile [ --help ] [ --handler handler ] [ --error ] [ --clear ] [ --interrupt ] [ --already-error ]

Adds a trap to capture the debugging stack on interrupt.
Use this in a bash script which runs forever or runs in an infinite loop to
determine where the problem or loop exists.
The file is named `./.interrupt.log` and is appended each time the program is terminated or exits improperly.

> Location: `bin/build/tools/debug.sh`

#### Arguments

- `--help` - Flag. Optional. Display this help.
- `--handler handler` - Function. Optional. Use this error handler instead of the default error handler.
- `--error` - Flag. Add ERR trap.
- `--clear` - Flag. Remove all traps.
- `--interrupt` - Flag. Add INT trap.
- `--already-error` - Flag. If the signals are already installed, then throw an error. Otherwise exits 0.

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Requires

- [`trap`]({rel}guide/builtin.md#trap)

