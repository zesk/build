### `timingReport`

> Output the time elapsed

#### Usage

    timingReport [ --slow slowMilliseconds ] [ --fast fastMilliseconds ] [ --style style ] [ --color style ] [ --end endTimestamp ] start [ message ] [ --help ] [ --handler handler ]

Outputs the timing optionally prefixed by a message.

Outputs a nice colorful message showing the number of seconds elapsed as well as your custom message.
Condition additions `--slow` and `--fast` allow display conditional on the time output.

> Location: `bin/build/tools/timing.sh`

#### Arguments

- `--slow slowMilliseconds` - UnsignedInteger. Optional. Display output if the displayed time is slower (longer) than this threshold.
- `--fast fastMilliseconds` - UnsignedInteger. Optional. Display output if the displayed time is faster (shorter) than this threshold.
- `--style style` - String. Optional. Display the message using this style. Default style is `success`
- `--color style` - String. Optional. Display the message using this style. Default style is `success`. Deprecated 2026-04.
- `--end endTimestamp` - UnsignedInteger. Optional. Use this as the end time to display. Otherwise uses the current time. Unit is milliseconds.
- `start` - UnsignedInteger|EmptyString. Required. Unix timestamp in milliseconds. See `timingStart`. Unit is `milliseconds`. Invalid values do NOT produce an error.
- `message` - Any additional arguments are output before the elapsed value computed
- `--help` - Flag. Optional. Display this help.
- `--handler handler` - Function. Optional. Use this error handler instead of the default error handler.

#### Examples

    init=$(timingStart)
    ...
    timingReport "$init" "Deploy completed in"
    timingReport "$start" --slow 5000 "Reporting should be completed in less than 5 seconds."
    timingReport "$start" --fast 1000 --style error "Deployment completed too quickly; please check systems."

#### Return codes

- `0` - Exits with exit code zero

#### See Also

- {SEE:timingStart}

