#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
#### Text and formats
#### Numbers
#### File system
#### Application-relative
#### Functional
#### Lists
applicationFile="bin/build/tools/validate.sh"
argument="handler - Function. Required. Error handler."$'\n'"type - Type. Required. Type to validate."$'\n'"name - String. Required. Name of the variable which is being validated."$'\n'"value - EmptyString. Required. Value to validate."$'\n'""
base="validate.sh"
description="Validate a value by type"$'\n'""$'\n'"Types are case-insensitive:"$'\n'""$'\n'"#### Text and formats"$'\n'""$'\n'"- \`EmptyString\` - (alias \`string?\`, \`any\`) - Any value at all"$'\n'"- \`String\` - (no aliases) - Any non-empty string"$'\n'"- \`EnvironmentVariable\` - (alias \`env\`) - A non-empty string which contains alphanumeric characters or the underscore and does not begin with a digit."$'\n'"- \`Secret\` - (no aliases) - A value which is security sensitive"$'\n'"- \`Date\` - (no aliases) - A valid date in the form \`YYYY-MM-DD\`"$'\n'"- \`URL\` - (no aliases) - A Universal Resource Locator in the form \`scheme://user:password@host:port/path\`"$'\n'""$'\n'"#### Numbers"$'\n'""$'\n'"- \`Flag\` - (no aliases) - Presence of an option to enables a feature. (e.g. \`--debug\` is a \`flag\`)"$'\n'"- \`Boolean\` - (alias \`bool\`) - A value \`true\` or \`false\`"$'\n'"- \`BooleanLike\` - (aliases \`boolean?\`, \`bool?\`) - A value which should be evaluated to a boolean value"$'\n'"- \`Integer\` - (alias \`int\`) - Any integer, positive or negative"$'\n'"- \`UnsignedInteger\` - (aliases \`uint\`, \`unsigned\`) - Any integer 0 or greater"$'\n'"- \`PositiveInteger\` - (alias \`positive\`) - Any integer 1 or greater"$'\n'"- \`Number\` - (alias \`number\`) - Any integer or real number"$'\n'""$'\n'"#### File system"$'\n'""$'\n'"- \`Exists\` - (no aliases - A file (or directory) which exists in the file system of any type"$'\n'"- \`File\` - (no aliases) - A file which exists in the file system which is not any special type"$'\n'"- \`Link\` - (no aliases) - A link which exists in the file system"$'\n'"- \`Directory\` - (alias \`dir\`) - A directory which exists in the file system"$'\n'"- \`DirectoryList\` - (alias \`dirlist\`) - One or more directories as arguments"$'\n'"- \`FileDirectory\` - (alias \`parent\`) - A file whose directory exists in the file system but which may or may not exist."$'\n'"- \`RealDirectory\` - (alias \`realdir\`) - The real path of a directory which must exist."$'\n'"- \`RealFile\` - (alias \`real\`) - The real path of a file which must exist."$'\n'"- \`RemoteDirectory\` - (alias \`remotedir\`) - The path to a directory on a remote host."$'\n'""$'\n'"#### Application-relative"$'\n'""$'\n'"- \`ApplicationDirectory\` - (alias \`appdir\`) - A directory path relative to \`BUILD_HOME\`"$'\n'"- \`ApplicationFile\` - (alias \`appfile\`) - A file path relative to \`BUILD_HOME\`"$'\n'"- \`ApplicationDirectoryList\` - (alias \`appdirlist\`) - One or more arguments of type \`ApplicationDirectory\`"$'\n'""$'\n'"#### Functional"$'\n'""$'\n'"- \`Function\` - (alias \`function\`) - A defined function"$'\n'"- \`Callable\` - (alias \`callable\`) - A function or executable"$'\n'"- \`Executable\` - (alias \`bin\`) - Any binary available within the \`PATH\`"$'\n'""$'\n'"#### Lists"$'\n'""$'\n'"- \`Array\` - (no aliases) - Zero or more arguments"$'\n'"- \`List\` - (no  aliases) - Zero or more arguments"$'\n'"- \`ColonDelimitedList\` - (alias \`list:\`) - A colon-delimited list \`:\`"$'\n'"- \`CommaDelimitedList\` - (alias \`list,\`) - A comma-delimited list \`,\`"$'\n'""$'\n'"You can repeat the \`type\` \`name\` \`value\` more than once in the arguments and each will be checked until one fails"$'\n'"Return Code: 0 - Valid is valid, stdout is a filtered version of the value to be used"$'\n'"Return Code: 2 - Valid is invalid, output reason to stderr"$'\n'""
file="bin/build/tools/validate.sh"
fn="validate"
foundNames=([0]="argument" [1]="requires")
requires="__validateTypeString __validateTypePositiveInteger __validateTypeFunction __validateTypeCallable"$'\n'"isFunction throwArgument __help decorate"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/validate.sh"
sourceModified="1768721469"
summary="Validate a value by type"
usage="validate handler type name value"
