### `tofuUninstall`

> Uninstall tofu binary and apt sources keys

#### Usage

    tofuUninstall [ package ] [ --help ]

Uninstall tofu binary and apt sources keys

> Location: `bin/build/tools/tofu.sh`

#### Arguments

- `package` - String. Optional. Additional packages to uninstall using `packageUninstall`
- `--help` - Flag. Optional. Display this help.

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### See Also

- [tofuInstall]({rel}tools/tofu.md#tofuinstall) - Install tofu binary ([source](https://github.com/zesk/build/blob/main/bin/build/tools/tofu.sh#L59))
- [packageUninstall]({rel}tools/package.md#packageuninstall) - Removes packages using package manager ([source](https://github.com/zesk/build/blob/main/bin/build/tools/package.sh#L524))

