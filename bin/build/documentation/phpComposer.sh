#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="installDirectory - Directory. Required. You can pass a single argument which is the directory in your source tree to run composer. It should contain a \`composer.json\` file."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="php-composer.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Runs composer validate and install on a directory."$'\n'""$'\n'"If this fails it will output the installation log."$'\n'""$'\n'"When this tool succeeds the \`composer\` tool has run on a source tree and the \`vendor\` directory and \`composer.lock\` are often updated."$'\n'""$'\n'"This tools does not install the \`composer\` binary into the local environment."$'\n'""$'\n'""
descriptionLineCount="8"
environment="BUILD_COMPOSER_VERSION - String. Default to \`latest\`. Used to run \`docker run composer/\$BUILD_COMPOSER_VERSION\` on your code"$'\n'""
example="    phpComposer ./app/"$'\n'""
file="bin/build/tools/php-composer.sh"
fn="composer.sh"
fnMarker="phpcomposer"
foundNames=([0]="summary" [1]="fn" [2]="argument" [3]="example" [4]="local_cache" [5]="environment")
line="31"
local_cache="This tool uses the local \`.composer\` directory to cache information between builds. If you cache data between builds for speed, cache the \`.composer\` artifact if you use this tool. You do not need to do this but 2nd builds tend to be must faster with cached data."$'\n'""
rawComment="Summary: Run Composer commands on code"$'\n'"Runs composer validate and install on a directory."$'\n'"If this fails it will output the installation log."$'\n'"When this tool succeeds the \`composer\` tool has run on a source tree and the \`vendor\` directory and \`composer.lock\` are often updated."$'\n'"This tools does not install the \`composer\` binary into the local environment."$'\n'"fn: composer.sh"$'\n'"Argument: installDirectory - Directory. Required. You can pass a single argument which is the directory in your source tree to run composer. It should contain a \`composer.json\` file."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Example:     phpComposer ./app/"$'\n'"Local Cache: This tool uses the local \`.composer\` directory to cache information between builds. If you cache data between builds for speed, cache the \`.composer\` artifact if you use this tool. You do not need to do this but 2nd builds tend to be must faster with cached data."$'\n'"Environment: BUILD_COMPOSER_VERSION - String. Default to \`latest\`. Used to run \`docker run composer/\$BUILD_COMPOSER_VERSION\` on your code"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/php-composer.sh"
sourceHash="191b88f64f9eb22d42937cc44d2ed155c9750033"
sourceLine="31"
summary="Run Composer commands on code"
summaryComputed=""
usage="composer.sh installDirectory [ --help ]"
