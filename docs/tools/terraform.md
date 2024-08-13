# Terraform

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

### `aptKeyAddHashicorp` - Add keys to enable apt to download terraform directly from

Add keys to enable apt to download terraform directly from hashicorp.com

#### Usage

    aptKeyAddHashicorp
    

#### Arguments

- No arguments.

#### Exit codes

- `1` - if environment is awry
- `0` - All good to install terraform
### `aptKeyRemoveHashicorp` - Add keys to enable apt to download terraform directly from

Add keys to enable apt to download terraform directly from hashicorp.com

#### Usage

    aptKeyAddHashicorp
    

#### Arguments

- No arguments.

#### Exit codes

- `1` - if environment is awry
- `0` - All good to install terraform
### `terraformInstall` - Install terraform binary

Install terraform binary

#### Usage

    terraformInstall [ package ... ]
    

#### Arguments

- `package` - Additional packages to install using `aptInstall`

#### Exit codes

- `1` - Problems
- `0` - Installed successfully
### `terraformUninstall` - Remove terraform binary

Remove terraform binary

#### Arguments

- `package` - Additional packages to uninstall using `aptUninstall`

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
