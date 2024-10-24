# Terraform

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

### `terraformInstall` - Install terraform binary

Install terraform binary

- Location: `bin/build/tools/terraform.sh`

#### Arguments

- `package` - Additional packages to install using `packageInstall`

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `terraformUninstall` - Remove terraform binary

Remove terraform binary

- Location: `bin/build/tools/terraform.sh`

#### Arguments

- `package` - Additional packages to uninstall using `packageUninstall`

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

## Support functions

### `aptKeyAddHashicorp` - Add keys to enable apt to download terraform directly from

Add keys to enable apt to download terraform directly from hashicorp.com

- Location: `bin/build/tools/terraform.sh`

#### Usage

    aptKeyAddHashicorp
    

#### Arguments

- No arguments.

#### Exit codes

- `1` - if environment is awry
- `0` - All good to install terraform
### `aptKeyRemoveHashicorp` - Add keys to enable apt to download terraform directly from

Add keys to enable apt to download terraform directly from hashicorp.com

- Location: `bin/build/tools/terraform.sh`

#### Usage

    aptKeyAddHashicorp
    

#### Arguments

- No arguments.

#### Exit codes

- `1` - if environment is awry
- `0` - All good to install terraform
