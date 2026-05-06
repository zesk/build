#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
MARIADB_ROOT_PASSWORD=""
argument="varName - Name of the value to extract from \`bitbucket-pipelines.yml\`"$'\n'"defaultValue - Value if not found in pipelines"$'\n'""
base="bitbucket.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Fetch a value from the pipelines YAML file"$'\n'""$'\n'"Assumes current working directory is project root."$'\n'""$'\n'"Simple get value of a variable from the \`bitbucket-pipelines.yml\` file. It's important to note that"$'\n'"this does not parse the YML. This is useful if"$'\n'"you have a database container as part of your build configuration which requires a root password"$'\n'"required in other scripts; this means you do not have to replicate the value which can lead to errors."$'\n'""$'\n'"An example \`bitbucket-pipelines.yml\` file may have a header which looks like this:"$'\n'""$'\n'"    definitions:"$'\n'"    caches:"$'\n'"    services:"$'\n'"        mariadb:"$'\n'"        variables:"$'\n'""$'\n'"On this file, the value of \`\$(bitbucketGetVariable MARIADB_ROOT_PASSWORD)\` is \`super-secret\`; it uses \`grep\` and \`sed\` to extract the value."$'\n'""$'\n'""
descriptionLineCount="19"
example="    MARIADB_ROOT_PASSWORD=\${MARIADB_ROOT_PASSWORD:-\$(bitbucketGetVariable MARIADB_ROOT_PASSWORD not-in-bitbucket-pipelines.yml)}"$'\n'""
file="bin/build/tools/bitbucket.sh"
fn="bitbucketGetVariable"
fnMarker="bitbucketgetvariable"
foundNames=([0]="________apt_lists" [1]="________apt_cache" [2]="________memory" [3]="________image" [4]="____________mariadb_root_password" [5]="argument" [6]="example")
line="39"
rawComment="Fetch a value from the pipelines YAML file"$'\n'"Assumes current working directory is project root."$'\n'"Simple get value of a variable from the \`bitbucket-pipelines.yml\` file. It's important to note that"$'\n'"this does not parse the YML. This is useful if"$'\n'"you have a database container as part of your build configuration which requires a root password"$'\n'"required in other scripts; this means you do not have to replicate the value which can lead to errors."$'\n'"An example \`bitbucket-pipelines.yml\` file may have a header which looks like this:"$'\n'"    definitions:"$'\n'"    caches:"$'\n'"        apt-lists: /var/lib/apt/lists"$'\n'"        apt-cache: /var/cache/apt"$'\n'"    services:"$'\n'"        mariadb:"$'\n'"        memory: 1024"$'\n'"        image: mariadb:latest"$'\n'"        variables:"$'\n'"            MARIADB_ROOT_PASSWORD: super-secret"$'\n'"On this file, the value of \`\$(bitbucketGetVariable MARIADB_ROOT_PASSWORD)\` is \`super-secret\`; it uses \`grep\` and \`sed\` to extract the value."$'\n'"Argument: varName - Name of the value to extract from \`bitbucket-pipelines.yml\`"$'\n'"Argument: defaultValue - Value if not found in pipelines"$'\n'"Example:     MARIADB_ROOT_PASSWORD=\${MARIADB_ROOT_PASSWORD:-\$(bitbucketGetVariable MARIADB_ROOT_PASSWORD not-in-bitbucket-pipelines.yml)}"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/bitbucket.sh"
sourceHash="1f4c241b99592c40a01d7716c3276a12de251352"
sourceLine="39"
summary="Fetch a value from the pipelines YAML file"
summaryComputed="true"
usage="bitbucketGetVariable [ varName ] [ defaultValue ]"
