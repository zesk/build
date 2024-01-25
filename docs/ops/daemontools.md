# daemontools Tools

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)


### `daemontoolsInstallService` - Installs a `daemontools` service with an optional logging daemon process.

Installs a `daemontools` service with an optional logging daemon process. Uses `_generic-service.sh` and `_generic-log.sh` files as templates.

#### Arguments

- `--home serviceHome` - Optional. Path. Override `DAEMONTOOLS_HOME` which defaults to `/etc/service`. Specify once.
- `serviceFile` - Required. Binary. The daemon to run. The user of this file will be used to run this file and will run as this user and group.
- `serviceName` - Optional. String. The daemon service name. If not specified uses the `basename` of `serviceFile` with any extension removed.
- `--log logPath` - Optional. Path. The root logging directory where a directory called `serviceName` will be created which contains the `multilog` output `current`

#### Exit codes

- `0` - Always succeeds

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)

Copyright &copy; 2024 [Market Acumen, Inc.](Unable to find "BUILD_COMPANY_LINK" (using index "/Users/kent/.build"))
