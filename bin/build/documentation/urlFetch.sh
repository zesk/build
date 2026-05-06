#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"--dump headerFile - String. Optional. Dump the headers to the file specified, specify \`-\` to output to \`stdout\`."$'\n'"--header header - String. Optional. Send a header in the format 'Name: Value'"$'\n'"--wget - Flag. Optional. Force use of wget. If unavailable, fail."$'\n'"--redirect-max maxRedirections - PositiveInteger. Optional. Sets the number of allowed redirects from the original URL. Default is 9."$'\n'"--curl - Flag. Optional. Force use of curl. If unavailable, fail."$'\n'"--binary binaryName - Callable. Use this binary instead. If the base name of the file is not \`curl\` or \`wget\` you MUST supply \`--argument-format\`."$'\n'"--argument-format format - String. Optional. Supply \`curl\` or \`wget\` for parameter formatting."$'\n'"--user userName - String. Optional. If supplied, uses HTTP Simple authentication. Usually used with \`--password\`. Note: User names may not contain the character \`:\` when using \`curl\`."$'\n'"--password password - String. Optional. If supplied along with \`--user\`, uses HTTP Simple authentication."$'\n'"--agent userAgent - String. Optional. Specify the user agent string."$'\n'"--timeout timeoutSeconds - PositiveInteger. Optional. A number of seconds to wait before failing. Defaults to \`BUILD_URL_TIMEOUT\` environment value."$'\n'"url - URL. Required. URL to fetch to target file."$'\n'"file - FileDirectory. Optional. Target file. Use \`-\` to send to \`stdout\`. Default value is \`-\`."$'\n'""
base="url.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Fetch URL content"
descriptionLineCount=""
environment="BUILD_URL_TIMEOUT"$'\n'""
file="bin/build/tools/url.sh"
fn="urlFetch"
fnMarker="urlfetch"
foundNames=([0]="summary" [1]="argument" [2]="requires" [3]="environment")
line="559"
rawComment="Summary: Fetch URL content"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --dump headerFile - String. Optional. Dump the headers to the file specified, specify \`-\` to output to \`stdout\`."$'\n'"Argument: --header header - String. Optional. Send a header in the format 'Name: Value'"$'\n'"Argument: --wget - Flag. Optional. Force use of wget. If unavailable, fail."$'\n'"Argument: --redirect-max maxRedirections - PositiveInteger. Optional. Sets the number of allowed redirects from the original URL. Default is 9."$'\n'"Argument: --curl - Flag. Optional. Force use of curl. If unavailable, fail."$'\n'"Argument: --binary binaryName - Callable. Use this binary instead. If the base name of the file is not \`curl\` or \`wget\` you MUST supply \`--argument-format\`."$'\n'"Argument: --argument-format format - String. Optional. Supply \`curl\` or \`wget\` for parameter formatting."$'\n'"Argument: --user userName - String. Optional. If supplied, uses HTTP Simple authentication. Usually used with \`--password\`. Note: User names may not contain the character \`:\` when using \`curl\`."$'\n'"Argument: --password password - String. Optional. If supplied along with \`--user\`, uses HTTP Simple authentication."$'\n'"Argument: --agent userAgent - String. Optional. Specify the user agent string."$'\n'"Argument: --timeout timeoutSeconds - PositiveInteger. Optional. A number of seconds to wait before failing. Defaults to \`BUILD_URL_TIMEOUT\` environment value."$'\n'"Argument: url - URL. Required. URL to fetch to target file."$'\n'"Argument: file - FileDirectory. Optional. Target file. Use \`-\` to send to \`stdout\`. Default value is \`-\`."$'\n'"Requires: returnMessage executableExists decorate"$'\n'"Requires: validate"$'\n'"Requires: throwArgument catchArgument"$'\n'"Requires: throwEnvironment catchEnvironment"$'\n'"Environment: BUILD_URL_TIMEOUT"$'\n'""$'\n'""
requires="returnMessage executableExists decorate"$'\n'"validate"$'\n'"throwArgument catchArgument"$'\n'"throwEnvironment catchEnvironment"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/url.sh"
sourceHash="8a95c52ce8bb5cc766609fdc6a03daab47743e41"
sourceLine="559"
summary="Fetch URL content"
summaryComputed=""
usage="urlFetch [ --help ] [ --dump headerFile ] [ --header header ] [ --wget ] [ --redirect-max maxRedirections ] [ --curl ] [ --binary binaryName ] [ --argument-format format ] [ --user userName ] [ --password password ] [ --agent userAgent ] [ --timeout timeoutSeconds ] url [ file ]"
