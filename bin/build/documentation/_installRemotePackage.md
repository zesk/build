#### Arguments

- `--help` - Flag. Optional. Display this help.
- `relative` - RelativePath. Required. Path from this script to our application root. INTERNAL.
- `defaultPackagePath` - RelativePath. Required. Path from application root to where the package should be installed. INTERNAL.
- `packageInstallerName` - ApplicationFile. Required. The new installer file, post installation, relative to the `installationPath`. INTERNAL.
- `installationPath` - ApplicationDirectory. Optional. Path to where the package should be installed instead of the defaultPackagePath.
- `--help` - Flag. Optional. Display this help.
- `--source source` - String. Optional. Source to display for the binary name. INTERNAL.
- `--name name` - String. Optional. Name to display for the remote package name. INTERNAL.
- `--local localPackageDirectory` - Directory. Optional. Directory of an existing installation to mock behavior for testing. INTERNAL.
- `--url url` - URL. Optional. URL of a tar.gz file. Download source code from here.
- `--user username` - String. Optional. Add `username:password` to remote request.
- `--password passwordText` - String. Optional. Add `username:password` to remote request.
- `--header headerText` - String. Optional. Add one or more headers to the remote request.
- `--version-function urlFunction` - Function. Optional. Function to compare live version to local version. Exits 0 if they match. Output version text if you want. INTERNAL.
- `--version version` - String. Optional. Download just **this** version of Zesk Build. Prevents stable breaking with new versions of Zesk Build.
- `--url-function urlFunction` - Function. Optional. Function to return the URL to download. INTERNAL.
- `--check-function checkFunction` - Function. Optional. Function to check the installation and output the version number or package name. INTERNAL.
- `--installer installer` - Executable. Optional. Multiple. Binary to run after installation succeeds. Can be supplied multiple times. If `installer` begins with a `@` then any errors by the installer are ignored.
- `--replace file` - File. Optional. Replace the target file with this script and delete this one. Internal only, do not use. INTERNAL.
- `--finalize file` - File. Optional. Remove the temporary file and exit 0. INTERNAL.
- `--debug` - Flag. Optional. Debugging is on. INTERNAL.
- `--force` - Flag. Optional. Force installation even if file is up to date.
- `--skip-self` - Flag. Optional. Skip the installation script self-update. (By default it is enabled.)
- `--diff` - Flag. Optional. Show differences between old and new file.

#### Return codes

- `1` - Environment error
- `2` - Argument error

#### Requires

- [`cp`]({rel}guide/command.md#cp)
- [`rm`]({rel}guide/command.md#rm)
- [`cat`]({rel}guide/command.md#cat)
- [`printf`]({rel}guide/builtin.md#printf)
- [fileRealPath]({rel}tools/file.md#filerealpath) - Find the full, actual path of a file avoiding symlinks ([source](https://github.com/zesk/build/blob/main/bin/build/tools/file.sh#L435))
- [executableExists]({rel}tools/bash.md#executableexists) - Does a binary exist in the PATH? ([source](https://github.com/zesk/build/blob/main/bin/build/tools/platform.sh#L174))
- [returnMessage]({rel}tools/sugar-core.md#returnmessage) - Return passed in integer return code and output message to ([source](https://github.com/zesk/build/blob/main/bin/build/tools/example.sh#L143))
- [fileTemporaryName]({rel}tools/file.md#filetemporaryname) - Wrapper for \`mktemp\`. Generate a temporary file name, and fail ([source](https://github.com/zesk/build/blob/main/bin/build/tools/file.sh#L944))
- [catchArgument]({rel}tools/sugar-core.md#catchargument) - Run \`command\`, upon failure run \`handler\` with an argument error ([source](https://github.com/zesk/build/blob/main/bin/build/tools/_sugar.sh#L238))
- [throwArgument]({rel}tools/sugar-core.md#throwargument) - Run \`handler\` with an argument error ([source](https://github.com/zesk/build/blob/main/bin/build/tools/_sugar.sh#L215))
- [catchEnvironment]({rel}tools/sugar-core.md#catchenvironment) - Run \`command\`, upon failure run \`handler\` with an environment error ([source](https://github.com/zesk/build/blob/main/bin/build/tools/_sugar.sh#L247))
- [decorate]({rel}tools/decorate.md#decorate) - Singular decoration function ([source](https://github.com/zesk/build/blob/main/bin/build/tools/decorate/core.sh#L89))
- [validate]({rel}tools/validate.md#validate) - Validate a value by type ([source](https://github.com/zesk/build/blob/main/bin/build/tools/validate.sh#L95))
- [isFunction]({rel}tools/type.md#isfunction) - Test if argument are bash functions ([source](https://github.com/zesk/build/blob/main/bin/build/tools/type.sh#L177))

