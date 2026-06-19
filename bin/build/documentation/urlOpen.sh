#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n--ignore - Flag. Optional. Ignore any invalid URLs found.\n--wait - Flag. When multiple URLs are passed, make a single `open` call with all URLs as command line arguments after all URLs are validated; otherwise each URL is opened individually with the system\'s `open` call.\n--url url - URL. Optional. URL to open.\n'
base="url.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Open a URL using the operating system.\nUses the operating system\'s `open` functionality to open URLs. On Linux uses `xdg-open` or `kde-open`.\n\n> Note: Tested only on Mac OS X.\n\n'
descriptionLineCount="5"
environment=$'BUILD_URL_BINARY\n'
file="bin/build/tools/url.sh"
fn="urlOpen"
fnMarker="urlopen"
foundNames=([0]="summary" [1]="argument" [2]="stdin" [3]="environment")
line="438"
rawComment=$'Summary: Opens the default browser for a URL on the host operating system\nOpen a URL using the operating system.\nUses the operating system\'s `open` functionality to open URLs. On Linux uses `xdg-open` or `kde-open`.\n> Note: Tested only on Mac OS X.\nArgument: --help - Flag. Optional. Display this help.\nArgument: --ignore - Flag. Optional. Ignore any invalid URLs found.\nArgument: --wait - Flag. When multiple URLs are passed, make a single `open` call with all URLs as command line arguments after all URLs are validated; otherwise each URL is opened individually with the system\'s `open` call.\nArgument: --url url - URL. Optional. URL to open.\nstdin: line - URL. Optional. URL to open\nEnvironment: BUILD_URL_BINARY\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/url.sh"
sourceHash="3ed3b955b3a7b632b60fea2e330a81c2699cd660"
sourceLine="438"
stdin=$'line - URL. Optional. URL to open\n'
summary="Opens the default browser for a URL on the host operating system"
summaryComputed=""
usage="urlOpen [ --help ] [ --ignore ] [ --wait ] [ --url url ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]murlOpen'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ --ignore ]'$'\e''[0m '$'\e''[[(blue)]m[ --wait ]'$'\e''[0m '$'\e''[[(blue)]m[ --url url ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help     '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--ignore   '$'\e''[[(value)]mFlag. Optional. Ignore any invalid URLs found.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--wait     '$'\e''[[(value)]mFlag. When multiple URLs are passed, make a single '$'\e''[[(code)]mopen'$'\e''[[(reset)]m call with all URLs as command line arguments after all URLs are validated; otherwise each URL is opened individually with the system'\''s '$'\e''[[(code)]mopen'$'\e''[[(reset)]m call.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--url url  '$'\e''[[(value)]mURL. Optional. URL to open.'$'\e''[[(reset)]m'$'\n'''$'\n''Open a URL using the operating system.'$'\n''Uses the operating system'\''s '$'\e''[[(code)]mopen'$'\e''[[(reset)]m functionality to open URLs. On Linux uses '$'\e''[[(code)]mxdg-open'$'\e''[[(reset)]m or '$'\e''[[(code)]mkde-open'$'\e''[[(reset)]m.'$'\n'''$'\n''> Note: Tested only on Mac OS X.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- BUILD_URL_BINARY'$'\n'''$'\n''Reads from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m:'$'\n''line - URL. Optional. URL to open'
# shellcheck disable=SC2016
helpPlain='Usage: urlOpen [ --help ] [ --ignore ] [ --wait ] [ --url url ]'$'\n'''$'\n''    --help     Flag. Optional. Display this help.'$'\n''    --ignore   Flag. Optional. Ignore any invalid URLs found.'$'\n''    --wait     Flag. When multiple URLs are passed, make a single open call with all URLs as command line arguments after all URLs are validated; otherwise each URL is opened individually with the system'\''s open call.'$'\n''    --url url  URL. Optional. URL to open.'$'\n'''$'\n''Open a URL using the operating system.'$'\n''Uses the operating system'\''s open functionality to open URLs. On Linux uses xdg-open or kde-open.'$'\n'''$'\n''> Note: Tested only on Mac OS X.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- BUILD_URL_BINARY'$'\n'''$'\n''Reads from stdin:'$'\n''line - URL. Optional. URL to open'
documentationPath="documentation/source/tools/url.md"
