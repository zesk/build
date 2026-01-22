#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/interactive.sh"
argument="directoryOrFile - Exists. Required. Directory or file to \`source\` \`.sh\` files found."$'\n'"--info - Flag. Optional. Show user what they should do (press a key)."$'\n'"--no-info - Flag. Optional. Hide user info (what they should do ... press a key)"$'\n'"--verbose - Flag. Optional. Show what is done as status messages."$'\n'"--clear - Flag. Optional. Clear the approval status for file given."$'\n'"--prefix - String. Optional. Display this text before each status messages."$'\n'""
base="interactive.sh"
description="Loads files or a directory of \`.sh\` files using \`source\` to make the code available."$'\n'"Has security implications. Use with caution and ensure your directory is protected."$'\n'"Approved sources are stored in a cache structure at \`\$XDG_STATE_HOME/.interactiveApproved\`."$'\n'"Stale files are ones which no longer are associated with a file's current fingerprint."$'\n'""
environment="XDG_STATE_HOME"$'\n'""
file="bin/build/tools/interactive.sh"
fn="approveBashSource"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
security="Loads bash files"$'\n'""
see="XDG_STATE_HOME.sh"$'\n'""
sourceFile="bin/build/tools/interactive.sh"
sourceModified="1768759374"
summary="Loads files or a directory of \`.sh\` files using \`source\`"
usage="approveBashSource directoryOrFile [ --info ] [ --no-info ] [ --verbose ] [ --clear ] [ --prefix ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mapproveBashSource[0m [38;2;255;255;0m[35;48;2;0;0;0mdirectoryOrFile[0m[0m [94m[ --info ][0m [94m[ --no-info ][0m [94m[ --verbose ][0m [94m[ --clear ][0m [94m[ --prefix ][0m

    [31mdirectoryOrFile  [1;97mExists. Required. Directory or file to [38;2;0;255;0;48;2;0;0;0msource[0m [38;2;0;255;0;48;2;0;0;0m.sh[0m files found.[0m
    [94m--info           [1;97mFlag. Optional. Show user what they should do (press a key).[0m
    [94m--no-info        [1;97mFlag. Optional. Hide user info (what they should do ... press a key)[0m
    [94m--verbose        [1;97mFlag. Optional. Show what is done as status messages.[0m
    [94m--clear          [1;97mFlag. Optional. Clear the approval status for file given.[0m
    [94m--prefix         [1;97mString. Optional. Display this text before each status messages.[0m

Loads files or a directory of [38;2;0;255;0;48;2;0;0;0m.sh[0m files using [38;2;0;255;0;48;2;0;0;0msource[0m to make the code available.
Has security implications. Use with caution and ensure your directory is protected.
Approved sources are stored in a cache structure at [38;2;0;255;0;48;2;0;0;0m$XDG_STATE_HOME/.interactiveApproved[0m.
Stale files are ones which no longer are associated with a file'\''s current fingerprint.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- XDG_STATE_HOME
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: approveBashSource directoryOrFile [ --info ] [ --no-info ] [ --verbose ] [ --clear ] [ --prefix ]

    directoryOrFile  Exists. Required. Directory or file to source .sh files found.
    --info           Flag. Optional. Show user what they should do (press a key).
    --no-info        Flag. Optional. Hide user info (what they should do ... press a key)
    --verbose        Flag. Optional. Show what is done as status messages.
    --clear          Flag. Optional. Clear the approval status for file given.
    --prefix         String. Optional. Display this text before each status messages.

Loads files or a directory of .sh files using source to make the code available.
Has security implications. Use with caution and ensure your directory is protected.
Approved sources are stored in a cache structure at $XDG_STATE_HOME/.interactiveApproved.
Stale files are ones which no longer are associated with a file'\''s current fingerprint.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- XDG_STATE_HOME
- 
'
