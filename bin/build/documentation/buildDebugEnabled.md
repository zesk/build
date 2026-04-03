## `buildDebugEnabled`

> Is build debugging enabled?

### Usage

    buildDebugEnabled [ moduleName ]

Is build debugging enabled?

### Arguments

- `moduleName` - String. Optional. If `BUILD_DEBUG` contains any token passed, debugging is enabled.

### Examples

    BUILD_DEBUG=false # All debugging disabled
    BUILD_DEBUG= # All debugging disabled
    unset BUILD_DEBUG # All debugging is disabled
    BUILD_DEBUG=true # All debugging is enabled
    BUILD_DEBUG=handler,bashPrompt # Debug `handler` and `bashPrompt` calls

### Return codes

- `1` - Debugging is not enabled (for any module)
- `0` - Debugging is enabled

### Environment

- {SEE:BUILD_DEBUG.sh} - Set to non-blank to enable debugging, blank to disable. `BUILD_DEBUG` may be a comma-separated list of modules to target debugging.

