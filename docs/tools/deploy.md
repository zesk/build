# Deploy Functions

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

## Deploy Information


### `deployApplicationVersion` - Extracts version from an application either from `.deploy` files or

Extracts version from an application either from `.deploy` files or from the the `.env` if
that does not exist.

Checks `APPLICATION_ID` and `APPLICATION_TAG` and uses first non-blank value.

#### Usage

    deployApplicationVersion applicationHome
    

#### Arguments



#### Exit codes

- `0` - Always succeeds

### `deployPackageName` - Outputs the build target name which is based on the

Outputs the build target name which is based on the environment `BUILD_TARGET`.

If this is called on a non-deployment system, use the application root instead of
`deployHome` for compatibility.

#### Usage

    deployPackageName deployHome
    

#### Exit codes

- `0` - Always succeeds

#### Environment

BUILD_TARGET

### `deployHasVersion` - Does a deploy version exist? versionName is the version identifier

Does a deploy version exist? versionName is the version identifier for deployments

#### Usage

    deployHasVersion deployHome versionName [ targetPackage ]
    

#### Arguments



#### Exit codes

- `0` - Always succeeds

### `deployPreviousVersion` - Get the previous version of the supplied version

Get the previous version of the supplied version

#### Usage

    deployPreviousVersion deployHome versionName
    

#### Exit codes

- `1` - No version exists
- `2` - Argument error

### `deployNextVersion` - Get the next version of the supplied version

Get the next version of the supplied version

#### Usage

    deployNextVersion deployHome versionName
    

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

#### Usage

    deployApplication deployHome applicationId applicationPath [ targetPackage ]
    

#### Arguments



#### Examples

deployApplication --home /var/www/DEPLOY --id 10c2fab1 --application /var/www/apps/cool-app

#### Exit codes

- `0` - Always succeeds

#### Environment

BUILD_TARGET APPLICATION_ID APPLICATION_TAG

#### See Also

{SEE:deployToRemote}

## Utilities


### `deployMove` - Safe application deployment by moving

Safe application deployment by moving


Deploy current application to target path

#### Usage

    deployMove applicationPath
    

#### Exit codes

- `0` - Always succeeds

### `deployMigrateDirectoryToLink` - Automatically convert application deployments using non-links to links.

Automatically convert application deployments using non-links to links.

#### Usage

    deployMigrateDirectoryToLink deployHome applicationPath
    

#### Exit codes

- `0` - Always succeeds

### `deployLink` - Link deployment to new version of the application

Link new version of application.

When called, current directory is the **new** application and the `applicationLinkPath` which is
passed as an argument is the place where the **new** application should be linked to
in order to activate it.

#### Usage

    deployLink applicationLinkPath
    

#### Arguments



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

#### Usage

    deployRemoteFinish [ --revert | --cleanup ] [ --debug ] deployPath applicationId applicationPath
    

#### Arguments



#### Exit codes

- `0` - Always succeeds
