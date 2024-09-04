# daemontools Tools

Tools to work with [D.J. Bernstein's Daemontools](https://cr.yp.to/daemontools.html).

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

### `daemontoolsHome` - Print the daemontools service home path

Print the daemontools service home path

- Location: `bin/build/tools/daemontools.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - success
- `1` - No environment file found
### `daemontoolsInstall` - Install daemontools and dependencies

Install daemontools and dependencies

- Location: `bin/build/tools/daemontools.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `daemontoolsInstallService` - Install a daemontools service which runs a binary as the

Install a daemontools service which runs a binary as the file owner.


Installs a `daemontools` service with an optional logging daemon process. Uses `daemontools/_service.sh` and `daemontools/_log.sh` files as templates.

- Location: `bin/build/tools/daemontools.sh`

#### Arguments

- `--home serviceHome` - Optional. Path. Override `DAEMONTOOLS_HOME` which defaults to `/etc/service`. Specify once.
- `serviceFile` - Required. Binary. The daemon to run. The user of this file will be used to run this file and will run as this user and group.
- `serviceName` - Optional. String. The daemon service name. If not specified uses the `basename` of `serviceFile` with any extension removed.
- `--log logPath` - Optional. Path. The root logging directory where a directory called `serviceName` will be created which contains the `multilog` output `current`

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `daemontoolsIsRunning` - Is daemontools running?

Is daemontools running?

- Location: `bin/build/tools/daemontools.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `daemontoolsProcessIds` - List any processes associated with daemontools supervisors

List any processes associated with daemontools supervisors

- Location: `bin/build/tools/daemontools.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `daemontoolsRemoveService` - Remove a daemontools service by name

Remove a daemontools service by name

- Location: `bin/build/tools/daemontools.sh`

#### Arguments

- `serviceName` - String. Required. Service name to remove.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `daemontoolsRestart` - Restart the daemontools processes from scratch.

Restart the daemontools processes from scratch.
Dangerous. Stops any running services and restarts them.

- Location: `bin/build/tools/daemontools.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `daemontoolsManager` - Runs a daemon which monitors files and operates on services.

Runs a daemon which monitors files and operates on services.

To request a specific action write the file with the action as the first line.

Allows control across user boundaries. (e.g. user can control root services)

Specify actions more than once on the command line to specify more than one set of permissions.

- Location: `bin/build/tools/daemontools.sh`

#### Arguments

- `--home serviceHome` - Optional. Service directory home. Defaults to `DAEMONTOOLS_HOME`.
- `--interval intervalSeconds` - Optional. Number of seconds to check for presence of the file. Defaults to 10.
- `--stat statFile` - Optional. Output the `svstat` status to this file every `intervalSeconds`. If not specified nothing is output.
- `--chirp chirpSeconds` - Optional. Output a message saying we're alive every `chirpSeconds` seconds.
- `--action actions` - Optional. String. Onr or more actions permitted `start`, `stop`, `restart`, use comma to separate. Default is `restart`.
- `service0` - Required. Directory. Service to control (e.g. `/etc/service/application/`)
- `file1` - Required. File. Absolute path to a file. Presence of  `file` triggers `action`

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

DAEMONTOOLS_HOME - The default home directory for `daemontools`

# Non-production starting/stopping

### `daemontoolsExecute` - Launch the daemontools daemon

Launch the daemontools daemon
Do not use this for production
Run the daemontools root daemon

- Location: `bin/build/tools/daemontools.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `daemontoolsTerminate` - Terminate daemontools as gracefully as possible

Terminate daemontools as gracefully as possible

- Location: `bin/build/tools/daemontools.sh`

#### Arguments

- `--timeout seconds` - Integer. Optional.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
