## `fingerprint`

> Update file from `APPLICATION_JSON` with application fingerprint.

### Usage

    fingerprint [ --help ] [ --handler handler ] [ --cached fingerprint ] [ --verbose ] [ --quiet ] [ --check ] [ --key ]

Update file from `APPLICATION_JSON` with application fingerprint.

### Arguments

- `--help` - Flag. Optional. Display this help.
- `--handler handler` - Function. Optional. Use this error handler instead of the default error handler.
- `--cached fingerprint` - String. Optional. Instead of computing the `application-fingerprint` using the hook, use this value.
- `--verbose` - Flag. Optional. Be verbose. Default based on value of `fingerprint` in `BUILD_DEBUG`.
- `--quiet` - Flag. Optional. Be quiet (turns verbose off).
- `--check` - Flag. Optional. Check if the fingerprint is up to date and output the current value.
- `--key` - String. Optional. Update this key in the JSON file.

### Debugging settings

Append to the value of `BUILD_DEBUG` (a comma-delimited (`,`) list) and add these tokens to enable debugging:

- `fingerprint` - By default be verbose even if the flag is not specified. (Use `--quiet` to silence if needed)

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Environment

- {SEE:BUILD_DEBUG.sh}

