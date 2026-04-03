## `deployPackageName`

> Outputs the build target name which is based on the

### Usage

    deployPackageName deployHome

Outputs the build target name which is based on the environment `BUILD_TARGET`.
If this is called on a non-deployment system, use the application root instead of
`deployHome` for compatibility.

### Arguments

- `deployHome` - Directory. Required. Deployment database home.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Environment

- {SEE:BUILD_TARGET.sh}

