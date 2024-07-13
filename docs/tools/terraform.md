# Terraform

For systems with an `/etc/init.d` start up script system.

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)


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

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)
