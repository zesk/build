## `buildQuietLog`

> Generate the path for a quiet log in the build

### Usage

    buildQuietLog name [ --no-create ]

Generate the path for a quiet log in the build cache directory, creating it if necessary.

### Arguments

- `name` - String. Required. The log file name to create. Trims leading `_` if present.
- `--no-create` - Flag. Optional. Do not require creation of the directory where the log file will appear.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

