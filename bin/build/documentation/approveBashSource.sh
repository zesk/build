#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/interactive.sh"
argument="directoryOrFile - Exists. Required. Directory or file to \`source\` \`.sh\` files found."$'\n'"--info - Flag. Optional. Show user what they should do (press a key)."$'\n'"--no-info - Flag. Optional. Hide user info (what they should do ... press a key)"$'\n'"--verbose - Flag. Optional. Show what is done as status messages."$'\n'"--clear - Flag. Optional. Clear the approval status for file given."$'\n'"--prefix - String. Optional. Display this text before each status messages."$'\n'""
base="interactive.sh"
description="Loads files or a directory of \`.sh\` files using \`source\` to make the code available."$'\n'"Has security implications. Use with caution and ensure your directory is protected."$'\n'"Approved sources are stored in a cache structure at \`\$XDG_STATE_HOME/.interactiveApproved\`."$'\n'"Stale files are ones which no longer are associated with a file's current fingerprint."$'\n'""
environment="XDG_STATE_HOME"$'\n'""
file="bin/build/tools/interactive.sh"
fn="approveBashSource"
foundNames=([0]="argument" [1]="security" [2]="environment" [3]="see")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
security="Loads bash files"$'\n'""
see="XDG_STATE_HOME.sh"$'\n'""
source="bin/build/tools/interactive.sh"
sourceModified="1768721469"
summary="Loads files or a directory of \`.sh\` files using \`source\`"
usage="approveBashSource directoryOrFile [ --info ] [ --no-info ] [ --verbose ] [ --clear ] [ --prefix ]"
