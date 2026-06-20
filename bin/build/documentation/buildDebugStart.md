### `buildDebugStart`

> Start bash debugging

#### Usage

    buildDebugStart [ moduleName ]

Start bash debugging if it is enabled.
This does `set` `-x` which traces and outputs every shell command.
Use it to debug when you can not figure out what is happening internally.

`BUILD_DEBUG` can be a list of strings like `environment,assert` for example.

Example:
Example:     buildDebugStart || :

> Location: `bin/build/tools/debug.sh`

#### Arguments

- `moduleName` - String. Optional. Only start debugging if debugging is enabled for ANY of the passed in modules.

#### Examples

    # ... complex code here
    buildDebugStop || :. -

#### Return codes

- `0` - bash debugging was started
- `1` - bash debugging was not started because token did not match.

#### Environment

- {SEE:BUILD_DEBUG}

#### Requires

- [buildDebugEnabled]({rel}tools/debug.md#builddebugenabled) - Is build debugging enabled? ([source](https://github.com/zesk/build/blob/main/bin/build/tools/debug.sh#L24))

