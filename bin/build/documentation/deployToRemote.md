## `deployToRemote`

> Deploy current application to one or more hosts

### Usage

    deployToRemote [ --target target ] [ --deploy ] [ --cleanup ] [ --revert ] [ --commands ] [ --skip-ssh-host ] [ --add-ssh-host ] [ --debug ] --versions --id applicationId --application applicationPath userAtHost [ --help ]

Deploy current application to host at applicationPath.
If this fails it will output the installation log.
When this tool succeeds the application:
- `--deploy` - has been deployed in the remote systems successfully but temporary files may still exist
- `--revert` - No changes should have occurred on the remote host (not guaranteed)
- `--cleanup` - has been installed in the remote systems successfully
Operation:
## Deploy `--deploy` Operation
- On each host, `app.tar.gz` is uploaded to the `applicationPath` first
- On each host, via the shell, change to the `applicationPath` directory
- Decompress the application package, and run the `deploy-remote-finish.sh` script
## Cleanup `--cleanup` Operation
- On each host, via the shell, change to the `applicationPath` directory
- Run the `deploy-remote-finish.sh` script which ...
- Deletes the application package if it still exists, and runs the `deploy-cleanup` hook
## Undo `--revert` Operation
- On each host, via the shell, change to the `applicationPath` directory
- Run the `deploy-remote-finish.sh` script which ...
- Deploys the prior version in the same manner, and ... <!-- needs expansion TODO -->
- Runs the `deploy-revert` hook afterwards
The `userAtHost` can be passed as follows:
    deployDeployAction --deploy 5125ab12 /var/www/DEPLOY/coolApp/ /var/www/apps/coolApp/ "www-data@host0 www-data@host1 stageuser@host3" "www-data@host4"

### Arguments

- `--target target` - String. Optional. Build target file base name, defaults to `app.tar.gz`
- `--deploy` - Default. Flag. deploy an application to a remote host
- `--cleanup` - Flag. Optional. After all hosts have been `--deploy`ed successfully the `--cleanup` step is run on all hosts to finish up (or clean up) the deployment.
- `--revert` - Flag. Optional. Reverses a deployment
- `--commands` - Flag. Optional. Display commands sent to server but do not execute them. For debugging or testing. Implies --skip-ssh-host
- `--skip-ssh-host` - Flag. Optional. Do not add ssh hosts to known hosts file.
- `--add-ssh-host` - Flag. Optional. Add hosts to known hosts file in SSH if not already added.
- `--debug` - Flag. Optional. Turn on debugging (defaults to `BUILD_DEBUG` environment variable)
- `--versions - deployHome` - Path. Required. Remote path where we can store deployment state files.
- `--id applicationId` - String. Required. The application package will contain a `.env` with `APPLICATION_ID` set to this Value
- `--application applicationPath` - Path. Required. Path where the application will be deployed
- `userAtHost` - Strings. Required. A list of space-separated values or arguments which match users at remote hosts. Due to shell quoting peculiarities you can pass in space-delimited arguments as single arguments.
- `--help` - Flag. Optional. Display this help.

### Debugging settings

Append to the value of `BUILD_DEBUG` (a comma-delimited (`,`) list) and add these tokens to enable debugging:

- `ssh` - Debug ssh commands with verbose options
- `ssh-debug` - Debug ssh commands with LOTS of verbose options

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Local cache

`deployHome` is considered a state directory so removing entries in this should be managed separately.

### Environment

- {SEE:BUILD_DEBUG.sh}

