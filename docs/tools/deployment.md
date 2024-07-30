# Deployment Functions

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)


### `deployBuildEnvironment` - Deploy to a host

Deploy to a host

Loads `./.build.env` if it exists.
Not possible to deploy to different paths on different hosts, currently. Hosts are assumeed to be similar.

#### Arguments



#### Exit codes

- `0` - Always succeeds

#### Environment

DEPLOY_REMOTE_PATH - path on remote host for deployment data
APPLICATION_REMOTE_PATH - path on remote host for application
DEPLOY_USER_HOSTS - list of user@host (will be tokenized by spaces regardless of shell quoting)
APPLICATION_ID - Version to be deployed
BUILD_TARGET - The application package name

### `deployRemoteFinish` - This is **run on the remote system** after deployment; environment

This is **run on the remote system** after deployment; environment files are correct.
It is run inside the deployment home directory in the new application folder.

Current working directory on deploy is `deployHome/applicationId/app`.
Current working directory on cleanup is `applicationHome/`
Current working directory on undo is `applicationHome/`
Note that these MAY be the same or different directories depending on how the application is linked to the deployment

#### Usage

    deployRemoteFinish [ --revert | --cleanup ] [ --debug ] deployPath applicationId applicationPath
    

#### Arguments



#### Exit codes

- `0` - Always succeeds

### `deployToRemote` - Deploy current application to host at applicationPath.

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



#### Exit codes

- `0` - Always succeeds

#### Local cache

`deployHome` is considered a state directory so removing entries in this should be managed separately.

#### Environment

BUILD_DEBUG

## Internal functions


#### Exit codes

- `0` - Always succeeds
Unable to find "__deployRemoteAction" (using index "/root/.build")

### `__deployCommandsFile` - Generate our commands file

Generate our commands file

Argument commands must cd such that current directory is a project directory

#### Usage

    __deployCommandsFile remoteDirectory  [ --deploy | --revert | --finish ] applicationId deployHome applicationPath
    

#### Exit codes

- `0` - Always succeeds

#### Errors

Unable to find "__deployRemoteAction" (using index "/root/.build")

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)
