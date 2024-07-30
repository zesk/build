# apt Package Manager Tools

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)


### `aptUpdateOnce` - Do `apt-get update` once

Run apt-get update once and only once in the pipeline, at least
once an hour as well (when testing)

#### Usage

    aptUpdateOnce [ --force ]
    

#### Arguments



#### Exit codes

- `0` - Always succeeds

#### Environment

Stores state files in `./.build/` directory which is created if it does not exist.

### `whichApt` - Install tools using `apt-get` if they are not found

Installs an apt package if a binary does not exist in the which path.
The assumption here is that `aptInstallPackage` will install the desired `binary`.

Confirms that `binary` is installed after installation succeeds.

#### Usage

    whichApt binary aptInstallPackage ...
    

#### Arguments



#### Examples

    whichApt shellcheck shellcheck
    whichApt mariadb mariadb-client

#### Exit codes

- `0` - Always succeeds

#### Environment

Technically this will install the binary and any related files as a package.

### `whichAptUninstall` - Install tools using `apt-get` if they are not found

Installs an apt package if a binary does not exist in the which path.
The assumption here is that `aptInstallPackage` will install the desired `binary`.

Confirms that `binary` is installed after installation succeeds.

#### Usage

    whichAptUninstall binary aptInstallPackage ...
    

#### Arguments



#### Examples

    whichApt shellcheck shellcheck
    whichApt mariadb mariadb-client

#### Exit codes

- `0` - Always succeeds

#### Environment

Technically this will install the binary and any related files as a package.

### `aptInstall` - Install packages using `apt-get`

Install packages using `apt-get`. If `apt-get` is not available, this succeeds
and assumes packages will be available.



#### Usage

    aptInstall [ package ... ]
    

#### Arguments



#### Examples

    aptInstall shellcheck

#### Exit codes

- `0` - If `apt-get` is not installed, returns 0.
- `1` - If `apt-get` fails to install the packages

### `aptUpToDate` - OS upgrade and potential restart

OS upgrade and potential restart
Progress is written to stderr
Result is `ok` or `restart` written to stdout

#### Usage

    aptUpToDate
    

#### Exit codes

- `0` - Success
- `1` - Failed due to issues with environment

### `aptKeyAdd` - Add keys to enable apt to download terraform directly from

Add keys to enable apt to download terraform directly from hashicorp.com

#### Usage

    aptKeyAdd --name keyName [ --title title ] remoteUrl
    

#### Arguments



#### Exit codes

- `1` - if environment is awry
- `0` - Apt key is installed AOK

### `aptKeyRemoveHashicorp` - Add keys to enable apt to download terraform directly from

Add keys to enable apt to download terraform directly from hashicorp.com

#### Usage

    aptKeyAddHashicorp
    

#### Exit codes

- `1` - if environment is awry
- `0` - All good to install terraform

### `aptKeyRemove` - Remove apt keys

Remove apt keys

#### Usage

    aptKeyRemove keyName [ ... ]
    

#### Arguments



#### Exit codes

- `1` - if environment is awry
- `0` - Apt key is installed AOK

### `aptListInstalled` - List installed packages

List installed packages

#### Usage

    aptListInstalled
    

#### Exit codes

- `0` - Always succeeds

### `aptNeedRestartFlag` - INTERNAL - has `aptUpToDate` set the `restart` flag at some

INTERNAL - has `aptUpToDate` set the `restart` flag at some point?

#### Usage

    aptNeedRestartFlag [ value ]
    

#### Arguments



#### Exit codes

- `0` - Always succeeds

### `aptUninstall` - Removes packages using `apt-get`

Removes packages using `apt-get`. If `apt-get` is not available, this succeeds
and assumes packages will be available. (For now)

#### Usage

    aptUninstall [ package ... ]
    

#### Arguments



#### Examples

    aptInstall shellcheck

#### Exit codes

- `0` - If `apt-get` is not installed, returns 0.
- `1` - If `apt-get` fails to remove the packages

<!-- TEMPLATE footer 5 -->
<hr />

[⬅ Top](index.md) [⬅ Parent ](../index.md)

Copyright &copy; 2024 [Market Acumen, Inc.](https://marketacumen.com?crcat=code&crsource=zesk/build&crcampaign=docs&crkw=apt Package Manager Functions)
