#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="directoryOrFile - Exists. Required. Directory or file to \`source\` \`.sh\` files found."$'\n'"--info - Flag. Optional. Show user what they should do (press a key)."$'\n'"--no-info - Flag. Optional. Hide user info (what they should do ... press a key)"$'\n'"--verbose - Flag. Optional. Show what is done as status messages."$'\n'"--clear - Flag. Optional. Clear the approval status for file given."$'\n'"--prefix - String. Optional. Display this text before each status messages."$'\n'""
base="interactive.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Loads files or a directory of \`.sh\` files using \`source\` to make the code available."$'\n'"Has security implications. Use with caution and ensure your directory is protected."$'\n'"Approved sources are stored in a cache structure at \`\$XDG_STATE_HOME/.interactiveApproved\`."$'\n'"Stale files are ones which no longer are associated with a file's current fingerprint."$'\n'""$'\n'""
descriptionLineCount="5"
environment="XDG_STATE_HOME"$'\n'""
file="bin/build/tools/interactive.sh"
fn="approveBashSource"
fnMarker="approvebashsource"
foundNames=([0]="argument" [1]="security" [2]="environment" [3]="see")
line="92"
rawComment="Argument: directoryOrFile - Exists. Required. Directory or file to \`source\` \`.sh\` files found."$'\n'"Argument: --info - Flag. Optional. Show user what they should do (press a key)."$'\n'"Argument: --no-info - Flag. Optional. Hide user info (what they should do ... press a key)"$'\n'"Argument: --verbose - Flag. Optional. Show what is done as status messages."$'\n'"Argument: --clear - Flag. Optional. Clear the approval status for file given."$'\n'"Argument: --prefix - String. Optional. Display this text before each status messages."$'\n'"Security: Loads bash files"$'\n'"Loads files or a directory of \`.sh\` files using \`source\` to make the code available."$'\n'"Has security implications. Use with caution and ensure your directory is protected."$'\n'"Approved sources are stored in a cache structure at \`\$XDG_STATE_HOME/.interactiveApproved\`."$'\n'"Stale files are ones which no longer are associated with a file's current fingerprint."$'\n'"Environment: XDG_STATE_HOME"$'\n'"See: XDG_STATE_HOME.sh"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
security="Loads bash files"$'\n'""
see="XDG_STATE_HOME.sh"$'\n'""
sourceFile="bin/build/tools/interactive.sh"
sourceHash="378aca49779b1c4a5f70a0c419c2a078d3e0d369"
sourceLine="92"
summary="Loads files or a directory of \`.sh\` files using \`source\`"
summaryComputed="true"
usage="approveBashSource directoryOrFile [ --info ] [ --no-info ] [ --verbose ] [ --clear ] [ --prefix ]"
