## `bashCoverageReport`

> Experimental. Likely abandon.

### Usage

    bashCoverageReport [ --cache cacheDirectory ] [ --target targetDirectory ] statsFile

Generate a coverage report using the coverage statistics file
*This is a work in progress and is unfinished as of January 2026. Plans are to do this in another language.*

### Arguments

- `--cache cacheDirectory` - Optional. Directory.
- `--target targetDirectory` - Optional. Directory.
- `statsFile` - File. Required.

### Reads standard input

Accepts a stats file

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

