#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. This help."$'\n'"--first - Flag. Optional. The first deployment has no prior version and can not be reverted."$'\n'"--revert - Flag. Optional. Means this is part of the undo process of a deployment."$'\n'"--home deployHome - Directory. Required. Path where the deployments database is on system."$'\n'"--id applicationId - String. Required. Should match \`APPLICATION_ID\` or \`APPLICATION_TAG\` in \`.env\` or \`.deploy/\`"$'\n'"--application applicationPath - FileDirectory. Required. Path on the  system where the application is live"$'\n'"--target targetPackage - Filename. Optional. Package name, defaults to \`BUILD_TARGET\`"$'\n'"--message message - String. Optional. Message to display in the maintenance message on systems while upgrade is occurring."$'\n'""
base="deploy.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="This acts on the local file system only but used in tandem with [deployment](./deployment.md) functions."$'\n'""$'\n'""
descriptionLineCount="2"
environment="BUILD_TARGET APPLICATION_ID APPLICATION_TAG"$'\n'""
example="deployApplication --home /var/www/DEPLOY --id 10c2fab1 --application /var/www/apps/cool-app"$'\n'""
file="bin/build/tools/deploy.sh"
fn="deployApplication"
fnMarker="deployapplication"
foundNames=([0]="summary" [1]="argument" [2]="environment" [3]="example" [4]="use_hook" [5]="see")
line="43"
rawComment="Summary: Deploy an application from a deployment repository"$'\n'"This acts on the local file system only but used in tandem with [deployment](./deployment.md) functions."$'\n'"Argument: --help - Flag. Optional. This help."$'\n'"Argument: --first - Flag. Optional. The first deployment has no prior version and can not be reverted."$'\n'"Argument: --revert - Flag. Optional. Means this is part of the undo process of a deployment."$'\n'"Argument: --home deployHome - Directory. Required. Path where the deployments database is on system."$'\n'"Argument: --id applicationId - String. Required. Should match \`APPLICATION_ID\` or \`APPLICATION_TAG\` in \`.env\` or \`.deploy/\`"$'\n'"Argument: --application applicationPath - FileDirectory. Required. Path on the  system where the application is live"$'\n'"Argument: --target targetPackage - Filename. Optional. Package name, defaults to \`BUILD_TARGET\`"$'\n'"Argument: --message message - String. Optional. Message to display in the maintenance message on systems while upgrade is occurring."$'\n'"Environment: BUILD_TARGET APPLICATION_ID APPLICATION_TAG"$'\n'"Example: {fn} --home /var/www/DEPLOY --id 10c2fab1 --application /var/www/apps/cool-app"$'\n'"Use-Hook: maintenance"$'\n'"Use-Hook: deploy-shutdown"$'\n'"Use-Hook: deploy-activate deploy-start deploy-finish"$'\n'"See: deployToRemote"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="deployToRemote"$'\n'""
sourceFile="bin/build/tools/deploy.sh"
sourceHash="9800c80d1e803796230e87b8fd398df05b0442b9"
sourceLine="43"
summary="Deploy an application from a deployment repository"
summaryComputed=""
usage="deployApplication [ --help ] [ --first ] [ --revert ] --home deployHome --id applicationId --application applicationPath [ --target targetPackage ] [ --message message ]"
use_hook="maintenance"$'\n'"deploy-shutdown"$'\n'"deploy-activate deploy-start deploy-finish"$'\n'""
