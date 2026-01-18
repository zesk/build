#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/deployment.sh"
argument="--debug - Enable debugging. Defaults to \`BUILD_DEBUG\`"$'\n'"--deploy - Optional. Flag, default setting - handles the remote deploy."$'\n'"--revert - Optional. Flag, Revert changes just made."$'\n'"--cleanup - Optional. Flag, Cleanup after success."$'\n'"--home deployPath - Directory. Required. Path where the deployments database is on remote system."$'\n'"--id applicationId - String. Required. Should match \`APPLICATION_ID\` in \`.env\`"$'\n'"--application applicationPath - String. Required. Path on the remote system where the application is live"$'\n'"--target targetPackage - Filename. Optional. Package name, defaults to \`app.tar.gz\`"$'\n'""
base="deployment.sh"
description="This is **run on the remote system** after deployment; environment files are correct."$'\n'"It is run inside the deployment home directory in the new application folder."$'\n'""$'\n'"Current working directory on deploy is \`deployHome/applicationId/app\`."$'\n'"Current working directory on cleanup is \`applicationHome/\`"$'\n'"Current working directory on undo is \`applicationHome/\`"$'\n'"Note that these MAY be the same or different directories depending on how the application is linked to the deployment"$'\n'""$'\n'""
file="bin/build/tools/deployment.sh"
fn="deployRemoteFinish"
foundNames=([0]="argument" [1]="test")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/deployment.sh"
sourceModified="1768721470"
summary="This is **run on the remote system** after deployment; environment"
test="testDeployRemoteFinish - INCOMPLETE"$'\n'""
usage="deployRemoteFinish [ --debug ] [ --deploy ] [ --revert ] [ --cleanup ] --home deployPath --id applicationId --application applicationPath [ --target targetPackage ]"
