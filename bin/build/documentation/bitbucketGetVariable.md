## `bitbucketGetVariable`

> Fetch a value from the pipelines YAML file

### Usage

    bitbucketGetVariable [ varName ] [ defaultValue ]

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
On this file, the value of `$(bitbucketGetVariable MARIADB_ROOT_PASSWORD)` is `super-secret`; it uses `grep` and `sed` to extract the value.

### Arguments

- `varName` - Name of the value to extract from `bitbucket-pipelines.yml`
- `defaultValue` - Value if not found in pipelines

### Examples

    MARIADB_ROOT_PASSWORD=${MARIADB_ROOT_PASSWORD:-$(bitbucketGetVariable MARIADB_ROOT_PASSWORD not-in-bitbucket-pipelines.yml)}

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

