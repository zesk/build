## `BUILD_DOCKER_PLATFORM`

> **Docker Platform** &mdash; The platform for `dockerLocalContainer`
> > **Type**: *String* • **Category**: *Docker*

The platform for `dockerLocalContainer`

Contacts of this can be found via `docker buildx ls`

Valid values are:

- `linux/arm64`
- `linux/amd64`
- `linux/amd64/v2`
- `linux/riscv64`
- `linux/ppc64le`
- `linux/s390x`
- `linux/386`
- `linux/mips64le`
- `linux/mips64`
- `linux/arm/v7`
- `linux/arm/v6`

If not specified, uses the default for the current platform.

### See Also

- [dockerLocalContainer]({rel}tools/docker.md#dockerlocalcontainer) - Run a build container using given docker image. ([source](https://github.com/zesk/build/blob/main/bin/build/tools/docker.sh#L119))- [dockerPlatformDefault]({rel}tools/docker.md#dockerplatformdefault) - Fetch the default platform for docker ([source](https://github.com/zesk/build/blob/main/bin/build/tools/docker.sh#L22))

