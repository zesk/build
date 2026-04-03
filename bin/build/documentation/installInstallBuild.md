## `installInstallBuild`

> Installs `install-bin-build.sh` the first time in a new project, and

### Usage

    installInstallBuild [ --help ] [ --diff ] [ --local ] [ path ] [ applicationHome ] [ --help ]

Installs `install-bin-build.sh` the first time in a new project, and modifies it to work in the application path.

### Arguments

- `--help` - Flag. Optional. This help.
- `--diff` - Flag. Optional. Show differences between new and old files if changed.
- `--local` - Flag. Optional. Use local copy of `install-bin-build.sh` instead of downloaded version.
- `path` - Directory. Optional. Path to install the binary. Default is `bin`. If ends with `.sh` will name the binary this name.
- `applicationHome` - Directory. Optional. Path to the application home directory. Default is current directory.
- `--help` - Flag. Optional. Display this help.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

