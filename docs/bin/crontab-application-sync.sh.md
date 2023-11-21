# `crontab-application-sync.sh` - Description

Keep a crontab in sync with a directory of applications.

## Usage

    crontab-application-sync.sh [ --env environment ] [ --show ] [ --user user ] [ --mapper envMapper ] applicationPath

## Arguments

- $(--env environment) - Top-level environment file to pass variables into the crontabs
- $(--show) - Show the crontab instaed of installing it
- $(--user user) - Scan for crontab files in the form $(user.crontab) and then install as this user. If not specified, uses $(whoami).
- $(--mapper envMapper) - The binary use to map environment values to the file (see (map.sh.md)[./map.sh.md])
e.g.

    bin/build/---/-----.sh ./app/

## Local cache

No local caches.

## Environment which affects this tool

- `BUILD_-----_VERSION` - String. Default to `latest`. Used to install the version of ----- you want on your environment.

[⬅ Return to top](index.md)
