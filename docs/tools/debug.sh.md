# Debug Functions

Functions to assist in debugging the internals of the build scripts.

The main mechanism is to set the environment value `BUILD_DEBUG` to a value (`1`, `2` or more) to increase the verbosity of the output generated.

## `buildDebugEnabled`

If the `BUILD_DEBUG` environment is set to a truthy value.

### Environment

- `BUILD_DEBUG` - if `test $BUILD_DEBUG` succeeds, then debugging is enabled.

## `buildDebugStart`

If build debugging is enabled, start trace execution (output of each command in the shell). (see `set -x`)

## `buildDebugStop`

If build debugging is enabled, stop trace execution.

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)