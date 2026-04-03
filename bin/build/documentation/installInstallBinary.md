## `installInstallBinary`

> Installs an installer the first time in a new project,

### Usage

    installInstallBinary [ --diff ] [ --url ] [ --url-function ] --source [ --local ] --bin [ path ] [ applicationHome ] [ --help ]

Installs an installer the first time in a new project, and modifies it to work in the application path.

### Arguments

- `--diff` - Flag. Optional. Show differences between new and old files if changed.
- `--url` - URL. Optional. A remote URL to download the installation script.
- `--url-function` - Callable. Optional. Fetch the remote URL where the installation script is found.
- `--source` - File. Required. The local copy of the `--bin` file.
- `--local` - Flag. Optional. Use local copy `--bin` instead of downloaded version.
- `--bin` - String. Required. Name of the installer file.
- `path` - Directory. Optional. Path to install the binary. Default is `bin`. If ends with `.sh` will name the binary this name.
- `applicationHome` - Directory. Optional. Path to the application home directory. Default is current directory.
- `--help` - Flag. Optional. Display this help.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

