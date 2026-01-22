#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/php-composer.sh"
argument="installDirectory - Directory. Required. You can pass a single argument which is the directory in your source tree to run composer. It should contain a \`composer.json\` file."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="php-composer.sh"
description="Runs composer validate and install on a directory."$'\n'""$'\n'"If this fails it will output the installation log."$'\n'""$'\n'"When this tool succeeds the \`composer\` tool has run on a source tree and the \`vendor\` directory and \`composer.lock\` are often updated."$'\n'""$'\n'"This tools does not install the \`composer\` binary into the local environment."$'\n'""$'\n'""$'\n'"Local Cache: This tool uses the local \`.composer\` directory to cache information between builds. If you cache data between builds for speed, cache the \`.composer\` artifact if you use this tool. You do not need to do this but 2nd builds tend to be must faster with cached data."$'\n'""$'\n'""$'\n'"shellcheck disable=SC2120"$'\n'""
environment="BUILD_COMPOSER_VERSION - String. Default to \`latest\`. Used to run \`docker run composer/\$BUILD_COMPOSER_VERSION\` on your code"$'\n'""
example="    phpComposer ./app/"$'\n'""
file="bin/build/tools/php-composer.sh"
fn="composer.sh"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/php-composer.sh"
sourceModified="1769063211"
summary="Run Composer commands on code"$'\n'""
usage="composer.sh installDirectory [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mcomposer.sh[0m [38;2;255;255;0m[35;48;2;0;0;0minstallDirectory[0m[0m [94m[ --help ][0m

    [31minstallDirectory  [1;97mDirectory. Required. You can pass a single argument which is the directory in your source tree to run composer. It should contain a [38;2;0;255;0;48;2;0;0;0mcomposer.json[0m file.[0m
    [94m--help            [1;97mFlag. Optional. Display this help.[0m

Runs composer validate and install on a directory.

If this fails it will output the installation log.

When this tool succeeds the [38;2;0;255;0;48;2;0;0;0mcomposer[0m tool has run on a source tree and the [38;2;0;255;0;48;2;0;0;0mvendor[0m directory and [38;2;0;255;0;48;2;0;0;0mcomposer.lock[0m are often updated.

This tools does not install the [38;2;0;255;0;48;2;0;0;0mcomposer[0m binary into the local environment.


Local Cache: This tool uses the local [38;2;0;255;0;48;2;0;0;0m.composer[0m directory to cache information between builds. If you cache data between builds for speed, cache the [38;2;0;255;0;48;2;0;0;0m.composer[0m artifact if you use this tool. You do not need to do this but 2nd builds tend to be must faster with cached data.


shellcheck disable=SC2120

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- BUILD_COMPOSER_VERSION - String. Default to [38;2;0;255;0;48;2;0;0;0mlatest[0m. Used to run [38;2;0;255;0;48;2;0;0;0mdocker run composer/$BUILD_COMPOSER_VERSION[0m on your code
- 

Example:
    phpComposer ./app/
'
# shellcheck disable=SC2016
helpPlain='Usage: composer.sh installDirectory [ --help ]

    installDirectory  Directory. Required. You can pass a single argument which is the directory in your source tree to run composer. It should contain a composer.json file.
    --help            Flag. Optional. Display this help.

Runs composer validate and install on a directory.

If this fails it will output the installation log.

When this tool succeeds the composer tool has run on a source tree and the vendor directory and composer.lock are often updated.

This tools does not install the composer binary into the local environment.


Local Cache: This tool uses the local .composer directory to cache information between builds. If you cache data between builds for speed, cache the .composer artifact if you use this tool. You do not need to do this but 2nd builds tend to be must faster with cached data.


shellcheck disable=SC2120

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- BUILD_COMPOSER_VERSION - String. Default to latest. Used to run docker run composer/$BUILD_COMPOSER_VERSION on your code
- 

Example:
    phpComposer ./app/
'
