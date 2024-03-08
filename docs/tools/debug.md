# Debug Functions

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)


### `buildDebugEnabled` - Is build debugging enabled?

Is build debugging enabled?

#### Usage

    buildDebugEnabled
    

#### Exit codes

- `1` - Debugging is not enabled
- `0` - Debugging is enabled

#### Environment

BUILD_DEBUG - Set to 1 to enable debugging, blank to disable

### `buildDebugStart` - Start build debugging if it is enabled.

Start build debugging if it is enabled.
This does `set -x` which traces and outputs every shell command
Use it to debug when you can not figure out what is happening internally.

#### Usage

    buildDebugStart
    

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
](https://github.com/zesk/build/blob/main/bin/build/tools/debug.sh#L35
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
) - [{summary}](https://github.com/zesk/build/blob/main/bin/build/tools/debug.sh#L91
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
) - [{summary}](https://github.com/zesk/build/blob/main/bin/build/tools/debug.sh#L103
)

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)
