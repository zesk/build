#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
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
requires="__validateTypeString __validateTypePositiveInteger __validateTypeFunction __validateTypeCallable"$'\n'"isFunction throwArgument __help decorate"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/validate.sh"
sourceModified="1768758955"
summary="Validate a value by type"
usage="validate handler type name value"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mvalidate[0m [38;2;255;255;0m[35;48;2;0;0;0mhandler[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mtype[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mname[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mvalue[0m[0m

    [31mhandler  [1;97mFunction. Required. Error handler.[0m
    [31mtype     [1;97mType. Required. Type to validate.[0m
    [31mname     [1;97mString. Required. Name of the variable which is being validated.[0m
    [31mvalue    [1;97mEmptyString. Required. Value to validate.[0m

Validate a value by type

Types are case-insensitive:

#### Text and formats

- [38;2;0;255;0;48;2;0;0;0mEmptyString[0m - (alias [38;2;0;255;0;48;2;0;0;0mstring?[0m, [38;2;0;255;0;48;2;0;0;0many[0m) - Any value at all
- [38;2;0;255;0;48;2;0;0;0mString[0m - (no aliases) - Any non-empty string
- [38;2;0;255;0;48;2;0;0;0mEnvironmentVariable[0m - (alias [38;2;0;255;0;48;2;0;0;0menv[0m) - A non-empty string which contains alphanumeric characters or the underscore and does not begin with a digit.
- [38;2;0;255;0;48;2;0;0;0mSecret[0m - (no aliases) - A value which is security sensitive
- [38;2;0;255;0;48;2;0;0;0mDate[0m - (no aliases) - A valid date in the form [38;2;0;255;0;48;2;0;0;0mYYYY-MM-DD[0m
- [38;2;0;255;0;48;2;0;0;0mURL[0m - (no aliases) - A Universal Resource Locator in the form [38;2;0;255;0;48;2;0;0;0mscheme://user:password@host:port/path[0m

#### Numbers

- [38;2;0;255;0;48;2;0;0;0mFlag[0m - (no aliases) - Presence of an option to enables a feature. (e.g. [38;2;0;255;0;48;2;0;0;0m--debug[0m is a [38;2;0;255;0;48;2;0;0;0mflag[0m)
- [38;2;0;255;0;48;2;0;0;0mBoolean[0m - (alias [38;2;0;255;0;48;2;0;0;0mbool[0m) - A value [38;2;0;255;0;48;2;0;0;0mtrue[0m or [38;2;0;255;0;48;2;0;0;0mfalse[0m
- [38;2;0;255;0;48;2;0;0;0mBooleanLike[0m - (aliases [38;2;0;255;0;48;2;0;0;0mboolean?[0m, [38;2;0;255;0;48;2;0;0;0mbool?[0m) - A value which should be evaluated to a boolean value
- [38;2;0;255;0;48;2;0;0;0mInteger[0m - (alias [38;2;0;255;0;48;2;0;0;0mint[0m) - Any integer, positive or negative
- [38;2;0;255;0;48;2;0;0;0mUnsignedInteger[0m - (aliases [38;2;0;255;0;48;2;0;0;0muint[0m, [38;2;0;255;0;48;2;0;0;0munsigned[0m) - Any integer 0 or greater
- [38;2;0;255;0;48;2;0;0;0mPositiveInteger[0m - (alias [38;2;0;255;0;48;2;0;0;0mpositive[0m) - Any integer 1 or greater
- [38;2;0;255;0;48;2;0;0;0mNumber[0m - (alias [38;2;0;255;0;48;2;0;0;0mnumber[0m) - Any integer or real number

#### File system

- [38;2;0;255;0;48;2;0;0;0mExists[0m - (no aliases - A file (or directory) which exists in the file system of any type
- [38;2;0;255;0;48;2;0;0;0mFile[0m - (no aliases) - A file which exists in the file system which is not any special type
- [38;2;0;255;0;48;2;0;0;0mLink[0m - (no aliases) - A link which exists in the file system
- [38;2;0;255;0;48;2;0;0;0mDirectory[0m - (alias [38;2;0;255;0;48;2;0;0;0mdir[0m) - A directory which exists in the file system
- [38;2;0;255;0;48;2;0;0;0mDirectoryList[0m - (alias [38;2;0;255;0;48;2;0;0;0mdirlist[0m) - One or more directories as arguments
- [38;2;0;255;0;48;2;0;0;0mFileDirectory[0m - (alias [38;2;0;255;0;48;2;0;0;0mparent[0m) - A file whose directory exists in the file system but which may or may not exist.
- [38;2;0;255;0;48;2;0;0;0mRealDirectory[0m - (alias [38;2;0;255;0;48;2;0;0;0mrealdir[0m) - The real path of a directory which must exist.
- [38;2;0;255;0;48;2;0;0;0mRealFile[0m - (alias [38;2;0;255;0;48;2;0;0;0mreal[0m) - The real path of a file which must exist.
- [38;2;0;255;0;48;2;0;0;0mRemoteDirectory[0m - (alias [38;2;0;255;0;48;2;0;0;0mremotedir[0m) - The path to a directory on a remote host.

#### Application-relative

- [38;2;0;255;0;48;2;0;0;0mApplicationDirectory[0m - (alias [38;2;0;255;0;48;2;0;0;0mappdir[0m) - A directory path relative to [38;2;0;255;0;48;2;0;0;0mBUILD_HOME[0m
- [38;2;0;255;0;48;2;0;0;0mApplicationFile[0m - (alias [38;2;0;255;0;48;2;0;0;0mappfile[0m) - A file path relative to [38;2;0;255;0;48;2;0;0;0mBUILD_HOME[0m
- [38;2;0;255;0;48;2;0;0;0mApplicationDirectoryList[0m - (alias [38;2;0;255;0;48;2;0;0;0mappdirlist[0m) - One or more arguments of type [38;2;0;255;0;48;2;0;0;0mApplicationDirectory[0m

#### Functional

- [38;2;0;255;0;48;2;0;0;0mFunction[0m - (alias [38;2;0;255;0;48;2;0;0;0mfunction[0m) - A defined function
- [38;2;0;255;0;48;2;0;0;0mCallable[0m - (alias [38;2;0;255;0;48;2;0;0;0mcallable[0m) - A function or executable
- [38;2;0;255;0;48;2;0;0;0mExecutable[0m - (alias [38;2;0;255;0;48;2;0;0;0mbin[0m) - Any binary available within the [38;2;0;255;0;48;2;0;0;0mPATH[0m

#### Lists

- [38;2;0;255;0;48;2;0;0;0mArray[0m - (no aliases) - Zero or more arguments
- [38;2;0;255;0;48;2;0;0;0mList[0m - (no  aliases) - Zero or more arguments
- [38;2;0;255;0;48;2;0;0;0mColonDelimitedList[0m - (alias [38;2;0;255;0;48;2;0;0;0mlist:[0m) - A colon-delimited list [38;2;0;255;0;48;2;0;0;0m:[0m
- [38;2;0;255;0;48;2;0;0;0mCommaDelimitedList[0m - (alias [38;2;0;255;0;48;2;0;0;0mlist,[0m) - A comma-delimited list [38;2;0;255;0;48;2;0;0;0m,[0m

You can repeat the [38;2;0;255;0;48;2;0;0;0mtype[0m [38;2;0;255;0;48;2;0;0;0mname[0m [38;2;0;255;0;48;2;0;0;0mvalue[0m more than once in the arguments and each will be checked until one fails
Return Code: 0 - Valid is valid, stdout is a filtered version of the value to be used
Return Code: 2 - Valid is invalid, output reason to stderr

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: validate handler type name value

    handler  Function. Required. Error handler.
    type     Type. Required. Type to validate.
    name     String. Required. Name of the variable which is being validated.
    value    EmptyString. Required. Value to validate.

Validate a value by type

Types are case-insensitive:

#### Text and formats

- EmptyString - (alias string?, any) - Any value at all
- String - (no aliases) - Any non-empty string
- EnvironmentVariable - (alias env) - A non-empty string which contains alphanumeric characters or the underscore and does not begin with a digit.
- Secret - (no aliases) - A value which is security sensitive
- Date - (no aliases) - A valid date in the form YYYY-MM-DD
- URL - (no aliases) - A Universal Resource Locator in the form scheme://user:password@host:port/path

#### Numbers

- Flag - (no aliases) - Presence of an option to enables a feature. (e.g. --debug is a flag)
- Boolean - (alias bool) - A value true or false
- BooleanLike - (aliases boolean?, bool?) - A value which should be evaluated to a boolean value
- Integer - (alias int) - Any integer, positive or negative
- UnsignedInteger - (aliases uint, unsigned) - Any integer 0 or greater
- PositiveInteger - (alias positive) - Any integer 1 or greater
- Number - (alias number) - Any integer or real number

#### File system

- Exists - (no aliases - A file (or directory) which exists in the file system of any type
- File - (no aliases) - A file which exists in the file system which is not any special type
- Link - (no aliases) - A link which exists in the file system
- Directory - (alias dir) - A directory which exists in the file system
- DirectoryList - (alias dirlist) - One or more directories as arguments
- FileDirectory - (alias parent) - A file whose directory exists in the file system but which may or may not exist.
- RealDirectory - (alias realdir) - The real path of a directory which must exist.
- RealFile - (alias real) - The real path of a file which must exist.
- RemoteDirectory - (alias remotedir) - The path to a directory on a remote host.

#### Application-relative

- ApplicationDirectory - (alias appdir) - A directory path relative to BUILD_HOME
- ApplicationFile - (alias appfile) - A file path relative to BUILD_HOME
- ApplicationDirectoryList - (alias appdirlist) - One or more arguments of type ApplicationDirectory

#### Functional

- Function - (alias function) - A defined function
- Callable - (alias callable) - A function or executable
- Executable - (alias bin) - Any binary available within the PATH

#### Lists

- Array - (no aliases) - Zero or more arguments
- List - (no  aliases) - Zero or more arguments
- ColonDelimitedList - (alias list:) - A colon-delimited list :
- CommaDelimitedList - (alias list,) - A comma-delimited list ,

You can repeat the type name value more than once in the arguments and each will be checked until one fails
Return Code: 0 - Valid is valid, stdout is a filtered version of the value to be used
Return Code: 2 - Valid is invalid, output reason to stderr

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
