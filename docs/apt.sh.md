# `apt.sh` - Run aptitude update and install packages once

If this fails it will output the installation log.

When this tool succeeds `apt-get update` has been run in the local environment.

Installs, by default, the following packages: `apt-utils figlet jq`

## Arguments

A list of installable packages for `apt-get`.

## Local caches

- `apt-lists`: `/var/lib/apt/lists`
- `apt-cache`: `/var/cache/apt`

## Environment which affects this tool

No environment affects this tool.

[⬅ Return to top](index.md)