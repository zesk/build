## `deployHasVersion`

> Does a deploy version exist? versionName is the version identifier

### Usage

    deployHasVersion deployHome versionName

Does a deploy version exist? versionName is the version identifier for deployments

### Arguments

- `deployHome` - Directory. Required. Deployment database home.
- `versionName` - String. Required. Application ID to look for

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

