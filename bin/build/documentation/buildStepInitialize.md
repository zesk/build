## `buildStepInitialize`

> Build step check

### Usage

    buildStepInitialize [ dumpEnv ]

Run at the start of build steps to check that the environment exists and dump it, optionally using a build flag
passed as the first argument.
Check if `.build.env` exists and dump the environment if `true` passed

### Arguments

- `dumpEnv` - Boolean. Optional. When `true` dumps the environment.

### Return codes

- `1` - `.build.env` is missing
- `0` - All is well

