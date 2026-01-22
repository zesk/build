#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/daemontools.sh"
argument="--home serviceHome - Path. Optional. Override \`DAEMONTOOLS_HOME\` which defaults to \`/etc/service\`. Specify once."$'\n'"serviceFile - Binary. Required. The daemon to run. The user of this file will be used to run this file and will run as this user and group."$'\n'"serviceName - String. Optional. The daemon service name. If not specified uses the \`basename\` of \`serviceFile\` with any extension removed."$'\n'"--name serviceName - String. Optional. The daemon service name. If not specified uses the \`basename\` of \`serviceFile\` with any extension removed."$'\n'"--log logHome - Path. Optional. The root logging directory where a directory called \`serviceName\` will be created which contains the \`multilog\` output \`current\`"$'\n'"--escalate - Flag. Optional. Only if the source file is owned by a non-root user."$'\n'"--log-arguments ... -- - ArgumentsList. Optional. List of arguments for the logger."$'\n'"--arguments ... -- - ArgumentsList. Optional. List of arguments for the service."$'\n'"-- ... - Arguments. Optional. List of arguments for the service."$'\n'""
base="daemontools.sh"
description="Install a daemontools service which runs a binary as the file owner."$'\n'""$'\n'"Installs a \`daemontools\` service with an optional logging daemon process. Uses \`daemontools/_service.sh\` and \`daemontools/_log.sh\` files as templates."$'\n'""$'\n'""$'\n'""
file="bin/build/tools/daemontools.sh"
fn="daemontoolsInstallService"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/daemontools.sh"
sourceModified="1768769644"
summary="Install a daemontools service which runs a binary as the"
usage="daemontoolsInstallService [ --home serviceHome ] serviceFile [ serviceName ] [ --name serviceName ] [ --log logHome ] [ --escalate ] [ --log-arguments ... -- ] [ --arguments ... -- ] [ -- ... ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mdaemontoolsInstallService[0m [94m[ --home serviceHome ][0m [38;2;255;255;0m[35;48;2;0;0;0mserviceFile[0m[0m [94m[ serviceName ][0m [94m[ --name serviceName ][0m [94m[ --log logHome ][0m [94m[ --escalate ][0m [94m[ --log-arguments ... -- ][0m [94m[ --arguments ... -- ][0m [94m[ -- ... ][0m

    [94m--home serviceHome      [1;97mPath. Optional. Override [38;2;0;255;0;48;2;0;0;0mDAEMONTOOLS_HOME[0m which defaults to [38;2;0;255;0;48;2;0;0;0m/etc/service[0m. Specify once.[0m
    [31mserviceFile             [1;97mBinary. Required. The daemon to run. The user of this file will be used to run this file and will run as this user and group.[0m
    [94mserviceName             [1;97mString. Optional. The daemon service name. If not specified uses the [38;2;0;255;0;48;2;0;0;0mbasename[0m of [38;2;0;255;0;48;2;0;0;0mserviceFile[0m with any extension removed.[0m
    [94m--name serviceName      [1;97mString. Optional. The daemon service name. If not specified uses the [38;2;0;255;0;48;2;0;0;0mbasename[0m of [38;2;0;255;0;48;2;0;0;0mserviceFile[0m with any extension removed.[0m
    [94m--log logHome           [1;97mPath. Optional. The root logging directory where a directory called [38;2;0;255;0;48;2;0;0;0mserviceName[0m will be created which contains the [38;2;0;255;0;48;2;0;0;0mmultilog[0m output [38;2;0;255;0;48;2;0;0;0mcurrent[0m[0m
    [94m--escalate              [1;97mFlag. Optional. Only if the source file is owned by a non-root user.[0m
    [94m--log-arguments ... --  [1;97mArgumentsList. Optional. List of arguments for the logger.[0m
    [94m--arguments ... --      [1;97mArgumentsList. Optional. List of arguments for the service.[0m
    [94m-- ...                  [1;97mArguments. Optional. List of arguments for the service.[0m

Install a daemontools service which runs a binary as the file owner.

Installs a [38;2;0;255;0;48;2;0;0;0mdaemontools[0m service with an optional logging daemon process. Uses [38;2;0;255;0;48;2;0;0;0mdaemontools/_service.sh[0m and [38;2;0;255;0;48;2;0;0;0mdaemontools/_log.sh[0m files as templates.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: daemontoolsInstallService [ --home serviceHome ] serviceFile [ serviceName ] [ --name serviceName ] [ --log logHome ] [ --escalate ] [ --log-arguments ... -- ] [ --arguments ... -- ] [ -- ... ]

    --home serviceHome      Path. Optional. Override DAEMONTOOLS_HOME which defaults to /etc/service. Specify once.
    serviceFile             Binary. Required. The daemon to run. The user of this file will be used to run this file and will run as this user and group.
    serviceName             String. Optional. The daemon service name. If not specified uses the basename of serviceFile with any extension removed.
    --name serviceName      String. Optional. The daemon service name. If not specified uses the basename of serviceFile with any extension removed.
    --log logHome           Path. Optional. The root logging directory where a directory called serviceName will be created which contains the multilog output current
    --escalate              Flag. Optional. Only if the source file is owned by a non-root user.
    --log-arguments ... --  ArgumentsList. Optional. List of arguments for the logger.
    --arguments ... --      ArgumentsList. Optional. List of arguments for the service.
    -- ...                  Arguments. Optional. List of arguments for the service.

Install a daemontools service which runs a binary as the file owner.

Installs a daemontools service with an optional logging daemon process. Uses daemontools/_service.sh and daemontools/_log.sh files as templates.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
