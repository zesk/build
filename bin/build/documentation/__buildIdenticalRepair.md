### Arguments

- `--key` - Optional. String. Optional key to go with `--fingerprint` to store the fingerprint key. (Default is `repair`)
- `--fingerprint` - Flag. String. Cache `application-fingerprint` in `APPLICATION_JSON` file at `APPLICATION_JSON_PREFIX` using `--key`, when it matches do nothing.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

