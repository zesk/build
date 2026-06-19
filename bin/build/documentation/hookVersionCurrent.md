### `hookVersionCurrent`

> Application current version

#### Usage

    hookVersionCurrent [ --help ] [ --application application ]

Get the application's current version.

Wrapper for the hook `version-current`.

Extracts the version from the repository

> Location: `bin/build/tools/hooks.sh`

#### Arguments

- `--help` - Flag. Optional. Display this help.
- `--application application` - Directory. Optional. Application home directory.

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

