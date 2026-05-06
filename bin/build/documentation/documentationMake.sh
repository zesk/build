#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--clean - Flag. Optional. Erase the cache before starting."$'\n'"--template templateDirectory - Directory. Required. Location of additional documentation template files to generate documentation."$'\n'"--source sourceDirectory - Directory. Required. Location of documentation source markdown."$'\n'"--target targetDirectory - Directory. Required. Location of documentation build target."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="documentation.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Must faster than \`documentationBuild\` and intended to replace it."$'\n'""$'\n'"Uses cached files at \`BUILD_DOCUMENTATION_PATH\`, assumes documentation cache structure:"$'\n'""$'\n'"- \`\$docHome/functionName.md\` - Markdown documentation"$'\n'"- \`\$docHome/SEE/functionName.md\` - Markdown documentation for \`{SEE:functionName}\`"$'\n'"- \`\$docHome/functionName.sh\` - \`functionName\` settings"$'\n'"- \`\$docHome/env/environmentName.md\` - Markdown documentation for \`environmentName\` environment variable"$'\n'"- \`\$docHome/env/environmentName.sh\` - \`environmentName\` environment variable settings"$'\n'"- \`\$docHome/env/more/environmentName.md\` - Additional Markdown documentation for \`environmentName\` environment variable"$'\n'"- \`\$docHome/SEE/environmentName.md\` - See link to \`environmentName\`"$'\n'""$'\n'""
descriptionLineCount="12"
file="bin/build/tools/documentation.sh"
fn="documentationMake"
fnMarker="documentationmake"
foundNames=([0]="summary" [1]="argument" [2]="return_code")
line="92"
rawComment="Summary: Make documentation for Bash functions"$'\n'"Must faster than \`documentationBuild\` and intended to replace it."$'\n'"Uses cached files at \`BUILD_DOCUMENTATION_PATH\`, assumes documentation cache structure:"$'\n'"- \`\$docHome/functionName.md\` - Markdown documentation"$'\n'"- \`\$docHome/SEE/functionName.md\` - Markdown documentation for \`{SEE:functionName}\`"$'\n'"- \`\$docHome/functionName.sh\` - \`functionName\` settings"$'\n'"- \`\$docHome/env/environmentName.md\` - Markdown documentation for \`environmentName\` environment variable"$'\n'"- \`\$docHome/env/environmentName.sh\` - \`environmentName\` environment variable settings"$'\n'"- \`\$docHome/env/more/environmentName.md\` - Additional Markdown documentation for \`environmentName\` environment variable"$'\n'"- \`\$docHome/SEE/environmentName.md\` - See link to \`environmentName\`"$'\n'"Argument: --clean - Flag. Optional. Erase the cache before starting."$'\n'"Argument: --template templateDirectory - Directory. Required. Location of additional documentation template files to generate documentation."$'\n'"Argument: --source sourceDirectory - Directory. Required. Location of documentation source markdown."$'\n'"Argument: --target targetDirectory - Directory. Required. Location of documentation build target."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 0 - Success"$'\n'"Return Code: 1 - Issue with environment"$'\n'"Return Code: 2 - Argument error"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Issue with environment"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/documentation.sh"
sourceHash="7487e1e4be50d4eb634f007bfd41adda45ab6d68"
sourceLine="92"
summary="Make documentation for Bash functions"
summaryComputed=""
usage="documentationMake [ --clean ] --template templateDirectory --source sourceDirectory --target targetDirectory [ --help ]"
