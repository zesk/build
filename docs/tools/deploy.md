# Deploy Functions

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

## Deploy Information

### `deployApplicationVersion` - Extracts version from an application either from `.deploy` files or

Extracts version from an application either from `.deploy` files or from the the `.env` if
that does not exist.

Checks `APPLICATION_ID` and `APPLICATION_TAG` and uses first non-blank value.

#### Arguments

- `applicationHome` - Required. Directory. Application home to get the version from.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `deployPackageName` - Outputs the build target name which is based on the

Outputs the build target name which is based on the environment `BUILD_TARGET`.

If this is called on a non-deployment system, use the application root instead of
`deployHome` for compatibility.

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

BUILD_TARGET
### `deployHasVersion` - Does a deploy version exist? versionName is the version identifier

Does a deploy version exist? versionName is the version identifier for deployments

#### Arguments

- `deployHome` - Required. Directory. Deployment database home.
- `versionName` - Required. String. Application ID to look for

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `deployPreviousVersion` - Get the previous version of the supplied version

Get the previous version of the supplied version

#### Arguments

- No arguments.

#### Exit codes

- `1` - No version exists
- `2` - Argument error
### `deployNextVersion` - Get the next version of the supplied version

Get the next version of the supplied version

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

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

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

BUILD_TARGET APPLICATION_ID APPLICATION_TAG

## Utilities

### `deployMove` - Safe application deployment by moving

Safe application deployment by moving


Deploy current application to target path

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `deployMigrateDirectoryToLink` - Automatically convert application deployments using non-links to links.

Automatically convert application deployments using non-links to links.

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
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

- `--debug` - Enable debugging. Defaults to `BUILD_DEBUG`
- `--deploy` - Optional. Flag, default setting - handles the remote deploy.
- `--revert` - Optional. Flag, Revert changes just made.
- `--cleanup` - Optional. Flag, Cleanup after success.
- `--home deployPath` - Required. Directory. Path where the deployments database is on remote system.
- `--id applicationId` - Required. String. Should match `APPLICATION_ID` in `.env`
- `--application applicationPath` - Required. String. Path on the remote system where the application is live
- `--target targetPackage` - Optional. Filename. Package name, defaults to `app.tar.gz`

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

## Deployment Hooks

Deployment occurs as follows:

- `make-env` - Optional. Run on deployment system. Create environment file for remote system.
- `deploy-start` - Optional. Run on each remote system.
- `deploy-activate` - Optional. Run on each remote system.
- `deploy-finish` - Optional. Run on each remote system.
- `deploy-confirm` - Optional. Run on deployment system.
- `deploy-revert` - Optional. Run on each remote system.

## Ordering of Hooks

Hooks are run, in this order:

### Deployment `deployApplication`

Most `deploy-foo` hooks should handle failure and return application state to a **stable** state.

1. `maintenance` `on` - On each deployed system
    - Fail: Nothing
2. `deploy-shutdown` - On each deployed system
    - Fail: `maintenance` `off`
3. `deploy-start` - On each deployed system
    - Fail: `maintenance` `off`
4. `deploy-activate` - On each deployed system
    - Fail: `maintenance` `off`
5. `deploy-finish` - On each deployed system
    - Fail: `maintenance` `off`
6. `maintenance` `off` - On each deployed system
    - Fail: Nothing

### Deployment `deployRemoteFinish`

Most `deploy-foo` hooks should handle failure and return application state to a **stable** state.

1. `deploy-cleanup` - On each deployed system
    - Fail: Nothing

## Hook documentation

#### Arguments

- No arguments.

#### Examples

    885acc3

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
#### Arguments

- No arguments.

#### Examples

    885acc3

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
#### Arguments

- `message` - Required. String. Maintenance setting: `on | 1 | true | off | 0 | false`
- `maintenanceSetting` - Required. String. Maintenance setting: `on | 1 | true | off | 0 | false`

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

BUILD_MAINTENANCE_VARIABLE - If you want to use a different environment variable than `MAINTENANCE`, set this environment variable to the variable you want to use.

#### Arguments

- No arguments.

#### Examples

- Move directories to make deployment final

#### Exit codes

- `0` - This SHOULD exit successfully always 
#### Usage

    runHook deploy-activate applicationPath
    

#### Arguments

- `applicationPath` - This is the target for the current application

#### Exit codes

- `0` - This is called to replace the running application in-place 
#### Arguments

- No arguments.

#### Examples

- Enable a health endpoint which returns version number and ensure all servers return the same version number (which was just updated)
- Check the home page for a version number
- Check for a known artifact (build sha) in the server somehow
- etc.

#### Exit codes

- `0` - Continue with deployment
- `Non-zero` - Any non-zero exit code will run `deploy-revert` hook on all systems and cancel deployment 
#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error 
#### Arguments

- No arguments.

#### Examples

- Move directories to make deployment final

#### Exit codes

- `0` - This SHOULD exit successfully always 
#### Arguments

- No arguments.

#### Exit codes

- `0` - This SHOULD exit successfully always
