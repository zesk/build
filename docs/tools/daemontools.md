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

#### Usage

    daemontoolsInstallService [ --log-path path ] serviceFile [ serviceName ]
    

#### Arguments



#### Exit codes

- `0` - Always succeeds

### `daemontoolsIsRunning` - Is daemontools running?

Is daemontools running?

#### Usage

    daemontoolsIsRunning
    

#### Exit codes

- `0` - Always succeeds

### `daemontoolsProcessIds` - List any processes associated with daemontools supervisors

List any processes associated with daemontools supervisors

#### Exit codes

- `0` - Always succeeds

### `daemontoolsRemoveService` - Remove a daemontools service by name

Remove a daemontools service by name

#### Usage

    daemontoolsRemoveService serviceName
    

#### Arguments



#### Exit codes

- `0` - Always succeeds

### `daemontoolsRestart` - Restart the daemontools processes from scratch.

Restart the daemontools processes from scratch.
Dangerous. Stops any running services and restarts them.

#### Usage

    daemontoolsRestart
    

#### Exit codes

- `0` - Always succeeds

# Non-production starting/stopping


### `daemontoolsExecute` - Launch the daemontools daemon

Launch the daemontools daemon
Do not use this for production
Run the daemontools root daemon

#### Usage

    daemontoolsExecute
    

#### Exit codes

- `0` - Always succeeds

### `daemontoolsTerminate` - Terminate daemontools as gracefully as possible

Terminate daemontools as gracefully as possible

#### Usage

    daemontoolsTerminate [ --timeout seconds ]
    

#### Arguments



#### Exit codes

- `0` - Always succeeds

[⬅ Return to index](crontab)
[⬅ Return to top](../index.md)

Copyright &copy; 2024 [Market Acumen, Inc.](https://marketacumen.com?crcat=code&crsource=zesk/build&crcampaign=docs&crkw=)
