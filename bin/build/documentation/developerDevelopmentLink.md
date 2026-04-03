## `developerDevelopmentLink`

> Link a current library with another version being developed nearby

### Usage

    developerDevelopmentLink [ --copy ] [ --reset ] [ --development-path developmentPath- Directory. Optional. Path in the target development directory to link (or copy) to the path. ] --version-json jsonFile [ --version-selector jsonFile ] --variable variableNameValue [ --binary ] [ --composer composerPackage ] --path applicationPath

Link a current library with another version being developed nearby using a link
Does not work inside docker containers unless you explicitly do some magic with paths (maybe we will add this)

### Arguments

- `--copy - Flag. Optional. Copy the files instead of creating a link` - more compatible with Docker but slower and requires synchronization.
- `--reset` - Flag. Optional. Revert the link and reinstall using the original binary.
--development-path developmentPath- Directory. Optional. Path in the target development directory to link (or copy) to the path.
- `--version-json jsonFile` - ApplicationFile. Required. The library JSON file to check.
- `--version-selector jsonFile` - String. Optional. Query to extract version from JSON file (defaults to `.version`). API.
- `--variable variableNameValue` - EnvironmentVariable. Required. The environment variable which represents the local path of the library to link to. API.
- `--binary` - String. Optional. The binary to install the library remotely if needed to revert back. API.
- `--composer composerPackage` - String. Optional. The composer package to convert to a link (or copy.). API.
- `--path applicationPath` - ApplicationDirectory. Required. The library path to convert to a link (or copy). API.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

