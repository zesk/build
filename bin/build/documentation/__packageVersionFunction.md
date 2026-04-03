## `packageVersionFunction`

> Used to check the remote version against the local version

### Usage

    packageVersionFunction handler applicationHome installPath [ fixedVersion ]

Used to check the remote version against the local version of a package to be installed.
`versionFunction` should exit 0 to halt the installation, in addition it should output the current version as a decorated string.

### Arguments

- `handler` - Function. Required. Function to call when an error occurs. Signature `errorHandler`.
- `applicationHome` - Directory. Required. Path to the application home where target will be installed, or is installed. (e.g. myApp/)
- `installPath` - Directory. Required. Path to the installPath home where target will be installed, or is installed. (e.g. myApp/bin/build)
- `fixedVersion` - EmptyString. Optional. If a fixed version is requested this is the requested version.

### Writes to standard output

version information

### Return codes

- `0` - Do not upgrade, version is same as remote (stdout is found, current version)
- `1` - Do upgrade, version changed. (stdout is version change details)

