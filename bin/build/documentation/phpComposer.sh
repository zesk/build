#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/php-composer.sh"
argument="installDirectory - Directory. Required. You can pass a single argument which is the directory in your source tree to run composer. It should contain a \`composer.json\` file."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="php-composer.sh"
description="Runs composer validate and install on a directory."$'\n'""$'\n'"If this fails it will output the installation log."$'\n'""$'\n'"When this tool succeeds the \`composer\` tool has run on a source tree and the \`vendor\` directory and \`composer.lock\` are often updated."$'\n'""$'\n'"This tools does not install the \`composer\` binary into the local environment."$'\n'""$'\n'""$'\n'"Local Cache: This tool uses the local \`.composer\` directory to cache information between builds. If you cache data between builds for speed, cache the \`.composer\` artifact if you use this tool. You do not need to do this but 2nd builds tend to be must faster with cached data."$'\n'""$'\n'""$'\n'"shellcheck disable=SC2120"$'\n'""
environment="BUILD_COMPOSER_VERSION - String. Default to \`latest\`. Used to run \`docker run composer/\$BUILD_COMPOSER_VERSION\` on your code"$'\n'""
example="    phpComposer ./app/"$'\n'""
file="bin/build/tools/php-composer.sh"
fn="composer.sh"
foundNames=([0]="summary" [1]="fn" [2]="argument" [3]="example" [4]="environment")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/php-composer.sh"
sourceModified="1768721470"
summary="Run Composer commands on code"$'\n'""
usage="composer.sh installDirectory [ --help ]"
