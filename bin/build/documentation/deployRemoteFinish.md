## `deployRemoteFinish`

> This is **run on the remote system** after deployment; environment

### Usage

    deployRemoteFinish [ --debug ] [ --deploy ] [ --revert ] [ --cleanup ] --home deployPath --id applicationId --application applicationPath [ --target targetPackage ]

This is **run on the remote system** after deployment; environment files are correct.
It is run inside the deployment home directory in the new application folder.
Current working directory on deploy is `deployHome/applicationId/app`.
Current working directory on cleanup is `applicationHome/`
Current working directory on undo is `applicationHome/`
Note that these MAY be the same or different directories depending on how the application is linked to the deployment

### Arguments

- `--debug` - Enable debugging. Defaults to `BUILD_DEBUG`
- `--deploy - Flag. Optional. default setting` - handles the remote deploy.
- `--revert` - Flag. Optional. Revert changes just made.
- `--cleanup` - Flag. Optional. Cleanup after success.
- `--home deployPath` - Directory. Required. Path where the deployments database is on remote system.
- `--id applicationId` - String. Required. Should match `APPLICATION_ID` in `.env`
- `--application applicationPath` - String. Required. Path on the remote system where the application is live
- `--target targetPackage` - Filename. Optional. Package name, defaults to `app.tar.gz`

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

