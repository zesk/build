## `deployMigrateDirectoryToLink`

> Automatically convert application deployments using non-links to links.

### Usage

    deployMigrateDirectoryToLink deployHome applicationPath

Automatically convert application deployments using non-links to links.

> Location: `bin/build/tools/deploy.sh`

### Arguments

- `deployHome` - Directory. Required. Deployment database home.
- `applicationPath` - Directory. Required. Application target path.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

