# shellcheck disable=SC2034
base="__BUILD_HAS_TTY.sh"
category="Internal"
derivations=([0]="env" [1]="envMarker")
description="Cached value of the availability of \`/dev/tty\`."$'\n'"Possible values are \`true\` or \`false\` or blank."$'\n'""$'\n'"- \`true\` - \`/dev/tty\` appears to be operating without errors"$'\n'"- \`false\` - \`/dev/tty\` appears to be disconnected and can not be used"$'\n'""$'\n'"This value is set automatically by \`isTTYAvailable\` and caches the value using this environment variable to avoid testing again."$'\n'""$'\n'""
descriptionLineCount="8"
env="__BUILD_HAS_TTY"
envMarker="__build_has_tty"
file="bin/build/env/__BUILD_HAS_TTY.sh"
fn="__BUILD_HAS_TTY"
foundNames=([0]="category" [1]="type")
rawComment="Cached value of the availability of \`/dev/tty\`."$'\n'"Possible values are \`true\` or \`false\` or blank."$'\n'"- \`true\` - \`/dev/tty\` appears to be operating without errors"$'\n'"- \`false\` - \`/dev/tty\` appears to be disconnected and can not be used"$'\n'"This value is set automatically by \`isTTYAvailable\` and caches the value using this environment variable to avoid testing again."$'\n'"Category: Internal"$'\n'"Type: Boolean"$'\n'""$'\n'""
sourceFile="bin/build/env/__BUILD_HAS_TTY.sh"
sourceHash="60a28e048b2f7030c7e59f741e8797ff45e957d1"
sourceLine=""
summary="Cached value of the availability of \`/dev/tty\`."
summaryComputed="true"
type="Boolean"
