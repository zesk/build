#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-30
# shellcheck disable=SC2034
argument="--outside outsideStyle - String. Optional. Style to apply to the outside border. (Default \`decoration\`)"$'\n'"--inside insideStyle - String. Optional. Style to apply to the inside spacing. (Default blank)"$'\n'"--shrink characterCount - UnsignedInteger. Optional. Reduce the box by this many characters wide. (Default 0)"$'\n'"--size lineCount - UnsignedInteger. Optional. Print this many blank lines between the header and title. (Default 1)"$'\n'"text ... - Text to put in the box"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="box.sh"
description="Heading for section output"$'\n'""
example="    consoleHeadingBoxed Moving ..."$'\n'""
file="bin/build/tools/decorate/box.sh"
foundNames=([0]="summary" [1]="argument" [2]="example" [3]="output")
output="+==========================================================================+"$'\n'"|                                                                          |"$'\n'"| Moving ...                                                               |"$'\n'"|                                                                          |"$'\n'"+==========================================================================+"$'\n'""
rawComment="Heading for section output"$'\n'"Summary: Text heading decoration"$'\n'"Argument: --outside outsideStyle - String. Optional. Style to apply to the outside border. (Default \`decoration\`)"$'\n'"Argument: --inside insideStyle - String. Optional. Style to apply to the inside spacing. (Default blank)"$'\n'"Argument: --shrink characterCount - UnsignedInteger. Optional. Reduce the box by this many characters wide. (Default 0)"$'\n'"Argument: --size lineCount - UnsignedInteger. Optional. Print this many blank lines between the header and title. (Default 1)"$'\n'"Argument: text ... - Text to put in the box"$'\n'"Example:     consoleHeadingBoxed Moving ..."$'\n'"Output: +==========================================================================+"$'\n'"Output: |                                                                          |"$'\n'"Output: | Moving ...                                                               |"$'\n'"Output: |                                                                          |"$'\n'"Output: +==========================================================================+"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/decorate/box.sh"
sourceHash="662ff1e6ab6adf5ac2b627655e4f092f760d362c"
summary="Text heading decoration"$'\n'""
usage="consoleHeadingBoxed [ --outside outsideStyle ] [ --inside insideStyle ] [ --shrink characterCount ] [ --size lineCount ] [ text ... ] [ --help ]"
