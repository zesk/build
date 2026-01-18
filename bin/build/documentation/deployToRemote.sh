#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
## Deploy `--deploy` Operation
## Cleanup `--cleanup` Operation
## Undo `--revert` Operation
applicationFile="bin/build/tools/deployment.sh"
argument="--target target - String. Optional. Build target file base name, defaults to \`app.tar.gz\`"$'\n'"--deploy - Default. Flag. deploy an application to a remote host"$'\n'"--cleanup - Flag. Optional. After all hosts have been \`--deploy\`ed successfully the \`--cleanup\` step is run on all hosts to finish up (or clean up) the deployment."$'\n'"--revert - Flag. Optional. Reverses a deployment"$'\n'"--commands - Flag. Optional. Display commands sent to server but do not execute them. For debugging or testing. Implies --skip-ssh-host"$'\n'"--skip-ssh-host - Flag. Optional. Do not add ssh hosts to known hosts file."$'\n'"--add-ssh-host - Flag. Optional. Add hosts to known hosts file in SSH if not already added."$'\n'"--debug - Flag. Optional. Turn on debugging (defaults to \`BUILD_DEBUG\` environment variable)"$'\n'"--versions - deployHome - Path. Required. Remote path where we can store deployment state files."$'\n'"--id applicationId - String. Required. The application package will contain a \`.env\` with \`APPLICATION_ID\` set to this Value"$'\n'"--application applicationPath - Path. Required. Path where the application will be deployed"$'\n'"userAtHost - Strings. Required. A list of space-separated values or arguments which match users at remote hosts. Due to shell quoting peculiarities you can pass in space-delimited arguments as single arguments."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="deployment.sh"
build_debug="ssh - Debug ssh commands with verbose options"$'\n'"ssh-debug - Debug ssh commands with LOTS of verbose options"$'\n'""
description="Deploy current application to host at applicationPath."$'\n'""$'\n'"If this fails it will output the installation log."$'\n'""$'\n'"When this tool succeeds the application:"$'\n'""$'\n'"- \`--deploy\` - has been deployed in the remote systems successfully but temporary files may still exist"$'\n'"- \`--revert\` - No changes should have occurred on the remote host (not guaranteed)"$'\n'"- \`--cleanup\` - has been installed in the remote systems successfully"$'\n'""$'\n'"Operation:"$'\n'""$'\n'"## Deploy \`--deploy\` Operation"$'\n'""$'\n'"- On each host, \`app.tar.gz\` is uploaded to the \`applicationPath\` first"$'\n'"- On each host, via the shell, change to the \`applicationPath\` directory"$'\n'"- Decompress the application package, and run the \`deploy-remote-finish.sh\` script"$'\n'""$'\n'"## Cleanup \`--cleanup\` Operation"$'\n'""$'\n'"- On each host, via the shell, change to the \`applicationPath\` directory"$'\n'"- Run the \`deploy-remote-finish.sh\` script which ..."$'\n'"- Deletes the application package if it still exists, and runs the \`deploy-cleanup\` hook"$'\n'""$'\n'"## Undo \`--revert\` Operation"$'\n'""$'\n'"- On each host, via the shell, change to the \`applicationPath\` directory"$'\n'"- Run the \`deploy-remote-finish.sh\` script which ..."$'\n'"- Deploys the prior version in the same manner, and ... <!-- needs expansion TODO -->"$'\n'"- Runs the \`deploy-revert\` hook afterwards"$'\n'""$'\n'"The \`userAtHost\` can be passed as follows:"$'\n'""$'\n'"    deployDeployAction --deploy 5125ab12 /var/www/DEPLOY/coolApp/ /var/www/apps/coolApp/ \"www-data@host0 www-data@host1 stageuser@host3\" \"www-data@host4\""$'\n'""$'\n'"Local cache: \`deployHome\` is considered a state directory so removing entries in this should be managed separately."$'\n'""$'\n'""$'\n'""
environment="BUILD_DEBUG"$'\n'""
file="bin/build/tools/deployment.sh"
fn="deployToRemote"
foundNames=([0]="summary" [1]="argument" [2]="todo" [3]="test" [4]="environment" [5]="build_debug")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/deployment.sh"
sourceModified="1768721470"
summary="Deploy current application to one or more hosts"$'\n'""
test="testDeployToRemote - INCOMPLETE"$'\n'""
todo="add ability to prune past n versions safely on all hosts."$'\n'""
usage="deployToRemote [ --target target ] [ --deploy ] [ --cleanup ] [ --revert ] [ --commands ] [ --skip-ssh-host ] [ --add-ssh-host ] [ --debug ] --versions --id applicationId --application applicationPath userAtHost [ --help ]"
