
# `deployAction` - Deploy current application to host at remotePath.

[⬅ Return to top](index.md)

Deploy current application to host at remotePath.

If this fails it will output the installation log.

When this tool succeeds the application:
- `--deploy` - has been deployed in the remote systems successfully but temporary files may still exist
- `--undo` - No changes should have occurred on the remote host (not guaranteed)
- `--cleanup` - has been installed in the remote systems successfully

Operation:

## Deploy `--deploy` Operation

- On each host, `app.tar.gz` is uploaded to the `remotePath` first
- On each host, via the shell, change to the `remotePath` directory
- Decompress the application package, and run the `remote-deploy-finish.sh` script

## Cleanup `--cleanup` Operation

- On each host, via the shell, change to the `remotePath` directory
- Run the `remote-deploy-finish.sh` script which ...
- Deletes the application package if it still exists, and runs the `deploy-cleanup` hook

## Undo `--undo` Operation

- On each host, via the shell, change to the `remotePath` directory
- Run the `remote-deploy-finish.sh` script which ...
- Deploys the prior version in the same manner, and ... <!-- needs expansion TODO -->
- Runs the `deploy-undo` hook afterwards

## Usage

    deploy-to.sh [ --undo | --cleanup | --deploy ] [ --debug ] [ --help ] applicationChecksum remoteDeploymentPath remotePath 'user1@host1 user2@host2'

## Arguments

--- `deploy` - - `Default` - deploy an application to a remote host
--- `undo` - Reverses a deployment
--- `cleanup` - After all hosts have been `--deploy`ed successfully the `--cleanup` step is run on all hosts to finish up (or clean up) the deployment.
--- `help` - Show help
- `applicationChecksum` - The application package will contain a `.env` with `APPLICATION_CHECKSUM` set to this Value
- `remoteDeploymentPath` - Remote path where we can store deployment state files.
- `remotePath` - Path where the application will be deployed
- `user1@host1` - A list of - `space` - separated values or arguments which match users at remote hosts

## Exit codes

- `0` - Always succeeds

## Local cache

`remoteDeploymentPath` is considered a state directory so removing entries in this should be managed separately.
