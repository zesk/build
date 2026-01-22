#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/docker-compose.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"--handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"--production - Flag. Production container build. Shortcut for \`--deployment production\` (uses \`.PRODUCTION.env\`)"$'\n'"--staging - Flag. Staging container build. Shortcut for \`--deployment staging\` (uses \`.STAGING.env\`)"$'\n'"--deployment deploymentName - String. Deployment name to use. (uses \`.\$(uppercase \"\$deploymentName\").env\`)"$'\n'"--volume - String. Name of the volume associated with the container to preserve or delete."$'\n'"--build - Flag. \`build\` command with volume management"$'\n'"--clean - Flag. Delete the volume prior to building."$'\n'"--keep - Flag. Keep the volume during build."$'\n'"--default-env | --env environmentNameValue - EnvironmentNameValue. An environment variable name and value (in the form \`NAME=value\` to require in the \`.env\` file."$'\n'"--env environmentNameValue - EnvironmentNameValue. An environment variable name and value (in the form \`NAME=value\` to require in the \`.env\` file. If set already in the file or in the environment then has no effect."$'\n'"--arg environmentNameValue - EnvironmentNameValue. Passed as an ARG to the build environment – a variable name and value (in the form \`NAME=value\` to require in the \`.env\` file. If set already in the file or in the environment then has no effect."$'\n'"composeCommand - You can send any compose command and arguments thereafter are passed to \`docker compose\`"$'\n'""
base="docker-compose.sh"
description="docker compose wrapper with automatic .env support"$'\n'""$'\n'"Environment files are managed automatically by this function (with backups)."$'\n'"Environment files are named in uppercase after the deployment as \`.DEPLOYMENT.env\` in the home directory"$'\n'""$'\n'"So, \`.STAGING.env\` and \`.PRODUCTION.env\` are the default environments. They are copied into \`.env\` with any additional required"$'\n'"default environment variables (including \`DEPLOYMENT=\`), and then this \`.env\` file serves as the basis for both the"$'\n'"\`docker-compose.yml\` generation (any variable defined here is mapped into this file - by default) and ultimately may be"$'\n'"copied into the container as configuration settings."$'\n'""$'\n'"Custom deployment settings can be set up using the \`--deployment deploymentName\` argument."$'\n'""$'\n'"Volume name, by default is named after the directory name of the project suffixed with \`_database_data\`."$'\n'""
file="bin/build/tools/docker-compose.sh"
fn="dockerCompose"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/docker-compose.sh"
sourceModified="1768721469"
summary="docker compose wrapper with automatic .env support"
usage="dockerCompose [ --help ] [ --handler handler ] [ --production ] [ --staging ] [ --deployment deploymentName ] [ --volume ] [ --build ] [ --clean ] [ --keep ] [ --default-env | --env environmentNameValue ] [ --env environmentNameValue ] [ --arg environmentNameValue ] [ composeCommand ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mdockerCompose[0m [94m[ --help ][0m [94m[ --handler handler ][0m [94m[ --production ][0m [94m[ --staging ][0m [94m[ --deployment deploymentName ][0m [94m[ --volume ][0m [94m[ --build ][0m [94m[ --clean ][0m [94m[ --keep ][0m [94m[ --default-env | --env environmentNameValue ][0m [94m[ --env environmentNameValue ][0m [94m[ --arg environmentNameValue ][0m [94m[ composeCommand ][0m

    [94m--help                                      [1;97mFlag. Optional. Display this help.[0m
    [94m--handler handler                           [1;97mFunction. Optional. Use this error handler instead of the default error handler.[0m
    [94m--production                                [1;97mFlag. Production container build. Shortcut for [38;2;0;255;0;48;2;0;0;0m--deployment production[0m (uses [38;2;0;255;0;48;2;0;0;0m.PRODUCTION.env[0m)[0m
    [94m--staging                                   [1;97mFlag. Staging container build. Shortcut for [38;2;0;255;0;48;2;0;0;0m--deployment staging[0m (uses [38;2;0;255;0;48;2;0;0;0m.STAGING.env[0m)[0m
    [94m--deployment deploymentName                 [1;97mString. Deployment name to use. (uses [38;2;0;255;0;48;2;0;0;0m.$(uppercase "$deploymentName").env[0m)[0m
    [94m--volume                                    [1;97mString. Name of the volume associated with the container to preserve or delete.[0m
    [94m--build                                     [1;97mFlag. [38;2;0;255;0;48;2;0;0;0mbuild[0m command with volume management[0m
    [94m--clean                                     [1;97mFlag. Delete the volume prior to building.[0m
    [94m--keep                                      [1;97mFlag. Keep the volume during build.[0m
    [94m--default-env | --env environmentNameValue  [1;97mEnvironmentNameValue. An environment variable name and value (in the form [38;2;0;255;0;48;2;0;0;0mNAME=value[0m to require in the [38;2;0;255;0;48;2;0;0;0m.env[0m file.[0m
    [94m--env environmentNameValue                  [1;97mEnvironmentNameValue. An environment variable name and value (in the form [38;2;0;255;0;48;2;0;0;0mNAME=value[0m to require in the [38;2;0;255;0;48;2;0;0;0m.env[0m file. If set already in the file or in the environment then has no effect.[0m
    [94m--arg environmentNameValue                  [1;97mEnvironmentNameValue. Passed as an ARG to the build environment – a variable name and value (in the form [38;2;0;255;0;48;2;0;0;0mNAME=value[0m to require in the [38;2;0;255;0;48;2;0;0;0m.env[0m file. If set already in the file or in the environment then has no effect.[0m
    [94mcomposeCommand                              [1;97mYou can send any compose command and arguments thereafter are passed to [38;2;0;255;0;48;2;0;0;0mdocker compose[0m[0m

docker compose wrapper with automatic .env support

Environment files are managed automatically by this function (with backups).
Environment files are named in uppercase after the deployment as [38;2;0;255;0;48;2;0;0;0m.DEPLOYMENT.env[0m in the home directory

So, [38;2;0;255;0;48;2;0;0;0m.STAGING.env[0m and [38;2;0;255;0;48;2;0;0;0m.PRODUCTION.env[0m are the default environments. They are copied into [38;2;0;255;0;48;2;0;0;0m.env[0m with any additional required
default environment variables (including [38;2;0;255;0;48;2;0;0;0mDEPLOYMENT=[0m), and then this [38;2;0;255;0;48;2;0;0;0m.env[0m file serves as the basis for both the
[38;2;0;255;0;48;2;0;0;0mdocker-compose.yml[0m generation (any variable defined here is mapped into this file - by default) and ultimately may be
copied into the container as configuration settings.

Custom deployment settings can be set up using the [38;2;0;255;0;48;2;0;0;0m--deployment deploymentName[0m argument.

Volume name, by default is named after the directory name of the project suffixed with [38;2;0;255;0;48;2;0;0;0m_database_data[0m.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: dockerCompose [ --help ] [ --handler handler ] [ --production ] [ --staging ] [ --deployment deploymentName ] [ --volume ] [ --build ] [ --clean ] [ --keep ] [ --default-env | --env environmentNameValue ] [ --env environmentNameValue ] [ --arg environmentNameValue ] [ composeCommand ]

    --help                                      Flag. Optional. Display this help.
    --handler handler                           Function. Optional. Use this error handler instead of the default error handler.
    --production                                Flag. Production container build. Shortcut for --deployment production (uses .PRODUCTION.env)
    --staging                                   Flag. Staging container build. Shortcut for --deployment staging (uses .STAGING.env)
    --deployment deploymentName                 String. Deployment name to use. (uses .$(uppercase "$deploymentName").env)
    --volume                                    String. Name of the volume associated with the container to preserve or delete.
    --build                                     Flag. build command with volume management
    --clean                                     Flag. Delete the volume prior to building.
    --keep                                      Flag. Keep the volume during build.
    --default-env | --env environmentNameValue  EnvironmentNameValue. An environment variable name and value (in the form NAME=value to require in the .env file.
    --env environmentNameValue                  EnvironmentNameValue. An environment variable name and value (in the form NAME=value to require in the .env file. If set already in the file or in the environment then has no effect.
    --arg environmentNameValue                  EnvironmentNameValue. Passed as an ARG to the build environment – a variable name and value (in the form NAME=value to require in the .env file. If set already in the file or in the environment then has no effect.
    composeCommand                              You can send any compose command and arguments thereafter are passed to docker compose

docker compose wrapper with automatic .env support

Environment files are managed automatically by this function (with backups).
Environment files are named in uppercase after the deployment as .DEPLOYMENT.env in the home directory

So, .STAGING.env and .PRODUCTION.env are the default environments. They are copied into .env with any additional required
default environment variables (including DEPLOYMENT=), and then this .env file serves as the basis for both the
docker-compose.yml generation (any variable defined here is mapped into this file - by default) and ultimately may be
copied into the container as configuration settings.

Custom deployment settings can be set up using the --deployment deploymentName argument.

Volume name, by default is named after the directory name of the project suffixed with _database_data.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
