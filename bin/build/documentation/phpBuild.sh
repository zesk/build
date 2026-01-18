#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/php.sh"
argument="--skip-tag | --no-tag - Flag. Optional. Do not tag the release."$'\n'"--name tarFileName - String. Optional. Set BUILD_TARGET via command line (wins)"$'\n'"--composer arg - Argument. Optional. Supply one or more arguments to \`phpComposer\` command. (Use multiple times)"$'\n'"--help - Flag. Optional. Display this help."$'\n'"environmentVariable ... - EnvironmentVariable. Optional. Environment variables to build into the deployed .env file"$'\n'"-- - Separator. Required. Separates environment variables to file list"$'\n'"file1 file2 dir3 ... - File|Directory. Required. List of files and directories to build into the application package."$'\n'""
base="php.sh"
description="Build deployment using composer, adding environment values to .env and packaging vendor and additional"$'\n'"files into target file, usually \`BUILD_TARGET\`"$'\n'""$'\n'"Override target file generated with environment variable \`BUILD_TARGET\` which must ae set during build"$'\n'"and on remote systems during deployment."$'\n'""$'\n'"Files are specified from the application root directory."$'\n'""$'\n'"\`{fn}\` generates the \`.build.env\` file, which contains the current environment and:"$'\n'""$'\n'"- BUILD_TARGET"$'\n'"- BUILD_START_TIMESTAMP"$'\n'"- APPLICATION_TAG"$'\n'"- APPLICATION_ID"$'\n'""$'\n'""
file="bin/build/tools/php.sh"
fn="phpBuild"
foundNames=([0]="argument" [1]="see")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="BUILD_TARGET.sh"$'\n'""
source="bin/build/tools/php.sh"
sourceModified="1768759583"
summary="Build deployment using composer, adding environment values to .env and"
usage="phpBuild [ --skip-tag | --no-tag ] [ --name tarFileName ] [ --composer arg ] [ --help ] [ environmentVariable ... ] -- file1 file2 dir3 ..."
