#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/url.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"--header header - String. Optional. Send a header in the format 'Name: Value'"$'\n'"--wget - Flag. Optional. Force use of wget. If unavailable, fail."$'\n'"--redirect-max maxRedirections - PositiveInteger. Optional. Sets the number of allowed redirects from the original URL. Default is 9."$'\n'"--curl - Flag. Optional. Force use of curl. If unavailable, fail."$'\n'"--binary binaryName - Callable. Use this binary instead. If the base name of the file is not \`curl\` or \`wget\` you MUST supply \`--argument-format\`."$'\n'"--argument-format format - String. Optional. Supply \`curl\` or \`wget\` for parameter formatting."$'\n'"--user userName - String. Optional. If supplied, uses HTTP Simple authentication. Usually used with \`--password\`. Note: User names may not contain the character \`:\` when using \`curl\`."$'\n'"--password password - String. Optional. If supplied along with \`--user\`, uses HTTP Simple authentication."$'\n'"--agent userAgent - String. Optional. Specify the user agent string."$'\n'"--timeout timeoutSeconds - PositiveInteger. Optional. A number of seconds to wait before failing. Defaults to \`BUILD_URL_TIMEOUT\` environment value."$'\n'"url - URL. Required. URL to fetch to target file."$'\n'"file - FileDirectory. Optional. Target file. Use \`-\` to send to \`stdout\`. Default value is \`-\`."$'\n'""
base="url.sh"
description="Fetch URL content"$'\n'""
environment="BUILD_URL_TIMEOUT"$'\n'""
file="bin/build/tools/url.sh"
fn="urlFetch"
foundNames=([0]="argument" [1]="requires" [2]="environment")
requires="returnMessage whichExists decorate"$'\n'"validate"$'\n'"throwArgument catchArgument"$'\n'"throwEnvironment catchEnvironment"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/url.sh"
summary="Fetch URL content"
usage="urlFetch [ --help ] [ --header header ] [ --wget ] [ --redirect-max maxRedirections ] [ --curl ] [ --binary binaryName ] [ --argument-format format ] [ --user userName ] [ --password password ] [ --agent userAgent ] [ --timeout timeoutSeconds ] url [ file ]"
