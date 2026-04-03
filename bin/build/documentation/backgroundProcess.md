## `backgroundProcess`

> Background process manager for shell (UNSTABLE)

### Usage

    backgroundProcess [ --verbose ] [ --report ] [ --summary ] [ --monitor ] [ --watch ] [ --verbose-toggle ] [ --terminate ] [ --go ] [ --new-only ] [ --stop stopSeconds ] [ --wait waitSeconds ] [ --frequency checkSeconds ] condition ... -- command ... [ --help ]

> UNSTABLE: Seems this does not handle long processes well which do not quit quickly. Need to improve testing. Use
> at your own risk. (2026-01-12 KMD)
Run a single process in the background continuously until a condition is met.
`condition` and `command` required when an action flag is not specified.
Action flags:
    --go --report --monitor --verbose-toggle --stop-all --summary
This can be used to run processes on your code in the background.
The `condition` should output *any* form of output which, when it changes (or exits non-zero), will require the `command` to be run.
As long as the `condition` remains the same between calls, `command` is not run.
Once `command` is run the process is monitored; and every `stopSeconds` seconds `condition` is run again - if `condition` changes
between the starting value and the new value then the command is terminated. The manager waits `waitSeconds` and then runs `command`
again. (Capturing `condition` at the start.)
If `condition` exits zero – then it is simply run every `checkSeconds` seconds to see if `command` needs to be run again.
This allows you to have background processes which, while you edit your code, for example, will pause momentarily while you edit and not use up
all of your available CPU.
To see status, try:
    backgroundProcess --summary
    backgroundProcess --report
    backgroundProcess --monitor
    backgroundProcess --watch

### Arguments

- `--verbose` - Flag. Optional. Be verbose.
- `--report` - Flag. Optional. Show a long report of all processes.
- `--summary` - Flag. Optional. Show a summary of all processes.
- `--monitor` - Flag. Optional. Interactively show report and refresh.
- `--watch` - Flag. Optional. Repeat showing summary.
- `--verbose-toggle` - Flag. Optional. Toggle the global verbose reporting.
- `--terminate` - Flag. Optional. Terminate all processes and delete all background process records.
- `--go` - Flag. Optional. Check all process states and update them.
- `--new-only` - Flag. Optional. Output a message for new processes only.
- `--stop stopSeconds` - PositiveInteger. Optional. Check every stop seconds after starting to see if should be stopped.
- `--wait waitSeconds` - PositiveInteger. Optional. After stopping, wait this many seconds before trying again.
- `--frequency checkSeconds` - PositiveInteger. Optional. Check condition at this frequency.
- `condition ...` - Callable. Required. Condition to test. Output of this is compared to see if we should stop process and restart it.
- `--` - Delimiter. Required. Separates command.
- `command ...` - Callable. Required. Function to run in the background.
- `--help` - Flag. Optional. Display this help.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

