#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--env-file envFile - File. Optional. Environment file to load - can handle any format."$'\n'"--debug - Flag. Optional. Enable debugging."$'\n'"--first - Flag. Optional. When it is the first deployment, use this flag."$'\n'"--home deployPath - Directory. Required. Path where the deployments database is on remote system. Uses"$'\n'"--id applicationId - String. Required. If not specified, uses environment variable loaded from \`.build.env\`, or \`APPLICATION_ID\` environment."$'\n'"--application applicationPath - String. Required. Path on the remote system where the application is live. If not specified, uses environment variable loaded from \`.build.env\`, or \`APPLICATION_REMOTE_HOME\` environment."$'\n'"--target targetPackage - Filename. Optional. Package name usually an archive format.  If not specified, uses environment variable loaded from \`.build.env\`, or \`BUILD_TARGET\` environment. Defaults to \`app.tar.gz\`."$'\n'""
base="deployment.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Deploy to a host"$'\n'""$'\n'"Loads \`./.build.env\` if it exists."$'\n'"Not possible to deploy to different paths on different hosts, currently. Hosts are assumeed to be similar."$'\n'""$'\n'""
descriptionLineCount="5"
environment="DEPLOY_REMOTE_HOME - path on remote host for deployment data"$'\n'"APPLICATION_REMOTE_HOME - path on remote host for application"$'\n'"DEPLOY_USER_HOSTS - list of user@host (will be tokenized by spaces regardless of shell quoting)"$'\n'"APPLICATION_ID - Version to be deployed"$'\n'"BUILD_TARGET - The application package name"$'\n'""
file="bin/build/tools/deployment.sh"
fn="deployBuildEnvironment"
fnMarker="deploybuildenvironment"
foundNames=([0]="argument" [1]="file" [2]="environment" [3]="test")
line="33"
rawComment="Deploy to a host"$'\n'"Argument: --env-file envFile - File. Optional. Environment file to load - can handle any format."$'\n'"Argument: --debug - Flag. Optional. Enable debugging."$'\n'"Argument: --first - Flag. Optional. When it is the first deployment, use this flag."$'\n'"Argument: --home deployPath - Directory. Required. Path where the deployments database is on remote system. Uses"$'\n'"Argument: --id applicationId - String. Required. If not specified, uses environment variable loaded from \`.build.env\`, or \`APPLICATION_ID\` environment."$'\n'"Argument: --application applicationPath - String. Required. Path on the remote system where the application is live. If not specified, uses environment variable loaded from \`.build.env\`, or \`APPLICATION_REMOTE_HOME\` environment."$'\n'"Argument: --target targetPackage - Filename. Optional. Package name usually an archive format.  If not specified, uses environment variable loaded from \`.build.env\`, or \`BUILD_TARGET\` environment. Defaults to \`app.tar.gz\`."$'\n'"Loads \`./.build.env\` if it exists."$'\n'"File: \`./.build.env\`"$'\n'"Environment: DEPLOY_REMOTE_HOME - path on remote host for deployment data"$'\n'"Environment: APPLICATION_REMOTE_HOME - path on remote host for application"$'\n'"Environment: DEPLOY_USER_HOSTS - list of user@host (will be tokenized by spaces regardless of shell quoting)"$'\n'"Environment: APPLICATION_ID - Version to be deployed"$'\n'"Environment: BUILD_TARGET - The application package name"$'\n'"Not possible to deploy to different paths on different hosts, currently. Hosts are assumeed to be similar."$'\n'"Test: testDeployBuildEnvironment - INCOMPLETE"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/deployment.sh"
sourceHash="8e4e379d9aaaaa4b4560dc874686ea6f80f0699f"
sourceLine="33"
summary="Deploy to a host"
summaryComputed="true"
test="testDeployBuildEnvironment - INCOMPLETE"$'\n'""
usage="deployBuildEnvironment [ --env-file envFile ] [ --debug ] [ --first ] --home deployPath --id applicationId --application applicationPath [ --target targetPackage ]"
