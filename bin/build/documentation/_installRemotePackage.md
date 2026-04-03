### Arguments

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

### Return codes

- `1` - Environment error
- `2` - Argument error

### Requires

cp rm cat printf fileRealPath executableExists returnMessage fileTemporaryName catchArgument throwArgument catchEnvironment decorate validate isFunction __decorateExtensionQuote

