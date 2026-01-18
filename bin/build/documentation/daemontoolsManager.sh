#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/daemontools.sh"
argument="--home serviceHome - Optional. Service directory home. Defaults to \`DAEMONTOOLS_HOME\`."$'\n'"--interval intervalSeconds - Optional. Number of seconds to check for presence of the file. Defaults to 10."$'\n'"--stat statFile - Optional. Output the \`svstat\` status to this file every \`intervalSeconds\`. If not specified nothing is output."$'\n'"--chirp chirpSeconds - Optional. Output a message saying we're alive every \`chirpSeconds\` seconds."$'\n'"--action actions - String. Optional. Onr or more actions permitted \`start\`, \`stop\`, \`restart\`, use comma to separate. Default is \`restart\`."$'\n'"service0 - Directory. Required. Service to control (e.g. \`/etc/service/application/\`)"$'\n'"file1 - File. Required. Absolute path to a file. Presence of  \`file\` triggers \`action\`"$'\n'""
base="daemontools.sh"
description="Runs a daemon which monitors files and operates on services."$'\n'""$'\n'"To request a specific action write the file with the action as the first line."$'\n'""$'\n'"Allows control across user boundaries. (e.g. user can control root services)"$'\n'""$'\n'"Specify actions more than once on the command line to specify more than one set of permissions."$'\n'""$'\n'""$'\n'""
environment="DAEMONTOOLS_HOME - The default home directory for \`daemontools\`"$'\n'""
file="bin/build/tools/daemontools.sh"
fn="daemontoolsManager"
foundNames=([0]="argument" [1]="environment")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/daemontools.sh"
sourceModified="1768721469"
summary="Runs a daemon which monitors files and operates on services."
usage="daemontoolsManager [ --home serviceHome ] [ --interval intervalSeconds ] [ --stat statFile ] [ --chirp chirpSeconds ] [ --action actions ] service0 file1"
