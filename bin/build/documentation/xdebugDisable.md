### `xdebugDisable`

> Disable Xdebug

#### Usage

    xdebugDisable [ --help ]

Disable Xdebug on systems that have it.

This changes the value of `XDEBUG_ENABLED` to `false`. Programs must honor this and then skip invoking the debugger.

> Location: `bin/build/tools/xdebug.sh`

#### Arguments

- `--help` - Flag. Optional. Display this help.

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

- [`XDEBUG_ENABLED` xDebug Enabled Flag]({rel}env/#php) – **Boolean**. Is xdebug enabled? The application can honor this environment variable

