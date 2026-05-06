#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--skip-tag | --no-tag - Flag. Optional. Do not tag the release."$'\n'"--name tarFileName - String. Optional. Set BUILD_TARGET via command line (wins)"$'\n'"--composer arg - Argument. Optional. Supply one or more arguments to \`phpComposer\` command. (Use multiple times)"$'\n'"--help - Flag. Optional. Display this help."$'\n'"environmentVariable ... - EnvironmentVariable. Optional. Environment variables to build into the deployed .env file"$'\n'"-- - Separator. Required. Separates environment variables to file list"$'\n'"file1 file2 dir3 ... - File|Directory. Required. List of files and directories to build into the application package."$'\n'""
base="php.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Build deployment using composer, adding environment values to .env and packaging vendor and additional"$'\n'"files into target file, usually \`BUILD_TARGET\`"$'\n'""$'\n'"Override target file generated with environment variable \`BUILD_TARGET\` which must ae set during build"$'\n'"and on remote systems during deployment."$'\n'""$'\n'"Files are specified from the application root directory."$'\n'""$'\n'"\`{fn}\` generates the \`.build.env\` file, which contains the current environment and:"$'\n'""$'\n'"- BUILD_TARGET"$'\n'"- BUILD_START_TIMESTAMP"$'\n'"- APPLICATION_TAG"$'\n'"- APPLICATION_ID"$'\n'""$'\n'""
descriptionLineCount="15"
file="bin/build/tools/php.sh"
fn="phpBuild"
fnMarker="phpbuild"
foundNames=([0]="argument" [1]="see")
line="157"
rawComment="Build deployment using composer, adding environment values to .env and packaging vendor and additional"$'\n'"files into target file, usually \`BUILD_TARGET\`"$'\n'"Override target file generated with environment variable \`BUILD_TARGET\` which must ae set during build"$'\n'"and on remote systems during deployment."$'\n'"Files are specified from the application root directory."$'\n'"\`{fn}\` generates the \`.build.env\` file, which contains the current environment and:"$'\n'"- BUILD_TARGET"$'\n'"- BUILD_START_TIMESTAMP"$'\n'"- APPLICATION_TAG"$'\n'"- APPLICATION_ID"$'\n'"Argument: --skip-tag | --no-tag - Flag. Optional. Do not tag the release."$'\n'"Argument: --name tarFileName - String. Optional. Set BUILD_TARGET via command line (wins)"$'\n'"Argument: --composer arg - Argument. Optional. Supply one or more arguments to \`phpComposer\` command. (Use multiple times)"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: environmentVariable ... - EnvironmentVariable. Optional. Environment variables to build into the deployed .env file"$'\n'"Argument: -- - Separator. Required. Separates environment variables to file list"$'\n'"Argument: file1 file2 dir3 ... - File|Directory. Required. List of files and directories to build into the application package."$'\n'"See: BUILD_TARGET.sh"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="BUILD_TARGET.sh"$'\n'""
sourceFile="bin/build/tools/php.sh"
sourceHash="cd2691e7c6370ed405b6513e2b412ce1541ca05b"
sourceLine="157"
summary="Build deployment using composer, adding environment values to .env and"
summaryComputed="true"
usage="phpBuild [ --skip-tag | --no-tag ] [ --name tarFileName ] [ --composer arg ] [ --help ] [ environmentVariable ... ] -- file1 file2 dir3 ..."
