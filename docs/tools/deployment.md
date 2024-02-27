# Deployment Functions

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)


### `deployBuildEnvironment` - Deploy to a host

Deploy to a host

Loads .build.env


Not possible to deploy to different paths on different hosts

#### Exit codes

- `0` - Always succeeds

#### Environment

- DEPLOY_REMOTE_PATH - path on remote host for deployment data
- APPLICATION_REMOTE_PATH - path on remote host for application
- DEPLOY_USER_HOSTS - list of user@host (will be tokenized by spaces regardless of shell quoting)
- APPLICATION_ID - Version to be deployed

### `deployRemoteFinish` - This is **run on the remote system** after deployment; environment

This is **run on the remote system** after deployment; environment files are correct.
It is run inside the deployment home directory in the new application folder.

Current working directory on deploy is `deployHome/applicationId/app`.
Current working directory on cleanup is `applicationHome/`
Current working directory on undo is `applicationHome/`
Note that these MAY be the same or different directories depending on how the application is linked to the deployment

#### Arguments

- `--home deployPath` - Required. Directory. Path where the deployments database is on remote system.
- `--id applicationId` - Required. String. Should match `APPLICATION_ID` in `.env`
- `--application applicationPath` - Required. String. Path on the remote system where the application is live
- `--target targetPackage` - Optional. Filename. Package name, defaults to `app.tar.gz`
- `--revert` - Revert changes just made
- `--cleanup` - Cleanup after success
- `--debug` - Enable debugging. Defaults to `BUILD_DEBUG`

#### Exit codes

- `0` - Always succeeds

### `deployToRemote` - Deploy current application to one or more hosts

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

#### Arguments

- `--target target` - Optional. String. Build target file base name, defaults to `app.tar.gz`
- `--deploy` - Default. Flag. deploy an application to a remote host
- `--revert` - Optional. Flag. Reverses a deployment
- `--cleanup` - Optional. Flag. After all hosts have been `--deploy`ed successfully the `--cleanup` step is run on all hosts to finish up (or clean up) the deployment.
- `--help` - Optional. Flag. Show help
- `--debug` - Optional. Flag. Turn on debugging (defaults to `BUILD_DEBUG` environment variable)
- `--versions - deployHome` - Required. Path. Remote path where we can store deployment state files.
- `--id applicationId` - Required. String. The application package will contain a `.env` with `APPLICATION_ID` set to this Value
- `--application applicationPath` - Required. Path. Path where the application will be deployed
- `userAtHost` - Required. Strings. A list of space-separated values or arguments which match users at remote hosts. Due to shell quoting peculiarities you can pass in space-delimited arguments as single arguments.

#### Exit codes

- `0` - Always succeeds

#### Local cache

`deployHome` is considered a state directory so removing entries in this should be managed separately.

## Internal functions


#### Exit codes

- `0` - Always succeeds

#### Exit codes

- `0` - Always succeeds

### `__deployCommandsFile` - Generate our commands file

Generate our commands file

Argument commands must cd such that current directory is a project directory

#### Exit codes

- `0` - Always succeeds

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)
