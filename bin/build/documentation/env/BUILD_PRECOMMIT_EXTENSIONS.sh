# shellcheck disable=SC2034
base="BUILD_PRECOMMIT_EXTENSIONS.sh"
category="Build Configuration"
derivations=([0]="env" [1]="envMarker" [2]="name")
description="List of extensions for which build hooks may be written and run."$'\n'"Presence in this list simply means it may run, not that it is written or runs; add your own"$'\n'"\`bin/hooks/pre-commit-XXX.sh\` to handle a specific file type in your application."$'\n'""$'\n'"Currently:"$'\n'""$'\n'"- \`sh\` - Bash"$'\n'"- \`PHP\` - PHP"$'\n'"- \`js\` - JavaScript"$'\n'"- \`json\` - JSON"$'\n'"- \`md\` - Markdown"$'\n'"- \`yml\` - Yet Another Markup Language"$'\n'"- \`txt\` - Text files"$'\n'"- \`py\` - Python"$'\n'"- \`go\` - Golang"$'\n'"- \`rs\` - Rust"$'\n'"- \`css\` - CSS"$'\n'"- \`less\`, \`sass\`, \`scss\` - Compiled stylesheets"$'\n'""$'\n'""
descriptionLineCount="19"
env="BUILD_PRECOMMIT_EXTENSIONS"
envMarker="build_precommit_extensions"
file="bin/build/env/BUILD_PRECOMMIT_EXTENSIONS.sh"
fn="BUILD_PRECOMMIT_EXTENSIONS"
foundNames=([0]="name" [1]="category" [2]="type")
name="Pre-Commit Extension List"
rawComment="Name: Pre-Commit Extension List"$'\n'"List of extensions for which build hooks may be written and run."$'\n'"Presence in this list simply means it may run, not that it is written or runs; add your own"$'\n'"\`bin/hooks/pre-commit-XXX.sh\` to handle a specific file type in your application."$'\n'"Currently:"$'\n'"- \`sh\` - Bash"$'\n'"- \`PHP\` - PHP"$'\n'"- \`js\` - JavaScript"$'\n'"- \`json\` - JSON"$'\n'"- \`md\` - Markdown"$'\n'"- \`yml\` - Yet Another Markup Language"$'\n'"- \`txt\` - Text files"$'\n'"- \`py\` - Python"$'\n'"- \`go\` - Golang"$'\n'"- \`rs\` - Rust"$'\n'"- \`css\` - CSS"$'\n'"- \`less\`, \`sass\`, \`scss\` - Compiled stylesheets"$'\n'"Category: Build Configuration"$'\n'"Type: List"$'\n'""$'\n'""
sourceFile="bin/build/env/BUILD_PRECOMMIT_EXTENSIONS.sh"
sourceHash="2ab4799cfe5362c0c7d9f55d37a5b85f0901d84a"
sourceLine=""
summary="List of extensions for which build hooks may be written"
summaryComputed="true"
type="List"
