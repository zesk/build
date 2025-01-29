# OpenTOFU

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

### `tofuInstall` - Install tofu binary

Install tofu binary

- Location: `bin/build/tools/tofu.sh`

#### Usage

_mapEnvironment

#### Arguments

- `package` - Additional packages to install using `packageInstall`

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `tofuUninstall` - Uninstall tofu binary and apt sources keys

Uninstall tofu binary and apt sources keys

- Location: `bin/build/tools/tofu.sh`

#### Usage

_mapEnvironment

#### Arguments

- `package` - Additional packages to uninstall using `packageUninstall`

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

## Support functions

### `aptKeyAddOpenTofu` - Add keys to enable apt to download tofu directly from

Add keys to enable apt to download tofu directly from hashicorp.com

- Location: `bin/build/tools/tofu.sh`

#### Usage

_mapEnvironment

#### Arguments

- No arguments.

#### Exit codes

- `1` - if environment is awry
- `0` - All good to install terraform
### `aptKeyRemoveOpenTofu` - Add keys to enable apt to download tofu directly from

Add keys to enable apt to download tofu directly from hashicorp.com

- Location: `bin/build/tools/tofu.sh`

#### Usage

_mapEnvironment

#### Arguments

- No arguments.

#### Exit codes

- `1` - Environment problems
- `0` - All good to install tofu
