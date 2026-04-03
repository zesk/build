## `buildCacheDirectory`

> Path to cache directory for build system.

### Usage

    buildCacheDirectory [ pathSegment ] [ --help ]

Path to cache directory for build system.
Defaults to `$XDG_CACHE_HOME/.build` unless `$XDG_CACHE_HOME` is not a directory.
Appends any passed in arguments as path segments.

### Arguments

- `pathSegment` - One or more directory or file path, concatenated as path segments using `/`
- `--help` - Flag. Optional. Display this help.

### Examples

    logFile=$(buildCacheDirectory test.log)

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Environment

- {SEE:XDG_CACHE_HOME.sh}

