#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/bitbucket.sh"
argument="varName - Name of the value to extract from \`bitbucket-pipelines.yml\`"$'\n'"defaultValue - Value if not found in pipelines"$'\n'""
base="bitbucket.sh"
description="Fetch a value from the pipelines YAML file"$'\n'""$'\n'"Assumes current working directory is project root."$'\n'""$'\n'"Simple get value of a variable from the \`bitbucket-pipelines.yml\` file. It's important to note that"$'\n'"this does not parse the YML. This is useful if"$'\n'"you have a database container as part of your build configuration which requires a root password"$'\n'"required in other scripts; this means you do not have to replicate the value which can lead to errors."$'\n'""$'\n'"An example \`bitbucket-pipelines.yml\` file may have a header which looks like this:"$'\n'""$'\n'"    definitions:"$'\n'"    caches:"$'\n'"        apt-lists: /var/lib/apt/lists"$'\n'"        apt-cache: /var/cache/apt"$'\n'"    services:"$'\n'"        mariadb:"$'\n'"        memory: 1024"$'\n'"        image: mariadb:latest"$'\n'"        variables:"$'\n'"            MARIADB_ROOT_PASSWORD: super-secret"$'\n'""$'\n'"On this file, the value of \`\$(bitbucketGetVariable MARIADB_ROOT_PASSWORD)\` is \`super-secret\`; it uses \`grep\` and \`sed\` to extract the value."$'\n'""$'\n'""$'\n'""
example="    MARIADB_ROOT_PASSWORD=\${MARIADB_ROOT_PASSWORD:-\$(bitbucketGetVariable MARIADB_ROOT_PASSWORD not-in-bitbucket-pipelines.yml)}"$'\n'""
file="bin/build/tools/bitbucket.sh"
fn="bitbucketGetVariable"
foundNames=([0]="argument" [1]="example")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""$'\n'""$'\n'""
source="bin/build/tools/bitbucket.sh"
sourceModified="1768588589"
summary="Fetch a value from the pipelines YAML file"
usage="bitbucketGetVariable [ varName ] [ defaultValue ]"
