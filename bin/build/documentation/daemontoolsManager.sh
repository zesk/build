#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/daemontools.sh"
argument="--home serviceHome - Directory. Optional. Service directory home. Defaults to \`DAEMONTOOLS_HOME\`."$'\n'"--interval intervalSeconds - PositiveInteger. Optional. Number of seconds to check for presence of the file. Defaults to 10."$'\n'"--stat statFile - FileDirectory. Optional. Output the \`svstat\` status to this file every \`intervalSeconds\`. If not specified nothing is output."$'\n'"--chirp chirpSeconds - PositiveInteger. Optional. Output a message saying we're alive every \`chirpSeconds\` seconds."$'\n'"--action actions - String. Optional. Onr or more actions permitted \`start\`, \`stop\`, \`restart\`, use comma to separate. Default is \`restart\`."$'\n'"service0 - Directory. Required. Service to control (e.g. \`/etc/service/application/\`)"$'\n'"file1 - File. Required. Absolute path to a file. Presence of  \`file\` triggers \`action\`"$'\n'""
base="daemontools.sh"
description="Runs a daemon which monitors files and operates on services."$'\n'""$'\n'"To request a specific action write the file with the action as the first line."$'\n'""$'\n'"Allows control across user boundaries. (e.g. user can control root services)"$'\n'""$'\n'"Specify actions more than once on the command line to specify more than one set of permissions."$'\n'""$'\n'""$'\n'""
environment="DAEMONTOOLS_HOME - The default home directory for \`daemontools\`"$'\n'""
file="bin/build/tools/daemontools.sh"
fn="daemontoolsManager"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/daemontools.sh"
sourceModified="1768769644"
summary="Runs a daemon which monitors files and operates on services."
usage="daemontoolsManager [ --home serviceHome ] [ --interval intervalSeconds ] [ --stat statFile ] [ --chirp chirpSeconds ] [ --action actions ] service0 file1"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mdaemontoolsManager[0m [94m[ --home serviceHome ][0m [94m[ --interval intervalSeconds ][0m [94m[ --stat statFile ][0m [94m[ --chirp chirpSeconds ][0m [94m[ --action actions ][0m [38;2;255;255;0m[35;48;2;0;0;0mservice0[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mfile1[0m[0m

    [94m--home serviceHome          [1;97mDirectory. Optional. Service directory home. Defaults to [38;2;0;255;0;48;2;0;0;0mDAEMONTOOLS_HOME[0m.[0m
    [94m--interval intervalSeconds  [1;97mPositiveInteger. Optional. Number of seconds to check for presence of the file. Defaults to 10.[0m
    [94m--stat statFile             [1;97mFileDirectory. Optional. Output the [38;2;0;255;0;48;2;0;0;0msvstat[0m status to this file every [38;2;0;255;0;48;2;0;0;0mintervalSeconds[0m. If not specified nothing is output.[0m
    [94m--chirp chirpSeconds        [1;97mPositiveInteger. Optional. Output a message saying we'\''re alive every [38;2;0;255;0;48;2;0;0;0mchirpSeconds[0m seconds.[0m
    [94m--action actions            [1;97mString. Optional. Onr or more actions permitted [38;2;0;255;0;48;2;0;0;0mstart[0m, [38;2;0;255;0;48;2;0;0;0mstop[0m, [38;2;0;255;0;48;2;0;0;0mrestart[0m, use comma to separate. Default is [38;2;0;255;0;48;2;0;0;0mrestart[0m.[0m
    [31mservice0                    [1;97mDirectory. Required. Service to control (e.g. [38;2;0;255;0;48;2;0;0;0m/etc/service/application/[0m)[0m
    [31mfile1                       [1;97mFile. Required. Absolute path to a file. Presence of  [38;2;0;255;0;48;2;0;0;0mfile[0m triggers [38;2;0;255;0;48;2;0;0;0maction[0m[0m

Runs a daemon which monitors files and operates on services.

To request a specific action write the file with the action as the first line.

Allows control across user boundaries. (e.g. user can control root services)

Specify actions more than once on the command line to specify more than one set of permissions.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- DAEMONTOOLS_HOME - The default home directory for [38;2;0;255;0;48;2;0;0;0mdaemontools[0m
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: daemontoolsManager [ --home serviceHome ] [ --interval intervalSeconds ] [ --stat statFile ] [ --chirp chirpSeconds ] [ --action actions ] service0 file1

    --home serviceHome          Directory. Optional. Service directory home. Defaults to DAEMONTOOLS_HOME.
    --interval intervalSeconds  PositiveInteger. Optional. Number of seconds to check for presence of the file. Defaults to 10.
    --stat statFile             FileDirectory. Optional. Output the svstat status to this file every intervalSeconds. If not specified nothing is output.
    --chirp chirpSeconds        PositiveInteger. Optional. Output a message saying we'\''re alive every chirpSeconds seconds.
    --action actions            String. Optional. Onr or more actions permitted start, stop, restart, use comma to separate. Default is restart.
    service0                    Directory. Required. Service to control (e.g. /etc/service/application/)
    file1                       File. Required. Absolute path to a file. Presence of  file triggers action

Runs a daemon which monitors files and operates on services.

To request a specific action write the file with the action as the first line.

Allows control across user boundaries. (e.g. user can control root services)

Specify actions more than once on the command line to specify more than one set of permissions.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- DAEMONTOOLS_HOME - The default home directory for daemontools
- 
'
