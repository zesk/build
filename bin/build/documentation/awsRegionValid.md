## `awsRegionValid`

> Check an AWS region code for validity

### Usage

    awsRegionValid region ... [ --help ]

Checks an AWS region identifier for validity as of September 2024.
Note that passing no parameters returns success.

### Arguments

- `region ...` - String. Required. The AWS Region to validate.
- `--help` - Flag. Optional. Display this help.

### Return codes

- `0` - All regions are valid AWS region
- `1` - One or more regions are NOT a valid AWS region

