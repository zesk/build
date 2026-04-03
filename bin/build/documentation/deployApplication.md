## `deployApplication`

> Deploy an application from a deployment repository

### Usage

    deployApplication [ --help ] [ --first ] [ --revert ] --home deployHome --id applicationId --application applicationPath [ --target targetPackage ] [ --message message ]

This acts on the local file system only but used in tandem with [deployment](./deployment.md) functions.

### Arguments

- `--help` - Flag. Optional. This help.
- `--first` - Flag. Optional. The first deployment has no prior version and can not be reverted.
- `--revert` - Flag. Optional. Means this is part of the undo process of a deployment.
- `--home deployHome` - Directory. Required. Path where the deployments database is on system.
- `--id applicationId` - String. Required. Should match `APPLICATION_ID` or `APPLICATION_TAG` in `.env` or `.deploy/`
- `--application applicationPath` - FileDirectory. Required. Path on the  system where the application is live
- `--target targetPackage` - Filename. Optional. Package name, defaults to `BUILD_TARGET`
- `--message message` - String. Optional. Message to display in the maintenance message on systems while upgrade is occurring.

### Examples

deployApplication --home /var/www/DEPLOY --id 10c2fab1 --application /var/www/apps/cool-app

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Environment

- {SEE:BUILD_TARGET.sh} {SEE:APPLICATION_ID.sh} {SEE:APPLICATION_TAG.sh}

