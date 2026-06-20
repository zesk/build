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

- [`BUILD_HOOK_EXTENSIONS` Build Hook Extension List]({rel}env/#application) – **ColonDelimitedList**. List of extensions to run when looking for hooks [`BUILD_HOOK_DIRS` Build Hook Directory List]({rel}env/#build_configuration) – **ApplicationDirectoryList**. List of directories to search for hooks. Defaults to `bin/hooks:bin/build/hooks`.

