## `__decorateExtensionFile`

> decorate file links

### Usage

    __decorateExtensionFile [ --no-app ] fileName [ text ]

decorate extension for `file`

### Arguments

- `--no-app` - Flag. Optional. Do not map the application path in `decoratePath`
- `fileName` - Required. File path to output.
- `text` - String. Optional. Text to output linked to file.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Environment

- {SEE:BUILD_HOME.sh} TMPDIR HOME

