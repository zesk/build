# BitBucket Functions

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)

## `getFromPipelineYML`

Get value of a variable from the `bitbucket-pipelines.yml` file; it's important to note that this does not parse the YML. Assumes current working directory is project root. This is useful if you have a database container as part of your build configuration which requires a root password required in other scripts; this means you do not have to replicate the value which can lead to errors.

An example `bitbucket-pipelines.yml` file may have a header which looks like this:

    definitions:
    caches:
        apt-lists: /var/lib/apt/lists
        apt-cache: /var/cache/apt
    services:
        mariadb:
        memory: 1024
        image: mariadb:latest
        variables:
            MARIADB_ROOT_PASSWORD: super-secret

On this file, the value of `$(getFromPipelineYML MARIADB_ROOT_PASSWORD)` is `super-secret`; it uses `grep` and `sed` to extract the value.

### Usage

    getFromPipelineYML varName

### Arguments

- `varName` - Name of the value to extract from `bitbucket-pipelines.yml`

### Examples

    MARIADB_ROOT_PASSWORD=${MARIADB_ROOT_PASSWORD:-$(getFromPipelineYML MARIADB_ROOT_PASSWORD not-in-bitbucket-pipelines.yml)}



[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)