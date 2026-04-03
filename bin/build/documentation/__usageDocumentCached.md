## `__usageDocumentCached`

> Display cached usage for a function

### Usage

    __usageDocumentCached handler [ home ] [ functionName ] [ returnCode ] [ message ... ]

Display cached usage for a function

### Arguments

- `handler` - Function. Required.
- `home` - Directory. BUILD_HOME
- `functionName` - String. Function to display usage for
- `returnCode - UnsignedInteger. Optional. Exit code to display. Defaults to 0` - no error.
- `message ...` - String. Optional. Display this message which describes why `exitCode` occurred.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Environment

- {SEE:BUILD_COLORS.sh}
- {SEE:BUILD_DOCUMENTATION_PATH.sh}

### Requires

decorateThemed catchEnvironment __usageMessage decorate __functionSettings

