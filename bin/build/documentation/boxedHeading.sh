#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/decoration.sh"
argument="--size size - Integer. Optional. Number of liens to output. Defaults to 1."$'\n'"--outside outsideStyle - String. Optional. Style to apply to the outside border."$'\n'"--inside insideStyle - String. Optional. Style to apply to the inside spacing."$'\n'"--shrink characterCount - UnsignedInteger. Optional. Reduce the box by this many characters wide."$'\n'"--size lineCount - UnsignedInteger. Optional. Print this many blank lines between the header and title."$'\n'"text ... - Text to put in the box"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="decoration.sh"
description="Heading for section output"$'\n'""$'\n'""
example="    boxedHeading Moving ..."$'\n'""
file="bin/build/tools/decoration.sh"
fn="boxedHeading"
foundNames=""
output="+==========================================================================+"$'\n'"|                                                                          |"$'\n'"| Moving ...                                                               |"$'\n'"|                                                                          |"$'\n'"+==========================================================================+"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/decoration.sh"
sourceModified="1769063211"
summary="Text heading decoration"$'\n'""
usage="boxedHeading [ --size size ] [ --outside outsideStyle ] [ --inside insideStyle ] [ --shrink characterCount ] [ --size lineCount ] [ text ... ] [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mboxedHeading[0m [94m[ --size size ][0m [94m[ --outside outsideStyle ][0m [94m[ --inside insideStyle ][0m [94m[ --shrink characterCount ][0m [94m[ --size lineCount ][0m [94m[ text ... ][0m [94m[ --help ][0m

    [94m--size size              [1;97mInteger. Optional. Number of liens to output. Defaults to 1.[0m
    [94m--outside outsideStyle   [1;97mString. Optional. Style to apply to the outside border.[0m
    [94m--inside insideStyle     [1;97mString. Optional. Style to apply to the inside spacing.[0m
    [94m--shrink characterCount  [1;97mUnsignedInteger. Optional. Reduce the box by this many characters wide.[0m
    [94m--size lineCount         [1;97mUnsignedInteger. Optional. Print this many blank lines between the header and title.[0m
    [94mtext ...                 [1;97mText to put in the box[0m
    [94m--help                   [1;97mFlag. Optional. Display this help.[0m

Heading for section output

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    boxedHeading Moving ...
'
# shellcheck disable=SC2016
helpPlain='Usage: boxedHeading [ --size size ] [ --outside outsideStyle ] [ --inside insideStyle ] [ --shrink characterCount ] [ --size lineCount ] [ text ... ] [ --help ]

    --size size              Integer. Optional. Number of liens to output. Defaults to 1.
    --outside outsideStyle   String. Optional. Style to apply to the outside border.
    --inside insideStyle     String. Optional. Style to apply to the inside spacing.
    --shrink characterCount  UnsignedInteger. Optional. Reduce the box by this many characters wide.
    --size lineCount         UnsignedInteger. Optional. Print this many blank lines between the header and title.
    text ...                 Text to put in the box
    --help                   Flag. Optional. Display this help.

Heading for section output

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    boxedHeading Moving ...
'
