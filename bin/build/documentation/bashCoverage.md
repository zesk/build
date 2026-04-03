## `bashCoverage`

> Collect code coverage statistics for a code sample

### Usage

    bashCoverage [ --target reportFile ] thingToRun

Collect code coverage statistics for a code sample
Convert resulting files using `bashCoverageReport`

### Arguments

- `--target reportFile` - File. Optional. Write coverage data to this file.
- `thingToRun` - Callable. Required. Function to run and collect coverage data.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

