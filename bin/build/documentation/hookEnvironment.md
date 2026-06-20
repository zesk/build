### `hookEnvironment`

> Load hook-related environment variables

#### Usage

    hookEnvironment [ --help ]

Load hook environment variables used to find hooks.

Ensures `BUILD_HOOK_EXTENSIONS` and `BUILD_HOOK_DIRS` are set to their proper defaults.

If already loaded, this function has no effect.

> Location: `bin/build/tools/hook.sh`

#### Arguments

- `--help` - Flag. Optional. Display this help.

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

- {SEE:BUILD_HOOK_EXTENSIONS} {SEE:BUILD_HOOK_DIRS}

