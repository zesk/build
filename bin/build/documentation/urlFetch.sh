#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/url.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"--header header - String. Optional. Send a header in the format 'Name: Value'"$'\n'"--wget - Flag. Optional. Force use of wget. If unavailable, fail."$'\n'"--redirect-max maxRedirections - PositiveInteger. Optional. Sets the number of allowed redirects from the original URL. Default is 9."$'\n'"--curl - Flag. Optional. Force use of curl. If unavailable, fail."$'\n'"--binary binaryName - Callable. Use this binary instead. If the base name of the file is not \`curl\` or \`wget\` you MUST supply \`--argument-format\`."$'\n'"--argument-format format - String. Optional. Supply \`curl\` or \`wget\` for parameter formatting."$'\n'"--user userName - String. Optional. If supplied, uses HTTP Simple authentication. Usually used with \`--password\`. Note: User names may not contain the character \`:\` when using \`curl\`."$'\n'"--password password - String. Optional. If supplied along with \`--user\`, uses HTTP Simple authentication."$'\n'"--agent userAgent - String. Optional. Specify the user agent string."$'\n'"--timeout timeoutSeconds - PositiveInteger. Optional. A number of seconds to wait before failing. Defaults to \`BUILD_URL_TIMEOUT\` environment value."$'\n'"url - URL. Required. URL to fetch to target file."$'\n'"file - FileDirectory. Optional. Target file. Use \`-\` to send to \`stdout\`. Default value is \`-\`."$'\n'""
base="url.sh"
description="Fetch URL content"$'\n'""
environment="BUILD_URL_TIMEOUT"$'\n'""
file="bin/build/tools/url.sh"
fn="urlFetch"
requires="returnMessage whichExists decorate"$'\n'"validate"$'\n'"throwArgument catchArgument"$'\n'"throwEnvironment catchEnvironment"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/url.sh"
sourceModified="1768721470"
summary="Fetch URL content"
usage="urlFetch [ --help ] [ --header header ] [ --wget ] [ --redirect-max maxRedirections ] [ --curl ] [ --binary binaryName ] [ --argument-format format ] [ --user userName ] [ --password password ] [ --agent userAgent ] [ --timeout timeoutSeconds ] url [ file ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255murlFetch[0m [94m[ --help ][0m [94m[ --header header ][0m [94m[ --wget ][0m [94m[ --redirect-max maxRedirections ][0m [94m[ --curl ][0m [94m[ --binary binaryName ][0m [94m[ --argument-format format ][0m [94m[ --user userName ][0m [94m[ --password password ][0m [94m[ --agent userAgent ][0m [94m[ --timeout timeoutSeconds ][0m [38;2;255;255;0m[35;48;2;0;0;0murl[0m[0m [94m[ file ][0m

    [94m--help                          [1;97mFlag. Optional. Display this help.[0m
    [94m--header header                 [1;97mString. Optional. Send a header in the format '\''Name: Value'\''[0m
    [94m--wget                          [1;97mFlag. Optional. Force use of wget. If unavailable, fail.[0m
    [94m--redirect-max maxRedirections  [1;97mPositiveInteger. Optional. Sets the number of allowed redirects from the original URL. Default is 9.[0m
    [94m--curl                          [1;97mFlag. Optional. Force use of curl. If unavailable, fail.[0m
    [94m--binary binaryName             [1;97mCallable. Use this binary instead. If the base name of the file is not [38;2;0;255;0;48;2;0;0;0mcurl[0m or [38;2;0;255;0;48;2;0;0;0mwget[0m you MUST supply [38;2;0;255;0;48;2;0;0;0m--argument-format[0m.[0m
    [94m--argument-format format        [1;97mString. Optional. Supply [38;2;0;255;0;48;2;0;0;0mcurl[0m or [38;2;0;255;0;48;2;0;0;0mwget[0m for parameter formatting.[0m
    [94m--user userName                 [1;97mString. Optional. If supplied, uses HTTP Simple authentication. Usually used with [38;2;0;255;0;48;2;0;0;0m--password[0m. Note: User names may not contain the character [38;2;0;255;0;48;2;0;0;0m:[0m when using [38;2;0;255;0;48;2;0;0;0mcurl[0m.[0m
    [94m--password password             [1;97mString. Optional. If supplied along with [38;2;0;255;0;48;2;0;0;0m--user[0m, uses HTTP Simple authentication.[0m
    [94m--agent userAgent               [1;97mString. Optional. Specify the user agent string.[0m
    [94m--timeout timeoutSeconds        [1;97mPositiveInteger. Optional. A number of seconds to wait before failing. Defaults to [38;2;0;255;0;48;2;0;0;0mBUILD_URL_TIMEOUT[0m environment value.[0m
    [31murl                             [1;97mURL. Required. URL to fetch to target file.[0m
    [94mfile                            [1;97mFileDirectory. Optional. Target file. Use [38;2;0;255;0;48;2;0;0;0m-[0m to send to [38;2;0;255;0;48;2;0;0;0mstdout[0m. Default value is [38;2;0;255;0;48;2;0;0;0m-[0m.[0m

Fetch URL content

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- BUILD_URL_TIMEOUT
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: urlFetch [ --help ] [ --header header ] [ --wget ] [ --redirect-max maxRedirections ] [ --curl ] [ --binary binaryName ] [ --argument-format format ] [ --user userName ] [ --password password ] [ --agent userAgent ] [ --timeout timeoutSeconds ] url [ file ]

    --help                          Flag. Optional. Display this help.
    --header header                 String. Optional. Send a header in the format '\''Name: Value'\''
    --wget                          Flag. Optional. Force use of wget. If unavailable, fail.
    --redirect-max maxRedirections  PositiveInteger. Optional. Sets the number of allowed redirects from the original URL. Default is 9.
    --curl                          Flag. Optional. Force use of curl. If unavailable, fail.
    --binary binaryName             Callable. Use this binary instead. If the base name of the file is not curl or wget you MUST supply --argument-format.
    --argument-format format        String. Optional. Supply curl or wget for parameter formatting.
    --user userName                 String. Optional. If supplied, uses HTTP Simple authentication. Usually used with --password. Note: User names may not contain the character : when using curl.
    --password password             String. Optional. If supplied along with --user, uses HTTP Simple authentication.
    --agent userAgent               String. Optional. Specify the user agent string.
    --timeout timeoutSeconds        PositiveInteger. Optional. A number of seconds to wait before failing. Defaults to BUILD_URL_TIMEOUT environment value.
    url                             URL. Required. URL to fetch to target file.
    file                            FileDirectory. Optional. Target file. Use - to send to stdout. Default value is -.

Fetch URL content

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- BUILD_URL_TIMEOUT
- 
'
