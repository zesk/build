# Debug Functions

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)


### `buildDebugEnabled` - Is build debugging enabled?

Is build debugging enabled?

#### Usage

    buildDebugEnabled [ moduleName ... ]
    

#### Arguments



#### Exit codes

- `1` - Debugging is not enabled (for any module)
- `0` - Debugging is enabled

#### Environment

BUILD_DEBUG - Set to non-blank to enable debugging, blank to disable. BUILD_DEBUG may be a comma-separated list of modules to target debugging.

### `buildDebugStart` - Start build debugging if it is enabled.

Start build debugging if it is enabled.
This does `set -x` which traces and outputs every shell command
Use it to debug when you can not figure out what is happening internally.

#### Usage

    buildDebugStart [ moduleName ... ]
    

#### Arguments



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

{SEE:buildDebugStart}

### `isBashDebug` - Returns whether the shell has the debugging flag set

Returns whether the shell has the debugging flag set

Useful if you need to temporarily enable or disable it.

#### Usage

    isBashDebug
    

#### Exit codes

- `0` - Always succeeds

### `isErrorExit` - Returns whether the shell has the error exit flag set

Returns whether the shell has the error exit flag set

Useful if you need to temporarily enable or disable it.

#### Usage

    isErrorExit
    

#### Exit codes

- `0` - Always succeeds

#### Usage

    restoreErrorExit
    

#### Examples

    save=$(saveErrorExit)
    set +x
    ... some nasty stuff
    restoreErrorExit "$save"

#### Exit codes

- `0` - Always succeeds

#### See Also

{SEE:saveErrorExit}

#### Usage

    saveErrorExit
    

#### Examples

    save=$(saveErrorExit)
    set +x
    ... some nasty stuff
    restoreErrorExit "$save"

#### Exit codes

- `0` - Always succeeds

#### See Also

{SEE:restoreErrorExit}

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)
