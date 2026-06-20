### `tofuInstall`

> Install tofu binary

#### Usage

    tofuInstall [ package ] [ --help ]

Install tofu binary

> Location: `bin/build/tools/tofu.sh`

#### Arguments

- `package` - String. Optional. Additional packages to install using `packageInstall`
- `--help` - Flag. Optional. Display this help.

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### See Also

- {SEE:tofuUninstall}
- [packageInstall]({rel}tools/package.md#packageinstall) - Install packages using a package manager ([source](https://github.com/zesk/build/blob/main/bin/build/tools/package.sh#L377))

