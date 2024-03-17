# Debug Functions

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)


### `buildDebugEnabled` - Is build debugging enabled?

Is build debugging enabled?

#### Arguments

- `moduleName` - Optional. String. If `BUILD_DEBUG` contains any token passed, debugging is enabled.

#### Exit codes

- `1` - Debugging is not enabled (for any module)
- `0` - Debugging is enabled

#### Environment

BUILD_DEBUG - Set to non-blank to enable debugging, blank to disable. BUILD_DEBUG may be a comma-separated list of modules to target debugging.

### `buildDebugStart` - Start build debugging if it is enabled.

Start build debugging if it is enabled.
This does `set -x` which traces and outputs every shell command
Use it to debug when you can not figure out what is happening internally.

#### Arguments

- `moduleName` - Optional. String. Only start debugging if debugging is enabled for ANY of the passed in modules.

#### Examples

    buildDebugStart
    # ... complex code here
    buildDebugStop

#### Exit codes

- `0` - Always succeeds

### `buildDebugStop` - Stop build debugging if it is enabled

Stop build debugging if it is enabled

#### Usage

    buildDebugStop
    

#### Exit codes

- `0` - Always succeeds

#### See Also

- [function buildDebugStart
](./docs/tools/debug.md
) - [Start build debugging if it is enabled.
](https://github.com/zesk/build/blob/main/bin/build/tools/debug.sh#L45
)

### `isBashDebug` - Returns whether the shell has the debugging flag set

Returns whether the shell has the debugging flag set

Useful if you need to temporarily enable or disable it.

#### Exit codes

- `0` - Always succeeds

### `isErrorExit` - Returns whether the shell has the error exit flag set

Returns whether the shell has the error exit flag set

Useful if you need to temporarily enable or disable it.

#### Exit codes

- `0` - Always succeeds

#### Examples

    save=$(saveErrorExit)
    set +x
    ... some nasty stuff
    restoreErrorExit "$save"

#### Exit codes

- `0` - Always succeeds

#### See Also

- [function saveErrorExit
](./docs/tools/debug.md
) - [{summary}](https://github.com/zesk/build/blob/main/bin/build/tools/debug.sh#L101
)

#### Examples

    save=$(saveErrorExit)
    set +x
    ... some nasty stuff
    restoreErrorExit "$save"

#### Exit codes

- `0` - Always succeeds

#### See Also

- [function restoreErrorExit
](./docs/tools/debug.md
) - [{summary}](https://github.com/zesk/build/blob/main/bin/build/tools/debug.sh#L113
)

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)
