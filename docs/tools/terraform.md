# Terraform

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />


### `aptKeyAddHashicorp` - Add keys to enable apt to download terraform directly from

Add keys to enable apt to download terraform directly from hashicorp.com

#### Usage

    aptKeyAddHashicorp
    

#### Exit codes

- `1` - if environment is awry
- `0` - All good to install terraform

### `aptKeyRemoveHashicorp` - Add keys to enable apt to download terraform directly from

Add keys to enable apt to download terraform directly from hashicorp.com

#### Usage

    aptKeyAddHashicorp
    

#### Exit codes

- `1` - if environment is awry
- `0` - All good to install terraform

### `terraformInstall` - Install terraform binary

Install terraform binary

#### Usage

    terraformInstall [ package ... ]
    

#### Arguments



#### Exit codes

- `1` - Problems
- `0` - Installed successfully

### `terraformUninstall` - Remove terraform binary

Remove terraform binary

#### Usage

    terraformUninstall [ package ... ]
    

#### Arguments



#### Exit codes

- `0` - Always succeeds
