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

### `buildDebugStop` - Start build debugging if it is enabled.

Start build debugging if it is enabled.
This does `set -x` which traces and outputs every shell command
Use it to debug when you can not figure out what is happening internally.



Stop build debugging if it is enabled

#### Usage

    buildDebugStop

#### Examples

buildDebugStart
    # ... complex code here
    buildDebugStop

#### Exit codes

- `0` - Always succeeds

#### See Also

buildDebugStart

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)
