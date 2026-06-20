### `environmentApplicationLoad`

> Loads application environment variables, set them to their default values

#### Usage

    environmentApplicationLoad [ --help ]

Loads application environment variables, set them to their default values if needed, and outputs the list of variables and values.

> Location: `bin/build/tools/environment/application.sh`

#### Arguments

- `--help` - Flag. Optional. Display this help.

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

- {SEE:BUILD_TIMESTAMP}
- {SEE:APPLICATION_BUILD_DATE}
- {SEE:APPLICATION_VERSION}
- {SEE:APPLICATION_ID}
- {SEE:APPLICATION_TAG}

