#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/decoration.sh"
argument="--size size - Integer. Optional. Number of liens to output. Defaults to 1."$'\n'"--outside outsideStyle - String. Optional. Style to apply to the outside border."$'\n'"--inside insideStyle - String. Optional. Style to apply to the inside spacing."$'\n'"--shrink characterCount - UnsignedInteger. Optional. Reduce the box by this many characters wide."$'\n'"--size lineCount - UnsignedInteger. Optional. Print this many blank lines between the header and title."$'\n'"text ... - Text to put in the box"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="decoration.sh"
description="Heading for section output"$'\n'""$'\n'""
example="    boxedHeading Moving ..."$'\n'""
file="bin/build/tools/decoration.sh"
fn="boxedHeading"
foundNames=([0]="summary" [1]="argument" [2]="example" [3]="output")
output="+==========================================================================+"$'\n'"|                                                                          |"$'\n'"| Moving ...                                                               |"$'\n'"|                                                                          |"$'\n'"+==========================================================================+"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/decoration.sh"
sourceModified="1768721469"
summary="Text heading decoration"$'\n'""
usage="boxedHeading [ --size size ] [ --outside outsideStyle ] [ --inside insideStyle ] [ --shrink characterCount ] [ --size lineCount ] [ text ... ] [ --help ]"
