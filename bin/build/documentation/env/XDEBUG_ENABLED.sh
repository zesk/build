# shellcheck disable=SC2034
base="XDEBUG_ENABLED.sh"
category="PHP"
derivations=([0]="env" [1]="envMarker")
description=$'Is xdebug enabled? The application can honor this environment variable to automatically connect to the debugger.\n\n'
descriptionLineCount="2"
env="XDEBUG_ENABLED"
envMarker="xdebug_enabled"
file="bin/build/env/XDEBUG_ENABLED.sh"
fn="XDEBUG_ENABLED"
foundNames=([0]="type" [1]="category" [2]="vendor" [3]="see")
rawComment=$'Type: Boolean\nCategory: PHP\nVendor: xdebug\nIs xdebug enabled? The application can honor this environment variable to automatically connect to the debugger.\nSee: https://github.com/zesk/zesk/blob/master/xdebug.php\n\n'
see=$'https://github.com/zesk/zesk/blob/master/xdebug.php\n'
sourceFile="bin/build/env/XDEBUG_ENABLED.sh"
sourceHash="bb4cd2489350819b01825b95700fdd4fc1f9cb18"
sourceLine=""
summary="Is xdebug enabled? The application can honor this environment variable"
summaryComputed="true"
type="Boolean"
vendor=$'xdebug\n'
