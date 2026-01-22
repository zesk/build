#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/php.sh"
argument="--skip-tag | --no-tag - Flag. Optional. Do not tag the release."$'\n'"--name tarFileName - String. Optional. Set BUILD_TARGET via command line (wins)"$'\n'"--composer arg - Argument. Optional. Supply one or more arguments to \`phpComposer\` command. (Use multiple times)"$'\n'"--help - Flag. Optional. Display this help."$'\n'"environmentVariable ... - EnvironmentVariable. Optional. Environment variables to build into the deployed .env file"$'\n'"-- - Separator. Required. Separates environment variables to file list"$'\n'"file1 file2 dir3 ... - File|Directory. Required. List of files and directories to build into the application package."$'\n'""
base="php.sh"
description="Build deployment using composer, adding environment values to .env and packaging vendor and additional"$'\n'"files into target file, usually \`BUILD_TARGET\`"$'\n'""$'\n'"Override target file generated with environment variable \`BUILD_TARGET\` which must ae set during build"$'\n'"and on remote systems during deployment."$'\n'""$'\n'"Files are specified from the application root directory."$'\n'""$'\n'"\`{fn}\` generates the \`.build.env\` file, which contains the current environment and:"$'\n'""$'\n'"- BUILD_TARGET"$'\n'"- BUILD_START_TIMESTAMP"$'\n'"- APPLICATION_TAG"$'\n'"- APPLICATION_ID"$'\n'""$'\n'""
file="bin/build/tools/php.sh"
fn="phpBuild"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="BUILD_TARGET.sh"$'\n'""
sourceFile="bin/build/tools/php.sh"
sourceModified="1768759583"
summary="Build deployment using composer, adding environment values to .env and"
usage="phpBuild [ --skip-tag | --no-tag ] [ --name tarFileName ] [ --composer arg ] [ --help ] [ environmentVariable ... ] -- file1 file2 dir3 ..."
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mphpBuild[0m [94m[ --skip-tag | --no-tag ][0m [94m[ --name tarFileName ][0m [94m[ --composer arg ][0m [94m[ --help ][0m [94m[ environmentVariable ... ][0m [38;2;255;255;0m[35;48;2;0;0;0m [38;2;255;255;0m[35;48;2;0;0;0mfile1 file2 dir3 ...[0m[0m

    [94m--skip-tag | --no-tag    [1;97mFlag. Optional. Do not tag the release.[0m
    [94m--name tarFileName       [1;97mString. Optional. Set BUILD_TARGET via command line (wins)[0m
    [94m--composer arg           [1;97mArgument. Optional. Supply one or more arguments to [38;2;0;255;0;48;2;0;0;0mphpComposer[0m command. (Use multiple times)[0m
    [94m--help                   [1;97mFlag. Optional. Display this help.[0m
    [94menvironmentVariable ...  [1;97mEnvironmentVariable. Optional. Environment variables to build into the deployed .env file[0m
    [31m--                       [1;97mSeparator. Required. Separates environment variables to file list[0m
    [31mfile1 file2 dir3 ...     [1;97mFile|Directory. Required. List of files and directories to build into the application package.[0m

Build deployment using composer, adding environment values to .env and packaging vendor and additional
files into target file, usually [38;2;0;255;0;48;2;0;0;0mBUILD_TARGET[0m

Override target file generated with environment variable [38;2;0;255;0;48;2;0;0;0mBUILD_TARGET[0m which must ae set during build
and on remote systems during deployment.

Files are specified from the application root directory.

[38;2;0;255;0;48;2;0;0;0mphpBuild[0m generates the [38;2;0;255;0;48;2;0;0;0m.build.env[0m file, which contains the current environment and:

- BUILD_TARGET
- BUILD_START_TIMESTAMP
- APPLICATION_TAG
- APPLICATION_ID

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: phpBuild [ --skip-tag | --no-tag ] [ --name tarFileName ] [ --composer arg ] [ --help ] [ environmentVariable ... ]  file1 file2 dir3 ...

    --skip-tag | --no-tag    Flag. Optional. Do not tag the release.
    --name tarFileName       String. Optional. Set BUILD_TARGET via command line (wins)
    --composer arg           Argument. Optional. Supply one or more arguments to phpComposer command. (Use multiple times)
    --help                   Flag. Optional. Display this help.
    environmentVariable ...  EnvironmentVariable. Optional. Environment variables to build into the deployed .env file
    --                       Separator. Required. Separates environment variables to file list
    file1 file2 dir3 ...     File|Directory. Required. List of files and directories to build into the application package.

Build deployment using composer, adding environment values to .env and packaging vendor and additional
files into target file, usually BUILD_TARGET

Override target file generated with environment variable BUILD_TARGET which must ae set during build
and on remote systems during deployment.

Files are specified from the application root directory.

phpBuild generates the .build.env file, which contains the current environment and:

- BUILD_TARGET
- BUILD_START_TIMESTAMP
- APPLICATION_TAG
- APPLICATION_ID

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
