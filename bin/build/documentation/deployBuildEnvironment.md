## `deployBuildEnvironment`

> Deploy to a host

### Usage

    deployBuildEnvironment [ --env-file envFile ] [ --debug ] [ --first ] --home deployPath --id applicationId --application applicationPath [ --target targetPackage ]

Deploy to a host
Loads `./.build.env` if it exists.
Not possible to deploy to different paths on different hosts, currently. Hosts are assumeed to be similar.

### Arguments

- `--env-file envFile - File. Optional. Environment file to load` - can handle any format.
- `--debug` - Flag. Optional. Enable debugging.
- `--first` - Flag. Optional. When it is the first deployment, use this flag.
- `--home deployPath` - Directory. Required. Path where the deployments database is on remote system. Uses
- `--id applicationId` - String. Required. If not specified, uses environment variable loaded from `.build.env`, or `APPLICATION_ID` environment.
- `--application applicationPath` - String. Required. Path on the remote system where the application is live. If not specified, uses environment variable loaded from `.build.env`, or `APPLICATION_REMOTE_HOME` environment.
- `--target targetPackage` - Filename. Optional. Package name usually an archive format.  If not specified, uses environment variable loaded from `.build.env`, or `BUILD_TARGET` environment. Defaults to `app.tar.gz`.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Environment

- {SEE:DEPLOY_REMOTE_HOME.sh} - path on remote host for deployment data
- {SEE:APPLICATION_REMOTE_HOME.sh} - path on remote host for application
- {SEE:DEPLOY_USER_HOSTS.sh} - list of user@host (will be tokenized by spaces regardless of shell quoting)
- {SEE:APPLICATION_ID.sh} - Version to be deployed
- {SEE:BUILD_TARGET.sh} - The application package name

