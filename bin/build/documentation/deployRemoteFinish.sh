#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--debug - Enable debugging. Defaults to \`BUILD_DEBUG\`"$'\n'"--deploy - Flag. Optional. default setting - handles the remote deploy."$'\n'"--revert - Flag. Optional. Revert changes just made."$'\n'"--cleanup - Flag. Optional. Cleanup after success."$'\n'"--home deployPath - Directory. Required. Path where the deployments database is on remote system."$'\n'"--id applicationId - String. Required. Should match \`APPLICATION_ID\` in \`.env\`"$'\n'"--application applicationPath - String. Required. Path on the remote system where the application is live"$'\n'"--target targetPackage - Filename. Optional. Package name, defaults to \`app.tar.gz\`"$'\n'""
base="deployment.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="This is **run on the remote system** after deployment; environment files are correct."$'\n'"It is run inside the deployment home directory in the new application folder."$'\n'""$'\n'"Current working directory on deploy is \`deployHome/applicationId/app\`."$'\n'"Current working directory on cleanup is \`applicationHome/\`"$'\n'"Current working directory on undo is \`applicationHome/\`"$'\n'"Note that these MAY be the same or different directories depending on how the application is linked to the deployment"$'\n'""$'\n'""
descriptionLineCount="8"
file="bin/build/tools/deployment.sh"
fn="deployRemoteFinish"
fnMarker="deployremotefinish"
foundNames=([0]="argument" [1]="test")
line="215"
rawComment="This is **run on the remote system** after deployment; environment files are correct."$'\n'"It is run inside the deployment home directory in the new application folder."$'\n'"Current working directory on deploy is \`deployHome/applicationId/app\`."$'\n'"Current working directory on cleanup is \`applicationHome/\`"$'\n'"Current working directory on undo is \`applicationHome/\`"$'\n'"Note that these MAY be the same or different directories depending on how the application is linked to the deployment"$'\n'"Argument: --debug - Enable debugging. Defaults to \`BUILD_DEBUG\`"$'\n'"Argument: --deploy - Flag. Optional. default setting - handles the remote deploy."$'\n'"Argument: --revert - Flag. Optional. Revert changes just made."$'\n'"Argument: --cleanup - Flag. Optional. Cleanup after success."$'\n'"Argument: --home deployPath - Directory. Required. Path where the deployments database is on remote system."$'\n'"Argument: --id applicationId - String. Required. Should match \`APPLICATION_ID\` in \`.env\`"$'\n'"Argument: --application applicationPath - String. Required. Path on the remote system where the application is live"$'\n'"Argument: --target targetPackage - Filename. Optional. Package name, defaults to \`app.tar.gz\`"$'\n'"Test: testDeployRemoteFinish - INCOMPLETE"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/deployment.sh"
sourceHash="8e4e379d9aaaaa4b4560dc874686ea6f80f0699f"
sourceLine="215"
summary="This is **run on the remote system** after deployment; environment"
summaryComputed="true"
test="testDeployRemoteFinish - INCOMPLETE"$'\n'""
usage="deployRemoteFinish [ --debug ] [ --deploy ] [ --revert ] [ --cleanup ] --home deployPath --id applicationId --application applicationPath [ --target targetPackage ]"
