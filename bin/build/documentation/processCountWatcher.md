## `processCountWatcher`

> Watch the number of processes matching `token` and fail if

### Usage

    processCountWatcher [ --help ] [ --handler handler ] [ threshold ] [ ... ] [ --handler handler ] [ --quiet ] [ --hook hookName ] [ --sleep sleepTime ] [ --timeout timeoutTime ]

Watch the number of processes matching `token` and fail if it exceeds a threshold
Argument:

> Location: `bin/build/tools/process.sh`

### Arguments

- `--help` - Flag. Optional. Display this help.
- `--handler handler` - Function. Optional. Use this error handler instead of the default error handler.
- `threshold` - UnsignedInteger. Optional. If process count exceeds this threshold, run the hook and return 1.
- `...` - Arguments. Optional. Pass these arguments to the hook.
- `--handler handler` - Function. Optional. Use this error handler instead of the default error handler.
- `--quiet` - Flag. Optional. Do not output a message when threshold is exceeded.
- `--hook hookName` - EmptyString. Optional. Run this hook. Defaults to `notify'
- `--sleep sleepTime` - PositiveInteger. Optional. Sleep time between checks in milliseconds.
- `--timeout timeoutTime` - PositiveInteger. Optional. Time out watching after `timeoutTime` milliseconds.

### Return codes

- `0` - Sleep was interrupted
- `1` - Process count exceeded threshold

