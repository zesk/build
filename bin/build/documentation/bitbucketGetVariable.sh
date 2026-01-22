#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/bitbucket.sh"
argument="varName - Name of the value to extract from \`bitbucket-pipelines.yml\`"$'\n'"defaultValue - Value if not found in pipelines"$'\n'""
base="bitbucket.sh"
description="Fetch a value from the pipelines YAML file"$'\n'""$'\n'"Assumes current working directory is project root."$'\n'""$'\n'"Simple get value of a variable from the \`bitbucket-pipelines.yml\` file. It's important to note that"$'\n'"this does not parse the YML. This is useful if"$'\n'"you have a database container as part of your build configuration which requires a root password"$'\n'"required in other scripts; this means you do not have to replicate the value which can lead to errors."$'\n'""$'\n'"An example \`bitbucket-pipelines.yml\` file may have a header which looks like this:"$'\n'""$'\n'"    definitions:"$'\n'"    caches:"$'\n'"        apt-lists: /var/lib/apt/lists"$'\n'"        apt-cache: /var/cache/apt"$'\n'"    services:"$'\n'"        mariadb:"$'\n'"        memory: 1024"$'\n'"        image: mariadb:latest"$'\n'"        variables:"$'\n'"            MARIADB_ROOT_PASSWORD: super-secret"$'\n'""$'\n'"On this file, the value of \`\$(bitbucketGetVariable MARIADB_ROOT_PASSWORD)\` is \`super-secret\`; it uses \`grep\` and \`sed\` to extract the value."$'\n'""$'\n'""$'\n'""
example="    MARIADB_ROOT_PASSWORD=\${MARIADB_ROOT_PASSWORD:-\$(bitbucketGetVariable MARIADB_ROOT_PASSWORD not-in-bitbucket-pipelines.yml)}"$'\n'""
file="bin/build/tools/bitbucket.sh"
fn="bitbucketGetVariable"
foundNames=""
MARIADB_ROOT_PASSWORD=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/bitbucket.sh"
sourceModified="1769063211"
summary="Fetch a value from the pipelines YAML file"
usage="bitbucketGetVariable [ varName ] [ defaultValue ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mbitbucketGetVariable[0m [94m[ varName ][0m [94m[ defaultValue ][0m

    [94mvarName       [1;97mName of the value to extract from [38;2;0;255;0;48;2;0;0;0mbitbucket-pipelines.yml[0m[0m
    [94mdefaultValue  [1;97mValue if not found in pipelines[0m

Fetch a value from the pipelines YAML file

Assumes current working directory is project root.

Simple get value of a variable from the [38;2;0;255;0;48;2;0;0;0mbitbucket-pipelines.yml[0m file. It'\''s important to note that
this does not parse the YML. This is useful if
you have a database container as part of your build configuration which requires a root password
required in other scripts; this means you do not have to replicate the value which can lead to errors.

An example [38;2;0;255;0;48;2;0;0;0mbitbucket-pipelines.yml[0m file may have a header which looks like this:

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

On this file, the value of [38;2;0;255;0;48;2;0;0;0m$(bitbucketGetVariable MARIADB_ROOT_PASSWORD)[0m is [38;2;0;255;0;48;2;0;0;0msuper-secret[0m; it uses [38;2;0;255;0;48;2;0;0;0mgrep[0m and [38;2;0;255;0;48;2;0;0;0msed[0m to extract the value.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    MARIADB_ROOT_PASSWORD=${MARIADB_ROOT_PASSWORD:-$(bitbucketGetVariable MARIADB_ROOT_PASSWORD not-in-bitbucket-pipelines.yml)}
'
# shellcheck disable=SC2016
helpPlain='Usage: bitbucketGetVariable [ varName ] [ defaultValue ]

    varName       Name of the value to extract from bitbucket-pipelines.yml
    defaultValue  Value if not found in pipelines

Fetch a value from the pipelines YAML file

Assumes current working directory is project root.

Simple get value of a variable from the bitbucket-pipelines.yml file. It'\''s important to note that
this does not parse the YML. This is useful if
you have a database container as part of your build configuration which requires a root password
required in other scripts; this means you do not have to replicate the value which can lead to errors.

An example bitbucket-pipelines.yml file may have a header which looks like this:

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

On this file, the value of $(bitbucketGetVariable MARIADB_ROOT_PASSWORD) is super-secret; it uses grep and sed to extract the value.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    MARIADB_ROOT_PASSWORD=${MARIADB_ROOT_PASSWORD:-$(bitbucketGetVariable MARIADB_ROOT_PASSWORD not-in-bitbucket-pipelines.yml)}
'
