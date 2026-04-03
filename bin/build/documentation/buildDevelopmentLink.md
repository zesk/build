## `buildDevelopmentLink`

> Add a development link to the local version of Zesk

### Usage

    buildDevelopmentLink [ --copy ] [ --reset ]

Add a development link to the local version of Zesk Build for testing in local projects.
Copies or updates `$BUILD_HOME/bin/build` in current project.
Useful when you want to test a fix on a current project.

### Arguments

- `--copy - Flag. Optional. Copy the files instead of creating a link` - more compatible with Docker but slower and requires synchronization.
- `--reset` - Flag. Optional. Revert the link and reinstall using the original binary.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

