#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/daemontools.sh"
argument="--home serviceHome -  Path. Optional.Override \`DAEMONTOOLS_HOME\` which defaults to \`/etc/service\`. Specify once."$'\n'"serviceFile -  Binary. Required. The daemon to run. The user of this file will be used to run this file and will run as this user and group."$'\n'"serviceName - String. Optional. The daemon service name. If not specified uses the \`basename\` of \`serviceFile\` with any extension removed."$'\n'"--name serviceName - String. Optional. The daemon service name. If not specified uses the \`basename\` of \`serviceFile\` with any extension removed."$'\n'"--log logHome -  Path. Optional.The root logging directory where a directory called \`serviceName\` will be created which contains the \`multilog\` output \`current\`"$'\n'"--escalate -  Flag. Optional.Only if the source file is owned by a non-root user."$'\n'"--log-arguments ... -- -  ArgumentsList. Optional.List of arguments for the logger."$'\n'"--arguments ... -- -  ArgumentsList. Optional.List of arguments for the service."$'\n'"-- ... - Arguments. Optional. List of arguments for the service."$'\n'""
base="daemontools.sh"
description="Install a daemontools service which runs a binary as the file owner."$'\n'""$'\n'"Installs a \`daemontools\` service with an optional logging daemon process. Uses \`daemontools/_service.sh\` and \`daemontools/_log.sh\` files as templates."$'\n'""$'\n'""$'\n'""
file="bin/build/tools/daemontools.sh"
fn="daemontoolsInstallService"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/daemontools.sh"
sourceModified="1768683853"
summary="Install a daemontools service which runs a binary as the"
usage="daemontoolsInstallService [ --home serviceHome ] serviceFile [ serviceName ] [ --name serviceName ] [ --log logHome ] [ --escalate ] [ --log-arguments ... -- ] [ --arguments ... -- ] [ -- ... ]"
