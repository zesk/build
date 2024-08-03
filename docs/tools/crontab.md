# crontab Tools

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />


### `crontab-application-sync.sh` - Application-specific crontab management

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

#### Usage

    crontab-application-sync.sh [ --env environment ] [ --show ] [ --user user ] [ --mapper envMapper ] applicationPath
    

#### Arguments



#### Examples

    crontab-application-sync.sh --env /etc/myCoolApp.conf --user www-data /var/www/applications
    crontab-application-sync.sh /etc/myCoolApp.conf /var/www/applications www-data /usr/local/bin/map.sh

#### Exit codes

- `0` - Always succeeds

#### See Also

Not found
