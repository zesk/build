## `buildFailed`

> Output debugging information when the build fails

### Usage

    buildFailed logFile [ message ]

Outputs debugging information after build fails:
- last 50 lines in build log
- Failed message
- last 3 lines in build log

### Arguments

- `logFile` - File. Required. The most recent log from the current script.
- `message` - String. Optional. Any additional message to output.

### Examples

    quietLog="$(buildQuietLog "$me")"
    if ! ./bin/deploy.sh >>"$quietLog"; then
        decorate error "Deploy failed"
        buildFailed "$quietLog"
    fi

### Sample Output

stdout

### Return codes

- `1` - Always fails

