### `deployApplication`

> Deploy an application from a deployment repository

#### Usage

    deployApplication [ --help ] [ --first ] [ --revert ] --home deployHome --id applicationId --application applicationPath [ --target targetPackage ] [ --message message ]

This acts on the local file system only but used in tandem with [deployment](./deployment.md) functions.

> Location: `bin/build/tools/deploy.sh`

#### Arguments

- `--help` - Flag. Optional. This help.
- `--first` - Flag. Optional. The first deployment has no prior version and can not be reverted.
- `--revert` - Flag. Optional. Means this is part of the undo process of a deployment.
- `--home deployHome` - Directory. Required. Path where the deployments database is on system.
- `--id applicationId` - String. Required. Should match `APPLICATION_ID` or `APPLICATION_TAG` in `.env` or `.deploy/`
- `--application applicationPath` - FileDirectory. Required. Path on the  system where the application is live
- `--target targetPackage` - Filename. Optional. Package name, defaults to `BUILD_TARGET`
- `--message message` - String. Optional. Message to display in the maintenance message on systems while upgrade is occurring.

#### Examples

deployApplication --home /var/www/DEPLOY --id 10c2fab1 --application /var/www/apps/cool-app

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

- [`BUILD_TARGET` Build Application Target File Name]({rel}env/#deployment) – **String**. The file to generate when generating builds [`APPLICATION_ID` Application ID]({rel}env/#deployment) – **String**. This is the unique hash which represents the source code [`APPLICATION_TAG` Application Tag]({rel}env/#deployment) – **String**. This is the full version number including debugging or release

#### See Also

- [deployToRemote]({rel}tools/deployment.md#deploytoremote) - Deploy current application to one or more hosts ([source](https://github.com/zesk/build/blob/main/bin/build/tools/deployment.sh#L479))

