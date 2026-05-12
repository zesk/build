#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'fn - String. Required. Name of `fn`\nsourceFile - File. Required.\nsourceLine - PositiveInteger. Optional.\n--generate - Flag. Optional. Generate cached files.\n--no-cache - Flag. Optional. Skip any attempt to cache anything.\n--cache - Flag. Optional. Force use of cache.\n--function - Flag. Optional. Function derivations `return_code` `fn` `lowerFn` `fnMarker` `argument` `usage`\n--environment - Flag. Optional. Environment variable derivations `env` `envMarker`\n--help - Flag. Optional. Display this help.\n'
base="documentation.sh"
build_debug=$'usage-cache-skip - Skip caching by default (override with `--cache`)\n'
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Extract documentation variables from a comment stripped of the \'# \' prefixes.\n\nA few special values are generated/computed:\n\n- `description` - Any line in the comment which is not in variable is appended to the field `description`\n- `fn` - The function name (no parenthesis or anything)\n- `base` - The basename of the file\n- `file` - The relative path name of the file from the application root\n- `summary` - Defaults to first ten words of `description`\n- `exit_code` - Defaults to `0 - Always succeeds`\n- `reviewed`  - Defaults to `Never`\n- `environment"  - Defaults to `No environment dependencies or modifications.`\n\nOtherwise the assumed variables (in addition to above) to define functions are:\n\n- `argument` - Individual arguments\n- `usage` - Canonical usage example (code)\n- `example` - An example of usage (code, many)\n- `depends` - Any dependencies (list)\n\n'
descriptionLineCount="20"
file="bin/build/tools/documentation.sh"
fn="bashDocumentationExtract"
fnMarker="bashdocumentationextract"
foundNames=([0]="usage" [1]="summary" [2]="argument" [3]="stdin" [4]="build_debug")
line="60"
rawComment=$'Extract documentation variables from a comment stripped of the \'# \' prefixes.\nUsage: {fn} [ --generate ] [ --no-cache | --cache ] [ --help ] handler function sourceFile\nA few special values are generated/computed:\n- `description` - Any line in the comment which is not in variable is appended to the field `description`\n- `fn` - The function name (no parenthesis or anything)\n- `base` - The basename of the file\n- `file` - The relative path name of the file from the application root\n- `summary` - Defaults to first ten words of `description`\n- `exit_code` - Defaults to `0 - Always succeeds`\n- `reviewed`  - Defaults to `Never`\n- `environment"  - Defaults to `No environment dependencies or modifications.`\nOtherwise the assumed variables (in addition to above) to define functions are:\n- `argument` - Individual arguments\n- `usage` - Canonical usage example (code)\n- `example` - An example of usage (code, many)\n- `depends` - Any dependencies (list)\nSummary: Generate a set of name/value pairs to document bash entities\nArgument: fn - String. Required. Name of `fn`\nArgument: sourceFile - File. Required.\nArgument: sourceLine - PositiveInteger. Optional.\nArgument: --generate - Flag. Optional. Generate cached files.\nArgument: --no-cache - Flag. Optional. Skip any attempt to cache anything.\nArgument: --cache - Flag. Optional. Force use of cache.\nArgument: --function - Flag. Optional. Function derivations `return_code` `fn` `lowerFn` `fnMarker` `argument` `usage`\nArgument: --environment - Flag. Optional. Environment variable derivations `env` `envMarker`\nArgument: --help - Flag. Optional. Display this help.\nstdin: Pipe stripped comments to extract information\nBUILD_DEBUG: usage-cache-skip - Skip caching by default (override with `--cache`)\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/documentation.sh"
sourceHash="0134555ea1c32d02fdc40fd9058827a280501390"
sourceLine="60"
stdin=$'Pipe stripped comments to extract information\n'
summary="Generate a set of name/value pairs to document bash entities"
summaryComputed=""
usage=$'bashDocumentationExtract [ --generate ] [ --no-cache | --cache ] [ --help ] handler function sourceFile\n'
