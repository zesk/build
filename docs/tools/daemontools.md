# daemontools Tools

Tools to with with [D.J. Bernstein's Daemontools](https://cr.yp.to/daemontools.html).

[⬅ Return to index](crontab)
[⬅ Return to top](../index.md)


### `daemontoolsHome` - Print the daemontools service home path

Print the daemontools service home path

#### Exit codes

- `0` - success
- `1` - No environment file found

### `daemontoolsInstall` - Install daemontools and dependencies

Install daemontools and dependencies

#### Exit codes

- `0` - Always succeeds

### `daemontoolsInstallService` - Install a daemontools service which runs a binary as the

Install a daemontools service which runs a binary as the file owner.


Installs a `daemontools` service with an optional logging daemon process. Uses `_generic-service.sh` and `_generic-log.sh` files as templates.

#### Arguments

- `--home serviceHome` - Optional. Path. Override `DAEMONTOOLS_HOME` which defaults to `/etc/service`. Specify once.
- `serviceFile` - Required. Binary. The daemon to run. The user of this file will be used to run this file and will run as this user and group.
- `serviceName` - Optional. String. The daemon service name. If not specified uses the `basename` of `serviceFile` with any extension removed.
- `--log logPath` - Optional. Path. The root logging directory where a directory called `serviceName` will be created which contains the `multilog` output `current`

#### Exit codes

- `0` - Always succeeds

### `daemontoolsIsRunning` - Is daemontools running?

Is daemontools running?

#### Exit codes

- `0` - Always succeeds

### `daemontoolsProcessIds` - List any processes associated with daemontools supervisors

List any processes associated with daemontools supervisors

#### Exit codes

- `0` - Always succeeds

### `daemontoolsRemoveService` - Remove a daemontools service by name

Remove a daemontools service by name

#### Arguments

- `serviceName` - String. Required. Service name to remove.

#### Exit codes

- `0` - Always succeeds

# Non-production starting/stopping


### `daemontoolsExecute` - Launch the daemontools daemon

Launch the daemontools daemon
Do not use this for production
Run the daemontools root daemon

#### Exit codes

- `0` - Always succeeds

### `daemontoolsTerminate` - Terminate daemontools as gracefully as possible

Terminate daemontools as gracefully as possible

#### Exit codes

- `0` - Always succeeds

[⬅ Return to index](crontab)
[⬅ Return to top](../index.md)

Copyright &copy; 2024 [Market Acumen, Inc.](Unable to find "BUILD_COMPANY_LINK" (using index "/Users/kent/.build"))
