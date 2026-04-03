## `versionNextMinor`

> Converts vX.Y.N to vX.Y.(N+1) so v1.0.0 to v1.0.1

### Usage

    versionNextMinor lastVersion

Converts vX.Y.N to vX.Y.(N+1) so v1.0.0 to v1.0.1

### Arguments

- `lastVersion` - String. Required. Version to calculate the next minor version.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

