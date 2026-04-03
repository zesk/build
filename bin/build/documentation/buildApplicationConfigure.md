## `buildApplicationConfigure`

> Set up a new project for Zesk Build

### Usage

    buildApplicationConfigure --non-interactive [ --owner ownerName ] [ --name applicationName ] [ --code codeName ] [ --help ]

Set up a new project for Zesk Build
- Creates shell development environment
- Registers git hooks
- Configures base environment variables
EXPERIMENTAL - not finished yet.

### Arguments

- `--non-interactive` - Flag. Optional. Do not prompt for input and fail if input is required.
- `--owner ownerName` - String. Optional. The `APPLICATION_OWNER`.
- `--name applicationName` - String. Optional. The `APPLICATION_NAME`.
- `--code codeName` - String. Optional. The `APPLICATION_CODE`.
- `--help` - Flag. Optional. Display this help.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

