# crontab Tools

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

### `crontabApplicationUpdate` - Application-specific crontab management

Keep crontab synced with files and environment files in an application folder structure.

Structure is:

- `appPath/application1/.env`
- `appPath/application1/.env.local`
- `appPath/application1/etc/user.crontab`

Search for `user.crontab` in `applicationPath` and when found, assign `APPLICATION_NAME` to the top-level directory name
and `APPLICATION_PATH` to the top-level directory path and then map the file using the environment files given.
Any `.env` or `.env.local` files found at `$applicationPath/` will be included for each file generation.

Feasibly for each file, the following environment files are loaded:

1. `rootEnv`
2. `applicationPath/applicationName/.env`
3. `applicationPath/applicationName/.env.local`

Any files not found are skipped. Note that environment values are not carried between applications.

- Location: `bin/build/tools/crontab.sh`

#### Usage

_mapEnvironment

#### Arguments

- `--env-file environmentFile` - Top-level environment file to pass variables into the user `crontab` template
- `--show` - Show the crontab instead of installing it
- `--user user` - Scan for crontab files in the form `user.crontab` and then install as this user. If not specified, uses current user name.
- `--mapper envMapper` - Optional. Binary. The binary use to map environment values to the file. (Uses `mapEnvironment` by default)

#### Examples

    crontabApplicationUpdate --env-file /etc/myCoolApp.conf --user www-data /var/www/applications
    crontabApplicationUpdate /etc/myCoolApp.conf /var/www/applications www-data /usr/local/bin/map.sh

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
