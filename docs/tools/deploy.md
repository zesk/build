# Deploy Functions

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)

## Deploy Information


### `deployApplicationVersion` - Extracts version from an application either from `.deploy` files or

Extracts version from an application either from `.deploy` files or from the the `.env` if
that does not exist.

Checks `APPLICATION_ID` and `APPLICATION_TAG` and uses first non-blank value.

#### Arguments

- `applicationHome` - Required. Directory. Application home to get the version from.

#### Exit codes

- `0` - Always succeeds

### `deployPackageName` - Outputs the build target name which is based on the

Outputs the build target name which is based on the environment `BUILD_TARGET`.

If this is called on a non-deployment system, use the application root instead of
`deployHome` for compatibility.

#### Exit codes

- `0` - Always succeeds

### `deployHasVersion` - Does a deploy version exist? versionName is the version identifier

Does a deploy version exist? versionName is the version identifier for deployments

#### Arguments

- `deployHome` - Required. Directory. Deployment database home.
- `versionName` - Required. String. Application ID to look for

#### Exit codes

- `0` - Always succeeds

### `deployPreviousVersion` - Get the previous version of the supplied version

Get the previous version of the supplied version

#### Exit codes

- `1` - No version exists
- `2` - Argument error

### `deployNextVersion` - Get the next version of the supplied version

Get the next version of the supplied version

#### Exit codes

- `0` - Always succeeds

## Deploy


### `deployApplication` - Deploy an application from a deployment repository

Deploy an application from a deployment repository

     ____             _
    |  _ \  ___ _ __ | | ___  _   _
    | | | |/ _ \ '_ \| |/ _ \| | | |
    | |_| |  __/ |_) | | (_) | |_| |
    |____/ \___| .__/|_|\___/ \__, |
               |_|            |___/

This acts on the local file system only but used in tandem with `deployment.sh` functions.

#### Arguments

- `--help` - Optional. Flag. This help.
- `--first` - Optional. Flag. The first deployment has no prior version and can not be reverted.
- `--revert` - Optional. Flag. Means this is part of the undo process of a deployment.
- `--home deployHome` - Required. Directory. Path where the deployments database is on remote system.
- `--id applicationId` - Required. String. Should match `APPLICATION_ID` or `APPLICATION_TAG` in `.env` or `.deploy/`
- `--application applicationPath` - Required. String. Path on the remote system where the application is live
- `--target targetPackage` - Optional. Filename. Package name, defaults to `BUILD_TARGET`
- `--message message` - Optional. String. Message to display in the maintenance message on systems while upgrade is occurring.

#### Examples

deployApplication --home /var/www/DEPLOY --id 10c2fab1 --application /var/www/apps/cool-app

#### Exit codes

- `0` - Always succeeds

#### Environment

BUILD_TARGET APPLICATION_ID APPLICATION_TAG

#### See Also

- [function deployToRemote
](./docs/tools/todo.md
) - [Deploy current application to one or more hosts
](https://github.com/zesk/build/blob/main/bin/build/tools/deployment.sh#L347
)

## Utilities


### `deployMove` - Safe application deployment by moving

Safe application deployment by moving


Deploy current application to target path

#### Exit codes

- `0` - Always succeeds

### `deployMigrateDirectoryToLink` - Automatically convert application deployments using non-links to links.

Automatically convert application deployments using non-links to links.

#### Exit codes

- `0` - Always succeeds

### `deployLink` - Link deployment to new version of the application

Link new version of application.

When called, current directory is the **new** application and the `applicationLinkPath` which is
passed as an argument is the place where the **new** application should be linked to
in order to activate it.

#### Arguments

- `applicationLinkPath` - This is the target for the current application

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

PWD

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

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)
