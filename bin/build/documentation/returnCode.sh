#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'name ... - String. Optional. Exit code value to output.\n'
base="_sugar.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Print one or more return codes by name.\n\nKnown codes:\n\n- `success` (0) - success!\n- `environment` (1) - generic issue with environment\n- `argument` (2) - issue with arguments\n- `assert` (97) - assertion failed (ASCII 97 = `a`)\n- `identical` (105) - identical check failed (ASCII 105 = `i`)\n- `leak` (108) - function leaked globals (ASCII 108 = `l`)\n- `timeout` (116) - timeout exceeded (ASCII 116 = `t`)\n- `exit` - (120) exit function immediately (ASCII 120 = `x`)\n- `not-found` - (127) command not found\n- `user-interrupt` - (130) User interrupt (Ctrl-C)\n- `interrupt` - (141) Interrupt signal\n- `internal` - (253) internal errors\n\nUnknown error code is 254, end of range is 255 which is not used. Use `returnCodeString` to get a string from an exit code integer.\n\n'
descriptionLineCount="19"
file="bin/build/tools/_sugar.sh"
fn="returnCode"
fnMarker="returncode"
foundNames=([0]="argument" [1]="see" [2]="file" [3]="requires" [4]="return_code")
line="42"
rawComment=$'Argument: name ... - String. Optional. Exit code value to output.\nPrint one or more return codes by name.\nKnown codes:\n- `success` (0) - success!\n- `environment` (1) - generic issue with environment\n- `argument` (2) - issue with arguments\n- `assert` (97) - assertion failed (ASCII 97 = `a`)\n- `identical` (105) - identical check failed (ASCII 105 = `i`)\n- `leak` (108) - function leaked globals (ASCII 108 = `l`)\n- `timeout` (116) - timeout exceeded (ASCII 116 = `t`)\n- `exit` - (120) exit function immediately (ASCII 120 = `x`)\n- `not-found` - (127) command not found\n- `user-interrupt` - (130) User interrupt (Ctrl-C)\n- `interrupt` - (141) Interrupt signal\n- `internal` - (253) internal errors\nUnknown error code is 254, end of range is 255 which is not used. Use `returnCodeString` to get a string from an exit code integer.\nSee: https://stackoverflow.com/questions/1101957/are-there-any-standard-exit-status-codes-in-linux\nFile: bin/build/errno.txt\nRequires: bashDocumentation\nSee: returnCodeString\nReturn Code: 0 - success\n\n'
requires=$'bashDocumentation\n'
return_code=$'0 - success\n'
see=$'https://stackoverflow.com/questions/1101957/are-there-any-standard-exit-status-codes-in-linux\nreturnCodeString\n'
sourceFile="bin/build/tools/_sugar.sh"
sourceHash="b337d9a2723e3b8170f5c84602d17b2e17ac26ec"
sourceLine="42"
summary="Print one or more return codes by name."
summaryComputed="true"
usage="returnCode [ name ... ]"
