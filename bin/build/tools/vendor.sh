#!/usr/bin/env bash
#
# Support for various vendor applications
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
# Depends: nothing
# Docs: contextOpen ./docs/templates/tools/vendor.sh.md

#
# Are we within the JetBrains PHPStorm terminal?
#
# Usage: isPHPStorm
# Exit Code: 0 - within the PhpStorm terminal
# Exit Code: 1 - not within the PhpStorm terminal AFAIK
# See: contextOpen
isPHPStorm() {
	[ "${XPC_SERVICE_NAME%%PhpStorm*}" != "${XPC_SERVICE_NAME-}" ]
}

#
# Are we within the Microsoft Visual Studio Code terminal?
#
# Usage: isVisualStudioCode
# Exit Code: 0 - within the Visual Studio Code terminal
# Exit Code: 1 - not within the Visual Studio Code terminal AFAIK
# See: contextOpen
#
isVisualStudioCode() {
	[ "${VSCODE_SHELL_INTEGRATION-}" = "1" ]
}
