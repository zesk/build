#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/deployment.sh"
argument="--env-file envFile - File. Optional.Environment file to load - can handle any format."$'\n'"--debug - Flag. Optional.Enable debugging."$'\n'"--first - Flag. Optional.When it is the first deployment, use this flag."$'\n'"--home deployPath - Directory. Required. Path where the deployments database is on remote system. Uses"$'\n'"--id applicationId - String. Required. If not specified, uses environment variable loaded from \`.build.env\`, or \`APPLICATION_ID\` environment."$'\n'"--application applicationPath - String. Required. Path on the remote system where the application is live. If not specified, uses environment variable loaded from \`.build.env\`, or \`APPLICATION_REMOTE_HOME\` environment."$'\n'"--target targetPackage - Filename. Optional.Package name usually an archive format.  If not specified, uses environment variable loaded from \`.build.env\`, or \`BUILD_TARGET\` environment. Defaults to \`app.tar.gz\`."$'\n'""
base="deployment.sh"
description="Deploy to a host"$'\n'""$'\n'"Loads \`./.build.env\` if it exists."$'\n'"Not possible to deploy to different paths on different hosts, currently. Hosts are assumeed to be similar."$'\n'""$'\n'""
environment="DEPLOY_REMOTE_HOME - path on remote host for deployment data"$'\n'"APPLICATION_REMOTE_HOME - path on remote host for application"$'\n'"DEPLOY_USER_HOSTS - list of user@host (will be tokenized by spaces regardless of shell quoting)"$'\n'"APPLICATION_ID - Version to be deployed"$'\n'"BUILD_TARGET - The application package name"$'\n'""
file="bin/build/tools/deployment.sh"
fn="deployBuildEnvironment"
foundNames=([0]="argument" [1]="file" [2]="environment" [3]="test")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/deployment.sh"
sourceModified="1768695708"
summary="Deploy to a host"
test="testDeployBuildEnvironment - INCOMPLETE"$'\n'""
usage="deployBuildEnvironment [ --env-file envFile ] [ --debug ] [ --first ] --home deployPath --id applicationId --application applicationPath [ --target targetPackage ]"
