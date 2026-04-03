## `buildDebugStart`

> Start build debugging if it is enabled.

### Usage

    buildDebugStart [ moduleName ]

Start build debugging if it is enabled.
This does `set -x` which traces and outputs every shell command
Use it to debug when you can not figure out what is happening internally.
`BUILD_DEBUG` can be a list of strings like `environment,assert` for example.
Example:     buildDebugStart || :

### Arguments

- `moduleName` - String. Optional. Only start debugging if debugging is enabled for ANY of the passed in modules.

### Examples

    # ... complex code here
    buildDebugStop || :. -

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Environment

- {SEE:BUILD_DEBUG.sh}

### Requires

buildDebugEnabled

