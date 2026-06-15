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

- [`BUILD_TIMESTAMP` Build Timestamp]({rel}env/#deployment) – **UnsignedInteger**. Time when a build was initiated, set upon first invocation
- [`APPLICATION_BUILD_DATE` Application Build Date]({rel}env/#deployment) – **String**. Time when a build was initiated, set upon first invocation
- [`APPLICATION_VERSION` Application Version]({rel}env/#deployment) – **String**. This is the version number which can be displayed
- [`APPLICATION_ID` Application ID]({rel}env/#deployment) – **String**. This is the unique hash which represents the source code
- [`APPLICATION_TAG` Application Tag]({rel}env/#deployment) – **String**. This is the full version number including debugging or release

