# Environment files

<!-- TEMPLATE guideHeader 2 -->
[🛠️ Guide](./index.md) &middot; [⬅ Home ](../index.md)
<hr />

Environment values files can adhere to the **Docker** format (no quotes) or be bash-compatible (`source` compatible) but
not both, unfortunately; as the Docker format is incompatible with `bash` and vice-versa regarding values with spaces in
them.

> Docker-compatible Environment file

    NAME=Zesk Build
    ITEMS=(1 2 3 4)

> Bash-compatible Environment file

    NAME="Zesk Build"
    export ITEMS=(1 2 3 4)

Given that your project may use one or both, we support *any* implementation when possible.

> **Note:** `.env` files appear to have different implementations such that it's difficult at best to have a single
> format which works in your projects.
>
> We _detect_ whether an environment values file is formatted to support **Docker** or not and _convert it_
> appropriately on-the-fly as needed. See: `environmentFileToDocker` and `environmentFileToBashCompatible`

## Tested operating systems

Main issues between platforms are differences between BSD, GNU or POSIX standard tools in the shell.

- Darwin (Mac OS X)
- Ubuntu 22
- debian:latest
- alpine:latest
- BitBucket Pipelines

Tested bash versions:

- 3.2.57 (`Darwin`)
- 5.1.16 (`Ubuntu`)
- 5.2.26 (`Alpine`)

If you test on another OS or need support on a specific
platform, [report an issue](https://github.com/zesk/build/issues). We have early platform testing working via
`bin/tools.sh buildTestPlatforms` but it needs work.
