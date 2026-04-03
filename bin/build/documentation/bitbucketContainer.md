## `bitbucketContainer`

> Run the default build container for build testing on BitBucket

### Usage

    bitbucketContainer envFile [ extraArgs ... ]

Run the default build container for build testing on BitBucket

### Arguments

- `envFile` - File. Required. One or more environment files which are suitable to load for docker; must be valid
- `extraArgs ...` - Arguments. Optional. The first non-file argument to `bitbucketContainer` is passed directly through to `docker run` as arguments

### Return codes

- `1` - If already inside docker, or the environment file passed is not valid
- `0` - Success
- `Any` - `docker run` error code is returned if non-zero

