## `daemontoolsInstallService`

> Install a daemontools service which runs a binary as the

### Usage

    daemontoolsInstallService [ --home serviceHome ] serviceFile [ serviceName ] [ --name serviceName ] [ --log logHome ] [ --escalate ] [ --log-arguments ... -- ] [ --arguments ... -- ] [ -- ... ]

Install a daemontools service which runs a binary as the file owner.
Installs a `daemontools` service with an optional logging daemon process. Uses `daemontools/_service.sh` and `daemontools/_log.sh` files as templates.

### Arguments

- `--home serviceHome` - Path. Optional. Override `DAEMONTOOLS_HOME` which defaults to `/etc/service`. Specify once.
- `serviceFile` - Binary. Required. The daemon to run. The user of this file will be used to run this file and will run as this user and group.
- `serviceName` - String. Optional. The daemon service name. If not specified uses the `basename` of `serviceFile` with any extension removed.
- `--name serviceName` - String. Optional. The daemon service name. If not specified uses the `basename` of `serviceFile` with any extension removed.
- `--log logHome` - Path. Optional. The root logging directory where a directory called `serviceName` will be created which contains the `multilog` output `current`
- `--escalate` - Flag. Optional. Only if the source file is owned by a non-root user.
- `--log-arguments ... --` - ArgumentsList. Optional. List of arguments for the logger.
- `--arguments ... --` - ArgumentsList. Optional. List of arguments for the service.
- `-- ...` - Arguments. Optional. List of arguments for the service.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

