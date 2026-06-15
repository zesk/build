### `xdebugEnable`

> Enable Xdebug

#### Usage

    xdebugEnable [ --help ]

Enable Xdebug on systems that have it.

This changes the value of `XDEBUG_ENABLED` to `true`. Programs must honor this and invoke the debugger.

> Location: `bin/build/tools/xdebug.sh`

#### Arguments

- `--help` - Flag. Optional. Display this help.

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

- [`XDEBUG_ENABLED` xDebug Enabled Flag]({rel}env/#php) – **Boolean**. Is xdebug enabled? The application can honor this environment variable

