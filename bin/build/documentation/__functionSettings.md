## `__functionSettings`

> Load cached function comment values

### Usage

    __functionSettings [ home ] [ functionName ] [ generatePath ]

Load cached function comment values

### Arguments

- `home` - Directory. BUILD_HOME
- `functionName` - String. Function to fetch settings for
- `generatePath` - Boolean. Optional. Pass in `true` to just generate the file path and *not* require the file to exist.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Environment

- {SEE:BUILD_DOCUMENTATION_PATH.sh}

