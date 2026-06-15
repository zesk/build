### `isTTYAvailable`

> Quiet test for a TTY

#### Usage

    isTTYAvailable [ --help ]

Returns 0 if a tty is available, 1 if not. Caches the saved value in `__BUILD_HAS_TTY` to avoid running the test each call.

> Location: `bin/build/tools/colors.sh`

#### Arguments

- `--help` - Flag. Optional. Display this help.

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

- [`__BUILD_HAS_TTY` TTY Cached Result]({rel}env/#internal) – **Boolean**. Cached value of the availability of `/dev/tty`.

#### See Also

- {SEE:stty}
- {SEE:/dev/tty}

