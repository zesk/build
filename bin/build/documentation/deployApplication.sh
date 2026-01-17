#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/deploy.sh"
argument="--help -  Flag. Optional.This help."$'\n'"--first -  Flag. Optional.The first deployment has no prior version and can not be reverted."$'\n'"--revert -  Flag. Optional.Means this is part of the undo process of a deployment."$'\n'"--home deployHome -  Directory. Required. Path where the deployments database is on system."$'\n'"--id applicationId - String. Required. Should match \`APPLICATION_ID\` or \`APPLICATION_TAG\` in \`.env\` or \`.deploy/\`"$'\n'"--application applicationPath -  FileDirectory. Required. Path on the  system where the application is live"$'\n'"--target targetPackage -  Filename. Optional.Package name, defaults to \`BUILD_TARGET\`"$'\n'"--message message - String. Optional. Message to display in the maintenance message on systems while upgrade is occurring."$'\n'""
base="deploy.sh"
description="This acts on the local file system only but used in tandem with [deployment](./deployment.md) functions."$'\n'""$'\n'"Use-Hook: maintenance"$'\n'"Use-Hook: deploy-shutdown"$'\n'"Use-Hook: deploy-activate deploy-start deploy-finish"$'\n'""$'\n'""
environment="BUILD_TARGET APPLICATION_ID APPLICATION_TAG"$'\n'""
example="deployApplication --home /var/www/DEPLOY --id 10c2fab1 --application /var/www/apps/cool-app"$'\n'""
file="bin/build/tools/deploy.sh"
fn="deployApplication"
foundNames=([0]="summary" [1]="argument" [2]="environment" [3]="example" [4]="see")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="deployToRemote"$'\n'""
source="bin/build/tools/deploy.sh"
sourceModified="1768683999"
summary="Deploy an application from a deployment repository"$'\n'""
usage="deployApplication [ --help ] [ --first ] [ --revert ] --home deployHome --id applicationId --application applicationPath [ --target targetPackage ] [ --message message ]"
