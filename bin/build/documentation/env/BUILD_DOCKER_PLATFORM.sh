# shellcheck disable=SC2034
base="BUILD_DOCKER_PLATFORM.sh"
category="Docker"
derivations=([0]="env" [1]="envMarker" [2]="name")
description=$'The platform for `dockerLocalContainer`\n\nContacts of this can be found via `docker buildx ls`\n\nValid values are:\n\n- `linux/arm64`\n- `linux/amd64`\n- `linux/amd64/v2`\n- `linux/riscv64`\n- `linux/ppc64le`\n- `linux/s390x`\n- `linux/386`\n- `linux/mips64le`\n- `linux/mips64`\n- `linux/arm/v7`\n- `linux/arm/v6`\n\nIf not specified, uses the default for the current platform.\n\n'
descriptionLineCount="20"
env="BUILD_DOCKER_PLATFORM"
envMarker="build_docker_platform"
file="bin/build/env/BUILD_DOCKER_PLATFORM.sh"
fn="BUILD_DOCKER_PLATFORM"
foundNames=([0]="name" [1]="see" [2]="category" [3]="type")
name="Docker Platform"
rawComment=$'Name: Docker Platform\nSee: dockerLocalContainer\nCategory: Docker\nThe platform for `dockerLocalContainer`\nContacts of this can be found via `docker buildx ls`\nValid values are:\n- `linux/arm64`\n- `linux/amd64`\n- `linux/amd64/v2`\n- `linux/riscv64`\n- `linux/ppc64le`\n- `linux/s390x`\n- `linux/386`\n- `linux/mips64le`\n- `linux/mips64`\n- `linux/arm/v7`\n- `linux/arm/v6`\nIf not specified, uses the default for the current platform.\nSee: dockerPlatformDefault\nType: String\n\n'
see=$'dockerLocalContainer\ndockerPlatformDefault\n'
sourceFile="bin/build/env/BUILD_DOCKER_PLATFORM.sh"
sourceHash="f166e33bcaba1ac7c560b20a699a2e250f2b10fa"
sourceLine=""
summary="The platform for \`dockerLocalContainer\`"
summaryComputed="true"
type="String"
