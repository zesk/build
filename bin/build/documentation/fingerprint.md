## `fingerprint`

> Update file from `APPLICATION_JSON` with application fingerprint.

### Usage

    fingerprint [ --help ] [ --handler handler ] [ --cached fingerprint ] [ --verbose ] [ --quiet ] [ --audit ] [ --check ] [ --key ]

Update file from `APPLICATION_JSON` with application fingerprint.

> Location: `bin/build/tools/fingerprint.sh`

### Arguments

- `--help` - Flag. Optional. Display this help.
- `--handler handler` - Function. Optional. Use this error handler instead of the default error handler.
- `--cached fingerprint` - String. Optional. Instead of computing the `application-fingerprint` using the hook, use this value.
- `--verbose` - Flag. Optional. Be verbose. Default based on value of `fingerprint` in `BUILD_DEBUG`.
- `--quiet` - Flag. Optional. Be quiet (turns verbose off).
- `--audit` - Flag. Optional. Keep a record of the files between fingerprints and show what changed to see if certain files are changing often and shouldn't; or should be ignored.
- `--check` - Flag. Optional. Check if the fingerprint is up to date and output the current value.
- `--key` - String. Optional. Update this key in the JSON file.

### Debugging settings

Append to the value of `BUILD_DEBUG` (a comma-delimited (`,`) list) and add these tokens to enable debugging:

- `fingerprint` - By default be verbose even if the flag is not specified. (Use `--quiet` to silence if needed)

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

