### `gitPreCommitHasExtension`

> Does this commit have the following file extensions?

#### Usage

    gitPreCommitHasExtension [ extension ] [ --help ]

Does this commit have the following file extensions?

> Location: `bin/build/tools/git.sh`

#### Arguments

- `extension` - String. Optional. Extension to check. Use `!` for blank extension and `@` for all extensions. Can specify one or more.
- `--help` - Flag. Optional. Display this help.

#### Return codes

- `0` - if all extensions are present
- `1` - if any extension is not present

