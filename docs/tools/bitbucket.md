# BitBucket Repository Tools

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

# BitBucket Functions


### `getFromPipelineYML` - Fetch a value from the pipelines YAML file

Fetch a value from the pipelines YAML file

Assumes current working directory is project root.

Simple get value of a variable from the `bitbucket-pipelines.yml` file. It's important to note that
this does not parse the YML. This is useful if
you have a database container as part of your build configuration which requires a root password
required in other scripts; this means you do not have to replicate the value which can lead to errors.

An example `bitbucket-pipelines.yml` file may have a header which looks like this:

    definitions:
    caches:
    services:
        mariadb:
        variables:

On this file, the value of `$(getFromPipelineYML MARIADB_ROOT_PASSWORD)` is `super-secret`; it uses `grep` and `sed` to extract the value.

#### Usage

    getFromPipelineYML varName defaultValue
    

#### Arguments



#### Examples

    MARIADB_ROOT_PASSWORD=${MARIADB_ROOT_PASSWORD:-$(getFromPipelineYML MARIADB_ROOT_PASSWORD not-in-bitbucket-pipelines.yml)}

#### Exit codes

- `0` - Always succeeds

### `bitbucket.sh` - Run the default build container for build testing on BitBucket

Run the default build container for build testing on BitBucket

#### Arguments



#### Exit codes

- `1` - If already inside docker, or the environment file passed is not valid
- `0` - Success
- `Any` - `docker run` error code is returned if non-zero
