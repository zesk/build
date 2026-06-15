### `environmentFileApplicationMake`

> Create environment file `.env` for build.

#### Usage

    environmentFileApplicationMake [ --help ] [ requiredVariable ... ] [ -- ] [ optionalVariable ... ]

Create environment file `.env` for build.

Note that this does NOT change or modify the current environment.

> Location: `bin/build/tools/environment/application.sh`

#### Arguments

- `--help` - Flag. Optional. Display this help.
- `requiredVariable ...` - EnvironmentVariable. Optional. One or more environment variables which should be non-blank and included in the `.env` file.
- `--` - Divider. Optional. Divides the requiredEnvironment values from the optionalEnvironment. Should appear once and only once.
- `optionalVariable ...` - EnvironmentVariable. Optional. One or more environment variables which are included if blank or not

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

- [`APPLICATION_VERSION` Application Version]({rel}env/#deployment) – **String**. This is the version number which can be displayed - reserved and set to `hookRun version-current` if not set already
- [`APPLICATION_BUILD_DATE` Application Build Date]({rel}env/#deployment) – **String**. Time when a build was initiated, set upon first invocation - reserved and set to current date; format like SQL.
- [`APPLICATION_TAG` Application Tag]({rel}env/#deployment) – **String**. This is the full version number including debugging or release - reserved and set to `hookRun application-id`
- [`APPLICATION_ID` Application ID]({rel}env/#deployment) – **String**. This is the unique hash which represents the source code - reserved and set to `hookRun application-tag`

