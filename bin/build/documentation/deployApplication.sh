#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/deploy.sh"
argument="--help - Flag. Optional. This help."$'\n'"--first - Flag. Optional. The first deployment has no prior version and can not be reverted."$'\n'"--revert - Flag. Optional. Means this is part of the undo process of a deployment."$'\n'"--home deployHome - Directory. Required. Path where the deployments database is on system."$'\n'"--id applicationId - String. Required. Should match \`APPLICATION_ID\` or \`APPLICATION_TAG\` in \`.env\` or \`.deploy/\`"$'\n'"--application applicationPath - FileDirectory. Required. Path on the  system where the application is live"$'\n'"--target targetPackage - Filename. Optional. Package name, defaults to \`BUILD_TARGET\`"$'\n'"--message message - String. Optional. Message to display in the maintenance message on systems while upgrade is occurring."$'\n'""
base="deploy.sh"
description="This acts on the local file system only but used in tandem with [deployment](./deployment.md) functions."$'\n'""$'\n'"Use-Hook: maintenance"$'\n'"Use-Hook: deploy-shutdown"$'\n'"Use-Hook: deploy-activate deploy-start deploy-finish"$'\n'""$'\n'""
environment="BUILD_TARGET APPLICATION_ID APPLICATION_TAG"$'\n'""
example="deployApplication --home /var/www/DEPLOY --id 10c2fab1 --application /var/www/apps/cool-app"$'\n'""
file="bin/build/tools/deploy.sh"
fn="deployApplication"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="deployToRemote"$'\n'""
sourceFile="bin/build/tools/deploy.sh"
sourceModified="1768721469"
summary="Deploy an application from a deployment repository"$'\n'""
usage="deployApplication [ --help ] [ --first ] [ --revert ] --home deployHome --id applicationId --application applicationPath [ --target targetPackage ] [ --message message ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mdeployApplication[0m [94m[ --help ][0m [94m[ --first ][0m [94m[ --revert ][0m [38;2;255;255;0m[35;48;2;0;0;0m--home deployHome[0m[0m [38;2;255;255;0m[35;48;2;0;0;0m--id applicationId[0m[0m [38;2;255;255;0m[35;48;2;0;0;0m--application applicationPath[0m[0m [94m[ --target targetPackage ][0m [94m[ --message message ][0m

    [94m--help                         [1;97mFlag. Optional. This help.[0m
    [94m--first                        [1;97mFlag. Optional. The first deployment has no prior version and can not be reverted.[0m
    [94m--revert                       [1;97mFlag. Optional. Means this is part of the undo process of a deployment.[0m
    [31m--home deployHome              [1;97mDirectory. Required. Path where the deployments database is on system.[0m
    [31m--id applicationId             [1;97mString. Required. Should match [38;2;0;255;0;48;2;0;0;0mAPPLICATION_ID[0m or [38;2;0;255;0;48;2;0;0;0mAPPLICATION_TAG[0m in [38;2;0;255;0;48;2;0;0;0m.env[0m or [38;2;0;255;0;48;2;0;0;0m.deploy/[0m[0m
    [31m--application applicationPath  [1;97mFileDirectory. Required. Path on the  system where the application is live[0m
    [94m--target targetPackage         [1;97mFilename. Optional. Package name, defaults to [38;2;0;255;0;48;2;0;0;0mBUILD_TARGET[0m[0m
    [94m--message message              [1;97mString. Optional. Message to display in the maintenance message on systems while upgrade is occurring.[0m

This acts on the local file system only but used in tandem with [deployment](./deployment.md) functions.

Use-Hook: maintenance
Use-Hook: deploy-shutdown
Use-Hook: deploy-activate deploy-start deploy-finish

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- BUILD_TARGET APPLICATION_ID APPLICATION_TAG
- 

Example:
deployApplication --home /var/www/DEPLOY --id 10c2fab1 --application /var/www/apps/cool-app
'
# shellcheck disable=SC2016
helpPlain='Usage: deployApplication [ --help ] [ --first ] [ --revert ] --home deployHome --id applicationId --application applicationPath [ --target targetPackage ] [ --message message ]

    --help                         Flag. Optional. This help.
    --first                        Flag. Optional. The first deployment has no prior version and can not be reverted.
    --revert                       Flag. Optional. Means this is part of the undo process of a deployment.
    --home deployHome              Directory. Required. Path where the deployments database is on system.
    --id applicationId             String. Required. Should match APPLICATION_ID or APPLICATION_TAG in .env or .deploy/
    --application applicationPath  FileDirectory. Required. Path on the  system where the application is live
    --target targetPackage         Filename. Optional. Package name, defaults to BUILD_TARGET
    --message message              String. Optional. Message to display in the maintenance message on systems while upgrade is occurring.

This acts on the local file system only but used in tandem with [deployment](./deployment.md) functions.

Use-Hook: maintenance
Use-Hook: deploy-shutdown
Use-Hook: deploy-activate deploy-start deploy-finish

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- BUILD_TARGET APPLICATION_ID APPLICATION_TAG
- 

Example:
deployApplication --home /var/www/DEPLOY --id 10c2fab1 --application /var/www/apps/cool-app
'
