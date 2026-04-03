## `environmentApplicationLoad`

> Loads application environment variables, set them to their default values

### Usage

    environmentApplicationLoad [ --help ]

Loads application environment variables, set them to their default values if needed, and outputs the list of variables and values.

### Arguments

- `--help` - Flag. Optional. Display this help.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Environment

- {SEE:BUILD_TIMESTAMP.sh}
- {SEE:APPLICATION_BUILD_DATE.sh}
- {SEE:APPLICATION_VERSION.sh}
- {SEE:APPLICATION_ID.sh}
- {SEE:APPLICATION_TAG.sh}

