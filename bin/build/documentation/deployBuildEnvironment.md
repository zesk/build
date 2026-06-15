### `deployBuildEnvironment`

> Deploy to a host

#### Usage

    deployBuildEnvironment [ --env-file envFile ] [ --debug ] [ --first ] --home deployPath --id applicationId --application applicationPath [ --target targetPackage ]

Deploy to a host

Loads `./.build.env` if it exists.
Not possible to deploy to different paths on different hosts, currently. Hosts are assumeed to be similar.

> Location: `bin/build/tools/deployment.sh`

#### Arguments

- `--env-file envFile - File. Optional. Environment file to load` - can handle any format.
- `--debug` - Flag. Optional. Enable debugging.
- `--first` - Flag. Optional. When it is the first deployment, use this flag.
- `--home deployPath` - Directory. Required. Path where the deployments database is on remote system. Uses
- `--id applicationId` - String. Required. If not specified, uses environment variable loaded from `.build.env`, or `APPLICATION_ID` environment.
- `--application applicationPath` - String. Required. Path on the remote system where the application is live. If not specified, uses environment variable loaded from `.build.env`, or `APPLICATION_REMOTE_HOME` environment.
- `--target targetPackage` - Filename. Optional. Package name usually an archive format.  If not specified, uses environment variable loaded from `.build.env`, or `BUILD_TARGET` environment. Defaults to `app.tar.gz`.

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

- [`DEPLOY_REMOTE_HOME` Remote directory for deployment]({rel}env/#deployment) – **RemoteDirectory**. Path on the remote server where the application deployment home - path on remote host for deployment data
- [`APPLICATION_REMOTE_HOME` Application Remote Home Directory]({rel}env/#deployment) – **RemoteDirectory**. Path on the remote server where the application is served - path on remote host for application
- [`DEPLOY_USER_HOSTS` Host list for deployment]({rel}env/#deployment) – **String**. A list of one ore more user@host for installation of - list of user@host (will be tokenized by spaces regardless of shell quoting)
- [`APPLICATION_ID` Application ID]({rel}env/#deployment) – **String**. This is the unique hash which represents the source code - Version to be deployed
- [`BUILD_TARGET` Build Application Target File Name]({rel}env/#deployment) – **String**. The file to generate when generating builds - The application package name

