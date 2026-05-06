#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--home serviceHome - Directory. Optional. Service directory home. Defaults to \`DAEMONTOOLS_HOME\`."$'\n'"--interval intervalSeconds - PositiveInteger. Optional. Number of seconds to check for presence of the file. Defaults to 10."$'\n'"--stat statFile - FileDirectory. Optional. Output the \`svstat\` status to this file every \`intervalSeconds\`. If not specified nothing is output."$'\n'"--chirp chirpSeconds - PositiveInteger. Optional. Output a message saying we're alive every \`chirpSeconds\` seconds."$'\n'"--action actions - String. Optional. Onr or more actions permitted \`start\`, \`stop\`, \`restart\`, use comma to separate. Default is \`restart\`."$'\n'"service0 - Directory. Required. Service to control (e.g. \`/etc/service/application/\`)"$'\n'"file1 - File. Required. Absolute path to a file. Presence of  \`file\` triggers \`action\`"$'\n'""
base="daemontools.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Runs a daemon which monitors files and operates on services."$'\n'""$'\n'"To request a specific action write the file with the action as the first line."$'\n'""$'\n'"Allows control across user boundaries. (e.g. user can control root services)"$'\n'""$'\n'"Specify actions more than once on the command line to specify more than one set of permissions."$'\n'""$'\n'""
descriptionLineCount="8"
environment="DAEMONTOOLS_HOME - The default home directory for \`daemontools\`"$'\n'""
file="bin/build/tools/daemontools.sh"
fn="daemontoolsManager"
fnMarker="daemontoolsmanager"
foundNames=([0]="argument" [1]="environment")
line="476"
rawComment="Runs a daemon which monitors files and operates on services."$'\n'"To request a specific action write the file with the action as the first line."$'\n'"Allows control across user boundaries. (e.g. user can control root services)"$'\n'"Specify actions more than once on the command line to specify more than one set of permissions."$'\n'"Argument: --home serviceHome - Directory. Optional. Service directory home. Defaults to \`DAEMONTOOLS_HOME\`."$'\n'"Argument: --interval intervalSeconds - PositiveInteger. Optional. Number of seconds to check for presence of the file. Defaults to 10."$'\n'"Argument: --stat statFile - FileDirectory. Optional. Output the \`svstat\` status to this file every \`intervalSeconds\`. If not specified nothing is output."$'\n'"Argument: --chirp chirpSeconds - PositiveInteger. Optional. Output a message saying we're alive every \`chirpSeconds\` seconds."$'\n'"Argument: --action actions - String. Optional. Onr or more actions permitted \`start\`, \`stop\`, \`restart\`, use comma to separate. Default is \`restart\`."$'\n'"Argument: service0 - Directory. Required. Service to control (e.g. \`/etc/service/application/\`)"$'\n'"Argument: file1 - File. Required. Absolute path to a file. Presence of  \`file\` triggers \`action\`"$'\n'"Environment: DAEMONTOOLS_HOME - The default home directory for \`daemontools\`"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/daemontools.sh"
sourceHash="f448dbffaa1f7e767bd20c8f8728f0f9e0597de0"
sourceLine="476"
summary="Runs a daemon which monitors files and operates on services."
summaryComputed="true"
usage="daemontoolsManager [ --home serviceHome ] [ --interval intervalSeconds ] [ --stat statFile ] [ --chirp chirpSeconds ] [ --action actions ] service0 file1"
