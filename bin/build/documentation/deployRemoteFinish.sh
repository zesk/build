#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/deployment.sh"
argument="--debug - Enable debugging. Defaults to \`BUILD_DEBUG\`"$'\n'"--deploy - Flag. Optional. default setting - handles the remote deploy."$'\n'"--revert - Flag. Optional. Revert changes just made."$'\n'"--cleanup - Flag. Optional. Cleanup after success."$'\n'"--home deployPath - Directory. Required. Path where the deployments database is on remote system."$'\n'"--id applicationId - String. Required. Should match \`APPLICATION_ID\` in \`.env\`"$'\n'"--application applicationPath - String. Required. Path on the remote system where the application is live"$'\n'"--target targetPackage - Filename. Optional. Package name, defaults to \`app.tar.gz\`"$'\n'""
base="deployment.sh"
description="This is **run on the remote system** after deployment; environment files are correct."$'\n'"It is run inside the deployment home directory in the new application folder."$'\n'""$'\n'"Current working directory on deploy is \`deployHome/applicationId/app\`."$'\n'"Current working directory on cleanup is \`applicationHome/\`"$'\n'"Current working directory on undo is \`applicationHome/\`"$'\n'"Note that these MAY be the same or different directories depending on how the application is linked to the deployment"$'\n'""$'\n'""
file="bin/build/tools/deployment.sh"
fn="deployRemoteFinish"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/deployment.sh"
sourceModified="1768797824"
summary="This is **run on the remote system** after deployment; environment"
test="testDeployRemoteFinish - INCOMPLETE"$'\n'""
usage="deployRemoteFinish [ --debug ] [ --deploy ] [ --revert ] [ --cleanup ] --home deployPath --id applicationId --application applicationPath [ --target targetPackage ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mdeployRemoteFinish[0m [94m[ --debug ][0m [94m[ --deploy ][0m [94m[ --revert ][0m [94m[ --cleanup ][0m [38;2;255;255;0m[35;48;2;0;0;0m--home deployPath[0m[0m [38;2;255;255;0m[35;48;2;0;0;0m--id applicationId[0m[0m [38;2;255;255;0m[35;48;2;0;0;0m--application applicationPath[0m[0m [94m[ --target targetPackage ][0m

    [94m--debug                        [1;97mEnable debugging. Defaults to [38;2;0;255;0;48;2;0;0;0mBUILD_DEBUG[0m[0m
    [94m--deploy                       [1;97mFlag. Optional. default setting - handles the remote deploy.[0m
    [94m--revert                       [1;97mFlag. Optional. Revert changes just made.[0m
    [94m--cleanup                      [1;97mFlag. Optional. Cleanup after success.[0m
    [31m--home deployPath              [1;97mDirectory. Required. Path where the deployments database is on remote system.[0m
    [31m--id applicationId             [1;97mString. Required. Should match [38;2;0;255;0;48;2;0;0;0mAPPLICATION_ID[0m in [38;2;0;255;0;48;2;0;0;0m.env[0m[0m
    [31m--application applicationPath  [1;97mString. Required. Path on the remote system where the application is live[0m
    [94m--target targetPackage         [1;97mFilename. Optional. Package name, defaults to [38;2;0;255;0;48;2;0;0;0mapp.tar.gz[0m[0m

This is [31mrun on the remote system[0m after deployment; environment files are correct.
It is run inside the deployment home directory in the new application folder.

Current working directory on deploy is [38;2;0;255;0;48;2;0;0;0mdeployHome/applicationId/app[0m.
Current working directory on cleanup is [38;2;0;255;0;48;2;0;0;0mapplicationHome/[0m
Current working directory on undo is [38;2;0;255;0;48;2;0;0;0mapplicationHome/[0m
Note that these MAY be the same or different directories depending on how the application is linked to the deployment

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: deployRemoteFinish [ --debug ] [ --deploy ] [ --revert ] [ --cleanup ] --home deployPath --id applicationId --application applicationPath [ --target targetPackage ]

    --debug                        Enable debugging. Defaults to BUILD_DEBUG
    --deploy                       Flag. Optional. default setting - handles the remote deploy.
    --revert                       Flag. Optional. Revert changes just made.
    --cleanup                      Flag. Optional. Cleanup after success.
    --home deployPath              Directory. Required. Path where the deployments database is on remote system.
    --id applicationId             String. Required. Should match APPLICATION_ID in .env
    --application applicationPath  String. Required. Path on the remote system where the application is live
    --target targetPackage         Filename. Optional. Package name, defaults to app.tar.gz

This is run on the remote system after deployment; environment files are correct.
It is run inside the deployment home directory in the new application folder.

Current working directory on deploy is deployHome/applicationId/app.
Current working directory on cleanup is applicationHome/
Current working directory on undo is applicationHome/
Note that these MAY be the same or different directories depending on how the application is linked to the deployment

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
