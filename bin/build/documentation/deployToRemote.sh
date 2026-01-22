#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
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
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/deployment.sh"
sourceModified="1768797824"
summary="Deploy current application to one or more hosts"$'\n'""
test="testDeployToRemote - INCOMPLETE"$'\n'""
todo="add ability to prune past n versions safely on all hosts."$'\n'""
usage="deployToRemote [ --target target ] [ --deploy ] [ --cleanup ] [ --revert ] [ --commands ] [ --skip-ssh-host ] [ --add-ssh-host ] [ --debug ] --versions --id applicationId --application applicationPath userAtHost [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mdeployToRemote[0m [94m[ --target target ][0m [94m[ --deploy ][0m [94m[ --cleanup ][0m [94m[ --revert ][0m [94m[ --commands ][0m [94m[ --skip-ssh-host ][0m [94m[ --add-ssh-host ][0m [94m[ --debug ][0m [38;2;255;255;0m[35;48;2;0;0;0m--versions[0m[0m [38;2;255;255;0m[35;48;2;0;0;0m--id applicationId[0m[0m [38;2;255;255;0m[35;48;2;0;0;0m--application applicationPath[0m[0m [38;2;255;255;0m[35;48;2;0;0;0muserAtHost[0m[0m [94m[ --help ][0m

    [94m--target target                [1;97mString. Optional. Build target file base name, defaults to [38;2;0;255;0;48;2;0;0;0mapp.tar.gz[0m[0m
    [94m--deploy                       [1;97mDefault. Flag. deploy an application to a remote host[0m
    [94m--cleanup                      [1;97mFlag. Optional. After all hosts have been [38;2;0;255;0;48;2;0;0;0m--deploy[0med successfully the [38;2;0;255;0;48;2;0;0;0m--cleanup[0m step is run on all hosts to finish up (or clean up) the deployment.[0m
    [94m--revert                       [1;97mFlag. Optional. Reverses a deployment[0m
    [94m--commands                     [1;97mFlag. Optional. Display commands sent to server but do not execute them. For debugging or testing. Implies --skip-ssh-host[0m
    [94m--skip-ssh-host                [1;97mFlag. Optional. Do not add ssh hosts to known hosts file.[0m
    [94m--add-ssh-host                 [1;97mFlag. Optional. Add hosts to known hosts file in SSH if not already added.[0m
    [94m--debug                        [1;97mFlag. Optional. Turn on debugging (defaults to [38;2;0;255;0;48;2;0;0;0mBUILD_DEBUG[0m environment variable)[0m
    [31m--versions                     [1;97mdeployHome - Path. Required. Remote path where we can store deployment state files.[0m
    [31m--id applicationId             [1;97mString. Required. The application package will contain a [38;2;0;255;0;48;2;0;0;0m.env[0m with [38;2;0;255;0;48;2;0;0;0mAPPLICATION_ID[0m set to this Value[0m
    [31m--application applicationPath  [1;97mPath. Required. Path where the application will be deployed[0m
    [31muserAtHost                     [1;97mStrings. Required. A list of space-separated values or arguments which match users at remote hosts. Due to shell quoting peculiarities you can pass in space-delimited arguments as single arguments.[0m
    [94m--help                         [1;97mFlag. Optional. Display this help.[0m

Deploy current application to host at applicationPath.

If this fails it will output the installation log.

When this tool succeeds the application:

- [38;2;0;255;0;48;2;0;0;0m--deploy[0m - has been deployed in the remote systems successfully but temporary files may still exist
- [38;2;0;255;0;48;2;0;0;0m--revert[0m - No changes should have occurred on the remote host (not guaranteed)
- [38;2;0;255;0;48;2;0;0;0m--cleanup[0m - has been installed in the remote systems successfully

Operation:

## Deploy [38;2;0;255;0;48;2;0;0;0m--deploy[0m Operation

- On each host, [38;2;0;255;0;48;2;0;0;0mapp.tar.gz[0m is uploaded to the [38;2;0;255;0;48;2;0;0;0mapplicationPath[0m first
- On each host, via the shell, change to the [38;2;0;255;0;48;2;0;0;0mapplicationPath[0m directory
- Decompress the application package, and run the [38;2;0;255;0;48;2;0;0;0mdeploy-remote-finish.sh[0m script

## Cleanup [38;2;0;255;0;48;2;0;0;0m--cleanup[0m Operation

- On each host, via the shell, change to the [38;2;0;255;0;48;2;0;0;0mapplicationPath[0m directory
- Run the [38;2;0;255;0;48;2;0;0;0mdeploy-remote-finish.sh[0m script which ...
- Deletes the application package if it still exists, and runs the [38;2;0;255;0;48;2;0;0;0mdeploy-cleanup[0m hook

## Undo [38;2;0;255;0;48;2;0;0;0m--revert[0m Operation

- On each host, via the shell, change to the [38;2;0;255;0;48;2;0;0;0mapplicationPath[0m directory
- Run the [38;2;0;255;0;48;2;0;0;0mdeploy-remote-finish.sh[0m script which ...
- Deploys the prior version in the same manner, and ... <!-- needs expansion TODO -->
- Runs the [38;2;0;255;0;48;2;0;0;0mdeploy-revert[0m hook afterwards

The [38;2;0;255;0;48;2;0;0;0muserAtHost[0m can be passed as follows:

    deployDeployAction --deploy 5125ab12 /var/www/DEPLOY/coolApp/ /var/www/apps/coolApp/ "www-data@host0 www-data@host1 stageuser@host3" "www-data@host4"

Local cache: [38;2;0;255;0;48;2;0;0;0mdeployHome[0m is considered a state directory so removing entries in this should be managed separately.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- BUILD_DEBUG
- 

[38;2;0;255;0;48;2;0;0;0mBUILD_DEBUG[0m settings:
- ssh - Debug ssh commands with verbose options
- ssh-debug - Debug ssh commands with LOTS of verbose options
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: deployToRemote [ --target target ] [ --deploy ] [ --cleanup ] [ --revert ] [ --commands ] [ --skip-ssh-host ] [ --add-ssh-host ] [ --debug ] --versions --id applicationId --application applicationPath userAtHost [ --help ]

    --target target                String. Optional. Build target file base name, defaults to app.tar.gz
    --deploy                       Default. Flag. deploy an application to a remote host
    --cleanup                      Flag. Optional. After all hosts have been --deployed successfully the --cleanup step is run on all hosts to finish up (or clean up) the deployment.
    --revert                       Flag. Optional. Reverses a deployment
    --commands                     Flag. Optional. Display commands sent to server but do not execute them. For debugging or testing. Implies --skip-ssh-host
    --skip-ssh-host                Flag. Optional. Do not add ssh hosts to known hosts file.
    --add-ssh-host                 Flag. Optional. Add hosts to known hosts file in SSH if not already added.
    --debug                        Flag. Optional. Turn on debugging (defaults to BUILD_DEBUG environment variable)
    --versions                     deployHome - Path. Required. Remote path where we can store deployment state files.
    --id applicationId             String. Required. The application package will contain a .env with APPLICATION_ID set to this Value
    --application applicationPath  Path. Required. Path where the application will be deployed
    userAtHost                     Strings. Required. A list of space-separated values or arguments which match users at remote hosts. Due to shell quoting peculiarities you can pass in space-delimited arguments as single arguments.
    --help                         Flag. Optional. Display this help.

Deploy current application to host at applicationPath.

If this fails it will output the installation log.

When this tool succeeds the application:

- --deploy - has been deployed in the remote systems successfully but temporary files may still exist
- --revert - No changes should have occurred on the remote host (not guaranteed)
- --cleanup - has been installed in the remote systems successfully

Operation:

## Deploy --deploy Operation

- On each host, app.tar.gz is uploaded to the applicationPath first
- On each host, via the shell, change to the applicationPath directory
- Decompress the application package, and run the deploy-remote-finish.sh script

## Cleanup --cleanup Operation

- On each host, via the shell, change to the applicationPath directory
- Run the deploy-remote-finish.sh script which ...
- Deletes the application package if it still exists, and runs the deploy-cleanup hook

## Undo --revert Operation

- On each host, via the shell, change to the applicationPath directory
- Run the deploy-remote-finish.sh script which ...
- Deploys the prior version in the same manner, and ... <!-- needs expansion TODO -->
- Runs the deploy-revert hook afterwards

The userAtHost can be passed as follows:

    deployDeployAction --deploy 5125ab12 /var/www/DEPLOY/coolApp/ /var/www/apps/coolApp/ "www-data@host0 www-data@host1 stageuser@host3" "www-data@host4"

Local cache: deployHome is considered a state directory so removing entries in this should be managed separately.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- BUILD_DEBUG
- 

BUILD_DEBUG settings:
- ssh - Debug ssh commands with verbose options
- ssh-debug - Debug ssh commands with LOTS of verbose options
- 
'
