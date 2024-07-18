# crontab Tools

[⬅ Return to documentation root](crontab)
[⬅ Return to top](../index.md)


### `/var/folders/6r/r9y5y7f51q592kr56jyz4gh80000z_/T/tmp.9p8GpsWMeY crontab-application-sync.sh` - Application-specific crontab management

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

    /var/folders/6r/r9y5y7f51q592kr56jyz4gh80000z_/T/tmp.9p8GpsWMeY crontab-application-sync.sh [ --env environment ] [ --show ] [ --user user ] [ --mapper envMapper ] applicationPath
    

#### Exit codes

- `0` - Always succeeds

[⬅ Return to documentation root](crontab)
[⬅ Return to top](../index.md)

Copyright &copy; 2024 [Market Acumen, Inc.](https://marketacumen.com?crcat=code&crsource=zesk/build&crcampaign=docs&crkw=crontab Tools)
