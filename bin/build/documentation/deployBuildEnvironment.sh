#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/deployment.sh"
argument="--env-file envFile - File. Optional. Environment file to load - can handle any format."$'\n'"--debug - Flag. Optional. Enable debugging."$'\n'"--first - Flag. Optional. When it is the first deployment, use this flag."$'\n'"--home deployPath - Directory. Required. Path where the deployments database is on remote system. Uses"$'\n'"--id applicationId - String. Required. If not specified, uses environment variable loaded from \`.build.env\`, or \`APPLICATION_ID\` environment."$'\n'"--application applicationPath - String. Required. Path on the remote system where the application is live. If not specified, uses environment variable loaded from \`.build.env\`, or \`APPLICATION_REMOTE_HOME\` environment."$'\n'"--target targetPackage - Filename. Optional. Package name usually an archive format.  If not specified, uses environment variable loaded from \`.build.env\`, or \`BUILD_TARGET\` environment. Defaults to \`app.tar.gz\`."$'\n'""
base="deployment.sh"
description="Deploy to a host"$'\n'""$'\n'"Loads \`./.build.env\` if it exists."$'\n'"Not possible to deploy to different paths on different hosts, currently. Hosts are assumeed to be similar."$'\n'""$'\n'""
environment="DEPLOY_REMOTE_HOME - path on remote host for deployment data"$'\n'"APPLICATION_REMOTE_HOME - path on remote host for application"$'\n'"DEPLOY_USER_HOSTS - list of user@host (will be tokenized by spaces regardless of shell quoting)"$'\n'"APPLICATION_ID - Version to be deployed"$'\n'"BUILD_TARGET - The application package name"$'\n'""
file="bin/build/tools/deployment.sh"
fn="deployBuildEnvironment"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/deployment.sh"
sourceModified="1768797824"
summary="Deploy to a host"
test="testDeployBuildEnvironment - INCOMPLETE"$'\n'""
usage="deployBuildEnvironment [ --env-file envFile ] [ --debug ] [ --first ] --home deployPath --id applicationId --application applicationPath [ --target targetPackage ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mdeployBuildEnvironment[0m [94m[ --env-file envFile ][0m [94m[ --debug ][0m [94m[ --first ][0m [38;2;255;255;0m[35;48;2;0;0;0m--home deployPath[0m[0m [38;2;255;255;0m[35;48;2;0;0;0m--id applicationId[0m[0m [38;2;255;255;0m[35;48;2;0;0;0m--application applicationPath[0m[0m [94m[ --target targetPackage ][0m

    [94m--env-file envFile             [1;97mFile. Optional. Environment file to load - can handle any format.[0m
    [94m--debug                        [1;97mFlag. Optional. Enable debugging.[0m
    [94m--first                        [1;97mFlag. Optional. When it is the first deployment, use this flag.[0m
    [31m--home deployPath              [1;97mDirectory. Required. Path where the deployments database is on remote system. Uses[0m
    [31m--id applicationId             [1;97mString. Required. If not specified, uses environment variable loaded from [38;2;0;255;0;48;2;0;0;0m.build.env[0m, or [38;2;0;255;0;48;2;0;0;0mAPPLICATION_ID[0m environment.[0m
    [31m--application applicationPath  [1;97mString. Required. Path on the remote system where the application is live. If not specified, uses environment variable loaded from [38;2;0;255;0;48;2;0;0;0m.build.env[0m, or [38;2;0;255;0;48;2;0;0;0mAPPLICATION_REMOTE_HOME[0m environment.[0m
    [94m--target targetPackage         [1;97mFilename. Optional. Package name usually an archive format.  If not specified, uses environment variable loaded from [38;2;0;255;0;48;2;0;0;0m.build.env[0m, or [38;2;0;255;0;48;2;0;0;0mBUILD_TARGET[0m environment. Defaults to [38;2;0;255;0;48;2;0;0;0mapp.tar.gz[0m.[0m

Deploy to a host

Loads [38;2;0;255;0;48;2;0;0;0m./.build.env[0m if it exists.
Not possible to deploy to different paths on different hosts, currently. Hosts are assumeed to be similar.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- DEPLOY_REMOTE_HOME - path on remote host for deployment data
- APPLICATION_REMOTE_HOME - path on remote host for application
- DEPLOY_USER_HOSTS - list of user@host (will be tokenized by spaces regardless of shell quoting)
- APPLICATION_ID - Version to be deployed
- BUILD_TARGET - The application package name
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: deployBuildEnvironment [ --env-file envFile ] [ --debug ] [ --first ] --home deployPath --id applicationId --application applicationPath [ --target targetPackage ]

    --env-file envFile             File. Optional. Environment file to load - can handle any format.
    --debug                        Flag. Optional. Enable debugging.
    --first                        Flag. Optional. When it is the first deployment, use this flag.
    --home deployPath              Directory. Required. Path where the deployments database is on remote system. Uses
    --id applicationId             String. Required. If not specified, uses environment variable loaded from .build.env, or APPLICATION_ID environment.
    --application applicationPath  String. Required. Path on the remote system where the application is live. If not specified, uses environment variable loaded from .build.env, or APPLICATION_REMOTE_HOME environment.
    --target targetPackage         Filename. Optional. Package name usually an archive format.  If not specified, uses environment variable loaded from .build.env, or BUILD_TARGET environment. Defaults to app.tar.gz.

Deploy to a host

Loads ./.build.env if it exists.
Not possible to deploy to different paths on different hosts, currently. Hosts are assumeed to be similar.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- DEPLOY_REMOTE_HOME - path on remote host for deployment data
- APPLICATION_REMOTE_HOME - path on remote host for application
- DEPLOY_USER_HOSTS - list of user@host (will be tokenized by spaces regardless of shell quoting)
- APPLICATION_ID - Version to be deployed
- BUILD_TARGET - The application package name
- 
'
